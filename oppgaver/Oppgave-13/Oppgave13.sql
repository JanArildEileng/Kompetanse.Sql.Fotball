
DECLARE @STARTDATE      DATE;
DECLARE @ENDDATE        DATE;
SET @STARTDATE =  '2017-01-01';   
SELECT  @ENDDATE =DATEADD(MONTH,23,@STARTDATE );

WITH DATES_CTE([DATE])   
AS
(
   SELECT @STARTDATE AS [DATE]
   UNION ALL
   SELECT DATEADD(MONTH,1, [DATE] )
   FROM DATES_CTE 
   WHERE [DATE] < @ENDDATE	
),
Results_CTE as (
select 
   CONVERT(datetime2,substring(Date,7,4)+'-'+substring(Date,4,2)+'-'+substring(Date,1,2)) as  MatchDato,
   HomeTeam,
   AwayTeam,
   CAST ( FTHG AS int ) as FTHG,
   CAST ( FTAG AS int ) as FTAG
from [Football].[dbo].[E02017] 
)

Select 
 allDates.Year,
 allDates.Month,
 ISNULL(NumberOfMatches,0 ) as NumberOfMatches
 from ( 
   Select 
     YEAR(dc.DATE) as year , 
     MONTH(dc.DATE) as Month
   FROM DATES_CTE dc
 ) allDates
left join  (
   select
     YEAR(MatchDato) as Year,
     MONTH(MatchDato) as Month,
     COUNT(*) as NumberOfMatches
   FROM Results_CTE r 
   GROUP BY YEAR(MatchDato),MONTH(MatchDato)
)  matchMonth on matchMonth.year=allDates.Year and matchMonth.Month=allDates.Month

order by allDates.Year,allDates.Month