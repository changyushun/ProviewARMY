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
CREATE PROCEDURE Ex108_GetResultData
	-- Add the parameters for the stored procedure here
	(
		@id nvarchar(10)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select sid,id, name, age, CONVERT(nvarchar(10),r.birth,111) as 'birth', (case when gender = 'M' then '╧' when gender = 'F' then '' end) as gender, 
		(case when substring(memo,1,1) = '0' then (case when sit_ups is null then 'ゼ代' else CONVERT(nvarchar(10),sit_ups)end)
			  when substring(memo,1,1) != '0'then (select rep_title + ':' from repment where sid = substring(memo,1,1)) + (case when sit_ups is not null then CONVERT(nvarchar(10),sit_ups) when sit_ups is null then 'ゼ代' else '' end) end) as sit_ups , 
		(case when substring(memo,1,1) = '0' then (case when sit_ups_score = 999 then '-' when sit_ups_score is null then '-' else CONVERT(nvarchar(10), sit_ups_score)end) 
			  when substring(memo,1,1) != '0'then (case when sit_ups_score = 999 then '-' when sit_ups_score = 9999 then '-' when sit_ups_score = 100 then '' when sit_ups_score = 0 then 'ぃ' when sit_ups_score is null then '-' else CONVERT(nvarchar(10), sit_ups_score)end)end) as sit_ups_score, 
		(case when substring(memo,2,1) = '0' then (case when push_ups is null then 'ゼ代' else CONVERT(nvarchar(10),push_ups)end)
			  when substring(memo,2,1) != '0'then (select rep_title + ':' from repment where sid = substring(memo,2,1)) + (case when push_ups is not null then CONVERT(nvarchar(10),push_ups) when push_ups is null then 'ゼ代' else '' end) end) as push_ups, 
		(case when substring(memo,2,1) = '0' then (case when push_ups_score = 999 then '-' when push_ups_score is null then '-' else CONVERT(nvarchar(10), push_ups_score)end) 
			  when substring(memo,2,1) != '0'then (case when push_ups_score = 999 then '-' when push_ups_score = 9999 then '-' when push_ups_score = 100 then '' when push_ups_score = 0 then 'ぃ' when push_ups_score is null then '-' else CONVERT(nvarchar(10), push_ups_score)end)end) as push_ups_score,
		(case when substring(memo,3,1) = '0' then (case when run is null and (run_score = 9999 or run_score is null) then 'ゼ代' when run = 9999 and (run_score = 9999 or run_score is null) then '-' else CONVERT(nvarchar(10),run/60)+':'+CONVERT(nvarchar(10),run%60) end)
			  when substring(memo,3,1) != '0'then (select rep_title + ':' from repment where sid = substring(memo,3,1)) + (case when run is not null then CONVERT(nvarchar(10),run) when run is null then 'ゼ代' else '' end) end) as run, 
		(case when substring(memo,3,1) = '0' then (case when (run is null or run is not null) and run_score = 9999 then '-' when run = 9999 and (run_score = 9999 or run_score is null) then 'ゼЧ代' when run_score is null then '-' else CONVERT(nvarchar(10), run_score)end) 
		      when substring(memo,3,1) != '0'then (case when run_score = 999 then '-' when run_score = 9999 then '-' when run_score = 100 then '' when run_score = 0 then 'ぃ' when run_score is null then '-' else CONVERT(nvarchar(10), run_score)end)end) as run_score,
		CONVERT(nvarchar(10),r.date,111) as 'date',(select c.center_name from Center c where c.center_code = r.center_code ) as center_name,
		(case when result = '222' then (select meaning from statuscode s where s.code = r.status ) + '()'  else  (select meaning from statuscode s where s.code = r.status ) end) as status, memo
		from Result r where r.id = @id and r.status in('202','203')  order by date desc 
END
GO
