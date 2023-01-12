With
Results_CTE as (
select 
   CONVERT(date,substring(Date,7,4)+'-'+substring(Date,4,2)+'-'+substring(Date,1,2)) as  MatchDato,
   HomeTeam,
   AwayTeam,
   CAST ( FTHG AS int ) as FTHG,
   CAST ( FTAG AS int ) as FTAG
from [Football].[dbo].[E02017] 
),
WIN_CTE as (
 Select 
  Team,MatchDato,NoWon
from
(
select
   HomeTeam as Team,MatchDato ,case when FTHG> FTAG THEN 0 ELSE 1 END as NoWon  
from Results_CTE
UNION All
Select
   AwayTeam as Team,MatchDato,case when FTHG< FTAG THEN 0 ELSE 1 END as NoWon 
from Results_CTE
) x

),
TotalNoWins_CTE as 
(
  Select 
   * ,
	 SUM(NoWon)  OVER (PARTITION BY Team ORDER BY MatchDato) as TotalNoWins
 from WIN_CTE
),
CountWins_CTE as
(
   select  
     Team,
	 COUNT(TotalNoWins)-1 as CountTotalWins
   from TotalNoWins_CTE  
   GROUP BY Team,TotalNoWins
)

select Team,  CountTotalWins
FROM (
     select *,
        Row_Number()  OVER (PARTITION BY Team ORDER BY CountTotalWins desc) as Number
    from
    CountWins_CTE
) y
where Number =1
order by CountTotalWins desc