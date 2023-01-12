/*
declare  @START_TEAM nvarchar(50) = 'Man United';
declare  @MAXINDRECTLEVEL int = 2;
*/
declare  @START_TEAM nvarchar(50) = 'West Ham';
declare  @MAXINDRECTLEVEL int = 3;


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
AwayWin_CTE as (
select 
  HomeTeam,AwayTeam
 FROM ResultsWithPoints_CTE 
 where AwayPoints=3
),

ManUnited_CTE as (
  select HomeTeam,AwayTeam , 1 as Level from AwayWin_CTE 
    where AwayTeam=@START_TEAM 
  union  all
   select a.HomeTeam,a.AwayTeam , Level+1 as Level
      from ManUnited_CTE m
      JOIN AwayWin_CTE a on a.AwayTeam=m.HomeTeam
     where Level< @MAXINDRECTLEVEL and a.HomeTeam <>@START_TEAM
)

select HomeTeam,min(level) as IndirectLevel from ManUnited_CTE
Group by HomeTeam
order by IndirectLevel