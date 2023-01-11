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

City_Teams_CTE As 
(
  Select 'Arsenal' as Team,'London' as City
  union
  Select 'Chelsea' as Team,'London' as City
   union
  Select 'Crystal Palace' as Team,'London' as City
   union
  Select 'Tottenham' as Team,'London' as City
   union
  Select 'Watford' as Team,'London' as City
    union
  Select 'West Ham' as Team,'London' as City
),
Only_LondonTeamMatches_CTE As 
(
  select *
  from ResultsWithPoints_CTE r
  where r.HomeTeam in ( select Team from City_Teams_CTE) and r.AwayTeam In (select Team from City_Teams_CTE)
)

select 
   Team, Sum(Points) as TotalPoints
from (
	  select 
	     HomeTeam as Team , HomePoints as Points
	  from Only_LondonTeamMatches_CTE
	  Union all
	  select 
	     AwayTeam as Team , AwayPoints as Points
	  from Only_LondonTeamMatches_CTE
	) x
GROUP BY Team
ORDER BY TotalPoints desc