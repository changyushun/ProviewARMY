-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
use Main
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Ex108_UpdatePlayerData 
	-- Add the parameters for the stored procedure here
	(
	@sid nvarchar(10),
	@name nvarchar(10),
	@id nvarchar(10),
	@birth nvarchar(10),
	@mail nvarchar(20),
	@password nvarchar(16)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Player set name=@name,id=@id,birth=@birth,mail=@mail,password=@password where sid=@sid
END
GO
