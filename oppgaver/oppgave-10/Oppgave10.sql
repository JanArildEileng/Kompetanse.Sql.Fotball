

WITH City_Teams_CTE As 
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
)


Select * from City_Teams_CTE