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
USE Main
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Ex108_GetResultDataBySid 
	(
	@sid nvarchar(10)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select sid,id, name,CONVERT(nvarchar(10),birth,111) as 'birth', age,
        --���ئW��
        (case when substring(memo,1,1) = '0' then '���װ_��'
			  when substring(memo,1,1) != '0'then (select rep_title  from repment where sid = substring(memo,1,1))end) as sit_ups_name ,
	    (case when substring(memo,2,1) = '0' then '���a����'
			  when substring(memo,2,1) != '0'then (select rep_title  from repment where sid = substring(memo,2,1))end) as push_ups_name ,
	    (case when substring(memo,3,1) = '0' then '�T�d���ض]�B'
			  when substring(memo,3,1) != '0'then (select rep_title  from repment where sid = substring(memo,3,1))end) as run_name , 
		--���ئ�/���
		sit_ups,push_ups,run,
		--���ئ��Z
		sit_ups_score,push_ups_score,run_score,
		status, memo
		from Result  where sid = @sid and status in('202','203')  order by date desc 
END
GO
