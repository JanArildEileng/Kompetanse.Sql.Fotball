With
Results_CTE as (
select 
   CONVERT(datetime2,substring(Date,7,4)+'-'+substring(Date,4,2)+'-'+substring(Date,1,2)) as  MatchDato,
   HomeTeam,
   AwayTeam,
   CAST ( FTHG AS int ) as FTHG,
   CAST ( FTAG AS int ) as FTAG
from [Football].[dbo].[E02017] 
)

select
   YEAR(MatchDato) as Year,
   MONTH(MatchDato) as Month,
   COUNT(*) as NumberOfMatches
FROM Results_CTE
GROUP BY YEAR(MatchDato),MONTH(MatchDato)
order by Year
