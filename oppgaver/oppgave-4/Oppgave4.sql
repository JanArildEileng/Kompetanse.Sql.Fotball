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
)

select 
   Team, Sum(Points) as TotalPoints
from (
	  select 
	     HomeTeam as Team , HomePoints as Points
	  from ResultsWithPoints_CTE
	  Union all
	  select 
	     AwayTeam as Team , AwayPoints as Points
	  from ResultsWithPoints_CTE
	) x
GROUP BY Team
ORDER BY TotalPoints desc
