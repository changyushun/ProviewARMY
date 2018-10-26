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
CREATE PROCEDURE Ex108_UpdateResultData 
	-- Add the parameters for the stored procedure here
	(
	@sid nvarchar(10),
	@name nvarchar(10),
	@birth nvarchar(10),
	@age nvarchar(3),
	@sit_ups nvarchar(4),
	@push_ups nvarchar(4),
	@run nvarchar(4),
	@sit_ups_score nvarchar(4),
	@push_ups_score nvarchar(4),
	@run_score nvarchar(4),
	@status nvarchar(3)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Result set name=@name,birth=@birth,age=@age,sit_ups=@sit_ups,sit_ups_score=@sit_ups_score
	,push_ups=@push_ups,push_ups_score=@push_ups_score,run=@run,run_score=@run_score,status=@status where sid=@sid
END
GO
