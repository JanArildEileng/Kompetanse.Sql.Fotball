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


ResultsWithHomeMatchNr_CTE as
(
select 
 *, 
Row_Number()  OVER (PARTITION BY HomeTeam ORDER BY MatchDato) as HomeMatchNr
FROM ResultsWithPoints_CTE


),
ResultsWithHomeMatchNr5_10_CTE as
(
   select * from ResultsWithHomeMatchNr_CTE
   where HomeMatchNr>=6 and HomeMatchNr<=10
)


select 
  *,
  RANK() Over (ORDER BY TotalPoints desc) as Rank
FROM (
	select 
		HomeTeam as Team , 
		SUM(HomePoints) as TotalPoints
		
	from ResultsWithHomeMatchNr5_10_CTE
	GROUP BY HomeTeam
) x