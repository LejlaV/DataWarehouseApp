USE AgencijaDogadjaji
alter table Dogadjaji alter column Datum date
select D.DogadjajID as 'DogadjajKey', 
	   G.GradID as 'LokacijaForeignKey', 
	   D.Datum as 'VrijemeForeignKey', 
       K.KlijentID as 'KlijentiForeignKey', 
	   Z.ZaposlenikID as 'ZaposleniciForeignKey',
	   COUNT(D.DogadjajID) AS 'BrojDogadjaja',
	   U.Iznos as 'Iznos'
from Dogadjaji as D inner join Grad as G on G.GradID=D.GradID inner join Klijenti as K on K.KlijentID=D.KlijentID
inner join OrganizatoriDogadjaji as OD on OD.DogadjajID=D.DogadjajID inner join HosteseDogadjaji as HD on HD.DogadjajID=D.DogadjajID
inner join Hostese as H on H.HostesaID=HD.HostesaID inner join Organizatori as O on O.OrganizatorID=OD.OrganizatorID
inner join Zaposlenici as Z on Z.ZaposlenikID=O.OrganizatorID or Z.ZaposlenikID=H.HostesaID
inner join Uplata as U on U.DogadjajID=D.DogadjajID
group by D.DogadjajID, G.GradID,D.Datum,K.KlijentID,Z.ZaposlenikID,U.Iznos


use AgencijaDogadjaji
select  
	   G.GradID as 'LokacijaForeignKey', 
	   CONVERT(nvarchar,CONVERT(date, D.Datum,103),112) as 'VrijemeForeignKey', 
       K.KlijentID as 'KlijentiForeignKey', 
	   Z.ZaposlenikID as 'ZaposleniciForeignKey',
	   COUNT(D.DogadjajID) AS 'BrojDogadjaja',
	   U.Iznos as 'Iznos'
from Dogadjaji as D inner join Grad as G on G.GradID=D.GradID inner join Klijenti as K on K.KlijentID=D.KlijentID
inner join OrganizatoriDogadjaji as OD on OD.DogadjajID=D.DogadjajID inner join HosteseDogadjaji as HD on HD.DogadjajID=D.DogadjajID
inner join Hostese as H on H.HostesaID=HD.HostesaID inner join Organizatori as O on O.OrganizatorID=OD.OrganizatorID
inner join Zaposlenici as Z on Z.ZaposlenikID=O.OrganizatorID or Z.ZaposlenikID=H.HostesaID
inner join Uplata as U on U.DogadjajID=D.DogadjajID
group by D.DogadjajID, G.GradID,D.Datum,K.KlijentID,Z.ZaposlenikID,U.Iznos

SELECT * FROM AgencijaDogadjajiDW.dbo.DimKlijenti
use AgencijaDogadjajiDW
select * from FactDogadjaji

SELECT * FROM KlijentFizickoLice

DELETE KlijentPravnoLice

SELECT *
FROM KlijentFizickoLice
WHERE KlijentFizickoLiceID IN (SELECT KlijentPravnoLiceID FROM KlijentPravnoLice)

SELECT *
FROM KlijentPravnoLice
WHERE KlijentPravnoLiceID IN (SELECT KlijentFizickoLiceID FROM KlijentFizickoLice)


SELECT * FROM KlijentPravnoLice





