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
CREATE PROCEDURE Ex108_GetNear60DayResult 
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
	select sid,id,name,CONVERT(nvarchar(10),date,111)as 'date',(select meaning  from StatusCode where code = status)as 'status' from Result
    where id=@id and date>=GETDATE()-62 and status like '2__' order by date asc
END
GO
