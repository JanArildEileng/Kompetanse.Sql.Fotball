With
Results_CTE as (
select 
   CONVERT(datetime2,substring(Date,7,4)+'-'+substring(Date,4,2)+'-'+substring(Date,1,2)) as  MatchDato,
   HomeTeam,
   AwayTeam,
   CAST ( FTHG AS int ) as FTHG,
   CAST ( FTAG AS int ) as FTAG
from [Football].[dbo].[E02017] 
),
ResultsWithPoints_CTE as (
select 
  *,
  CASE 
	 When FTHG>FTAG THEN 3 
	 When FTHG=FTAG THEN 1
	 When FTHG<FTAG THEN 0
  END  as HomePoints,
  CASE 
	 When FTHG>FTAG THEN 0 
	 When FTHG=FTAG THEN 1
	 When FTHG <FTAG THEN 3
  END  as AwayPoints
 FROM Results_CTE 
),


ResultsWithTotalHomeLoss_CTE as
(
select 
 *, 
Row_Number()  OVER (PARTITION BY HomeTeam ORDER BY MatchDato) as HomeMatchNr,
SUM(case When (HomePoints=0) Then 1 else 0 end)  OVER (PARTITION BY HomeTeam ORDER BY MatchDato) as TotalHomeLoss

FROM ResultsWithPoints_CTE
),

HomeLoss_CTE as 
(
select 
HomeTeam,
COUNT(HomeMatchNr-TotalHomeLoss)-1 as NumberContinuesHomeLoss,
MIN(HomeMatchNr)+1 as StartHomeLossMatchNr,
MAX(HomeMatchNr) as EndHomeLossMatchNr


FROM ResultsWithTotalHomeLoss_CTE
Group BY HomeTeam,(HomeMatchNr-TotalHomeLoss)
having COUNT(HomeMatchNr-TotalHomeLoss)>2
)

select 
HomeTeam, COUNT(*) as NumberContinuesLossPeriodes 
from HomeLoss_CTE
Group By HomeTeam
having COUNT(*) >1
order by NumberContinuesLossPeriodes desc