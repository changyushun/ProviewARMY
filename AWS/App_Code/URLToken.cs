using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace Lib
{
    public class URLToken
    {
        private static byte[] Key { get; set; }
        private static string ThirdAttribute { get; set; }
        public URLToken() 
        {
            Key = HexDataToBA("D79FE5E817063827B3163A8597974E2655031C9DF4D06300AC714F7E0C8E49B1");
            ThirdAttribute = @"12977341";
        }

        public string GenToken(string ID, DateTime Time)
        {
            using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
            {
                myAes.Key = Key;
                myAes.IV = HexDataToBA("00000000000000000000000000000000");
                StringBuilder original = new StringBuilder();
                original.Append(ID);
                original.Append(",");
                original.Append(Time.ToString("yyyyMMddHHmmss"));
                original.Append(",");
                original.Append(ThirdAttribute);
                byte[] encrypted = EncryptStringToBytes_Aes(original.ToString(), myAes.Key, myAes.IV);
                return ToHexString(encrypted);
            }            
        }

        public bool VerifyToken(string ID, string Token, DateTime VerifyDate, ref string Msg)
        {
            //解密Token後, 取得身份證字號與時間
            string original = string.Empty;
            try
            {
                using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
                {
                    myAes.Key = Key;
                    myAes.IV = HexDataToBA("00000000000000000000000000000000");
                    original = DecryptStringFromBytes_Aes(HexDataToBA(Token), myAes.Key, myAes.IV);                    
                }               
            }
            catch (Exception ex)
            {
                Msg = @"Code[101]";
                return false;
            }

            try
            {
                if (!string.IsNullOrEmpty(original))
                {
                    string[] operater = { "," };
                    string[] info = original.Split(operater, StringSplitOptions.None);
                    if (info[0] != ID)
                    {
                        return false;
                    }
                    if (info[1].Length == 14)
                    {   //yyyyMMddHHmmss
                        string formatString = "yyyyMMddHHmmss";
                        DateTime RequestDate = DateTime.ParseExact(info[1], formatString, null);
                        TimeSpan Diff = VerifyDate - RequestDate;
                        if (Diff.Days > 2 && Diff.Hours > 0 &&  Diff.Seconds > 0 )
                        {
                            //Msg = @"連結已逾期，請重發忘記密碼函。";
                            Msg = @"Code[100]";
                            return false;
                        }
                    }
                    else
                    {
                        //Msg = @"錯誤[101]，使用無效連結，系統將通知管理員。";
                        Msg = @"Code[101]";
                        return false;
                    }
                    if (info[2] != ThirdAttribute)
                    {
                        //Msg = @"錯誤[102]，使用無效連結，系統將通知管理員。";
                        Msg = @"Code[102]";
                        return false;
                    }
                }
                else
                {
                    //Msg = @"錯誤[103]，使用無效連結，系統將通知管理員。";
                    Msg = @"Code[103]";
                    return false;
                }
            }
            catch (Exception ex)
            {
                Msg = @"Code[103]";
                return false;
            }
            //finally return true;
            return true;    
        }

        private static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");
            byte[] encrypted;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for encryption. 
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }
            // Return the encrypted bytes from the memory stream. 
            return encrypted;
        }

        private static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");
            // Declare the string used to hold 
            // the decrypted text.
            string plaintext = null;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for decryption. 
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            // Read the decrypted bytes from the decrypting stream 
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            return plaintext;
        }

        /// <summary>
        /// 將16進位的字串組轉換成byte[], 來源字串經過將空白取代為string.empty的處理後才轉換成byte[]
        /// </summary>
        /// <param name="_source">要轉換的來源字串組</param>
        /// <returns></returns>
        private static byte[] HexDataToBA(string _source)
        {
            string temp = _source.Replace(" ", string.Empty);
            byte[] _result = new byte[temp.Length / 2];
            char[] source = temp.ToCharArray();

            for (int i = 0, ii = 0; i < source.Length; ii++, i += 2)
            {
                _result[ii] = (byte)(HexValue(source[i]) * 16 + HexValue(source[i + 1]));
            }
            return _result;
        }

        /// <summary>
        /// 將16進位字元轉換回傳10進位的數字
        /// </summary>
        /// <param name="source">來源資料型態為字元</param>
        /// <returns></returns>
        private static int HexValue(char source)
        {
            int value = 0;
            switch (source.ToString().ToUpper())
            {
                case "1":
                    value = 1;
                    break;
                case "2":
                    value = 2;
                    break;
                case "3":
                    value = 3;
                    break;
                case "4":
                    value = 4;
                    break;
                case "5":
                    value = 5;
                    break;
                case "6":
                    value = 6;
                    break;
                case "7":
                    value = 7;
                    break;
                case "8":
                    value = 8;
                    break;
                case "9":
                    value = 9;
                    break;
                case "A":
                    value = 10;
                    break;
                case "B":
                    value = 11;
                    break;
                case "C":
                    value = 12;
                    break;
                case "D":
                    value = 13;
                    break;
                case "E":
                    value = 14;
                    break;
                case "F":
                    value = 15;
                    break;
                default:
                    break;
            }
            return value;
        }

        private static string ToHexString(byte[] bytes) // 0xae00cf => "AE00CF "
        {
            string hexString = string.Empty;
            if (bytes != null)
            {
                StringBuilder strB = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    strB.Append(bytes[i].ToString("X2"));
                }
                hexString = strB.ToString();
            }
            return hexString;
        }
    }
}
