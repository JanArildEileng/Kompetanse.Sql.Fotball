With
Results_CTE as (
select 
   CONVERT(date,substring(Date,7,4)+'-'+substring(Date,4,2)+'-'+substring(Date,1,2)) as  MatchDato,
   HomeTeam,
   AwayTeam,
   CAST ( FTHG AS int ) as FTHG,
   CAST ( FTAG AS int ) as FTAG
from [Football].[dbo].[E02017] 
)

select
   *,
   Row_Number()  OVER (PARTITION BY HomeTeam ORDER BY (FTHG-FTAG) desc,FTHG desc) as BestHomeMatchRank
from Results_CTE