Fotball (-sql) kompetanse utvikling


Bruk kun:
   SELECT
   Group by  (MAX/MIN/COUNT)
   JOIN (all) 
   CTE
   Window function  (Row_Number, Rank) 
   CASE  (WHEN THEN)

IKKE tillatt!:
  View
  Stored Procedure  
  ChatGPT
  Google ( annet enn syntax)   


Slik set data ut:

Table: [Football].[dbo].[E02017]   (alle datatyper er nvarchar(50)

Date	    HomeTeam	AwayTeam	FTHG	FTAG
11/08/2017	Arsenal	    Leicester	4	    3
12/08/2017	Brighton	Man City	0	    2
12/08/2017	Chelsea	    Burnley	    2	    3
12/08/2017	Crystal P	Huddersfield 0	    3
12/08/2017	Everton	    Stoke	     1	    0
.....



1)
     Finn (list) alle team 
 
2)
     Lag CTE som returner innoldet  i  [E02017] , med riktige datatyper (Datetime, int)
 
3) 
     Finn antall kamper spilt pr År/Mnd
2017 8(md)  10 (kamper
...
2018 5     15 

 
4a)
     Lag ferdigspilt tabell   ( basert kun på poeng  )
Manchester  (won) (draw) (lost) (poeng)
...


4b) 
     Lagre ferdigspilt tabel i egen tabell i db   
[Football].[dbo].Tabell2017


5)
     List alle kamper, partisjonert på Team , og sortert på result ( fra beste til verste) (basert på målforskjell i kampen)
Arsenal -Leeds 5-0
...
Arsenal -West Ham 1-3
Brighton -West Ham 4-1
...

 
6) 
     Lag oversikt over  uavgjorte kamper ( gruppert på team ), sortert etter antall ( fra max til min)
Leeds  15
Liverpool 14
..
Huddersfield 2
	 
   
7a)
     Hvilket team tapte fleste hjemmpekamper på rad?
7b)
     Hvilke team tapte minst 3 hjemmpekamper på rad?
	
8)	
     Hvilke team hadde minst 2 perioder med 2 hjemmtap på rad?

9) 
     Rang sjer(Rank) ( samme antall poeng, samme rank)  teamene etter antall poeng i hjemmekamp fom 6 tom 10

10) 
      Lag liste (CTE) over team i London  
Arsenal
..
Watford


11a)
     Lag tabell , der kun London-lag inngår  ( altså kun kamper mellom London-lag)
11b) 
     Utvid med Liverpool og Manchester... ( en slags Super League altså...!!)
   
12)
     Lag liga der hjemme- og borte kamp teller som en kamp... ( totalscore begge kamper)...
     Hvordan blir denne tabellen  ( alle lag har da spilt totalt 19 'kamper')

13) 
     Import excel-fil i database
     Kopier noen tabell over i en annen database
	 -- med script
	 -- uten script
	
Nøtter	

14)
     Lag tabell (alle lag) , med 2-popeng for seier ( som i gamle dager)
     Hvilke lag ville forbedret sin tabell-posisjon med denne endringen?

15)
     Få 'noen' til å slette noen rader i fotball-tabellen.
     Finn hvilke kamper som nå mangler ..

16) 
      Finn alle antall kamper for ALLE mnd i 2017/2018 , også de med 0
	
Eksta Harde Nøtter

17)  
     Hvilket team hadde det 'verste' 'beste' bortekamp-resultat
18)  
     Hvilke team hadde en lengste seieresrekken ( hjemme og borte kamper sett under ett) 

19)  Med logikken  , hvis A vinner borte mot B og B vinner borte mot C , så er A bedre enn B og C,
     -  hvilke team var Man United 'beviselig' bedre enn?
	 -  hvilke team var Man City 'beviselig' bedre enn?
	 Lag liste over team, sortert på antall team det er bedre enn.....
	 
	 
Bonus:
20)
     Lag EF Core kode som løser oppgavene ...
