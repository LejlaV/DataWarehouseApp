
create database AgencijaDogadjajiDW
use AgencijaDogadjajiDW

create table DimLokacija(
LokacijaKey int not null primary key identity(1,1),
LokacijaAltKey int not null,
Drzava nvarchar(100) not null,
Grad nvarchar(100) not null,
Poslovnica nvarchar(100) not null
)

create table DimVrijeme(
VrijemeKey nvarchar(8) not null primary key,
VrijemeAltKey date not null,
Godina int not null,
Mjesec int not null,
Dan int not null,
NazivMjeseca nvarchar(50),
NazivDana nvarchar(50)
)

create table DimKlijenti
(
KlijentiKey int not null primary key identity(1,1),
KlijentiAltKey int not null,
TipKlijenta nvarchar(100) not null
)

create table DimZaposlenici(
ZaposleniciKey int not null primary key identity(1,1),
ZaposleniciAltKey int not null,
TipZaposlenika nvarchar(100) not null,
Fakultet nvarchar(100) 
)

create table FactDogadjaji(
DogadjajKey int not null primary key identity(1,1),
LokacijaForeignKey int not null foreign key references DimLokacija(LokacijaKey),
VrijemeForeignKey nvarchar(8) not null foreign key references DimVrijeme (VrijemeKey),
KlijentiForeignKey int not null foreign key references DimKlijenti(KlijentiKey),
ZaposleniciForeignKey int not null foreign key references DimZaposlenici(ZaposleniciKey),
BrojDogadjaja int,
Iznos decimal(6,2)
)

alter table DimVrijeme drop column Godina

SELECT * FROM DimVrijeme



ORDER BY VrijemeAltKey
--- pocetni datum = 01.01.1980
-- kranji datum = danasnji

DECLARE @StartDate DATE = '01/01/2009';
DECLARE @EndDate  DATE = GETDATE();

--- pomocne varijable

DECLARE @VrijemeKey nvarchar(8)
DECLARE @VrijemeAltKey date
DECLARE @Godina int
DECLARE @Mjesec int
DECLARE @Dan int
DECLARE @NazivMjeseca nvarchar(50)
DECLARE @NazivDana nvarchar(50)

DECLARE @DD nvarchar(2)
DECLARE @MM nvarchar(2)

WHILE @StartDate <= @EndDate
BEGIN
	-- 01.01.1980
	SET @Dan = DAY(@StartDate)
	SET @Mjesec = MONTH(@StartDate)

	--- Izvuceni Mjesec i dan

	IF @Dan < 10
		SET @DD = '0' + CONVERT(NVARCHAR,@Dan)
	ELSE
		SET @DD = CONVERT(NVARCHAR,@Dan)

	IF @Mjesec < 10
		SET @MM = '0' + CONVERT(NVARCHAR, @Mjesec)
	ELSE
		SET @MM = CONVERT(NVARCHAR, @Mjesec)

	
	SET @VrijemeKey =CONVERT(NVARCHAR,YEAR(@StartDate))+ @MM+@DD 
	--- VrijemeKey setovan

	SET @VrijemeAltKey = @StartDate

	-- VrijemeAltKey setovan
		SET @NazivDana = DATENAME(DW,@StartDate)
		
	SET @NazivMjeseca = DATENAME(MM,@StartDate)

	-- Setovani NazivDana i NazivMjeseca

	 --- ubacit zapis u tabelu

	 INSERT INTO DimVrijeme(VrijemeKey, VrijemeAltKey,Mjesec, Dan, NazivMjeseca, NazivDana)
	 VALUES(@VrijemeKey, @VrijemeAltKey, @Mjesec, @Dan, @NazivMjeseca, @NazivDana)

	 SET @StartDate = DATEADD(DAY,1,@StartDate)
END;
select * from DimVrijeme
alter table DimVrijeme add Godina int
update DimVrijeme set Godina=SUBSTRING(VrijemeKey,1,4) from DimVrijeme

-- ETL Lokacija
use AgencijaDogadjaji
select P.PoslovnicaID, G.Naziv as 'Naziv grada', D.Naziv as 'Naziv drzave', P.Naziv as 'Naziv poslovnice'
from Grad as G join Drzava as D on D.DrzavaID=G.DrzavaID join Poslovnica as P ON P.GradID=G.GradID
 use AgencijaDogadjajiDW
 select * from DimLokacija
 delete from DimLokacija where LokacijaKey between 11 and 20
-- select G.GradID, G.Naziv as 'Naziv grada', D.Naziv as 'Naziv drzave'
--from Grad as G join Drzava as D on D.DrzavaID=G.DrzavaID 

 -- ETL Klijenti
 use AgencijaDogadjaji
select k.KlijentID, kp.NazivFirme as 'TipKlijenta' 
from Klijenti as k join KlijentPravnoLice as kp on k.KlijentID=kp.KlijentPravnoLiceID 
union
select k.KlijentID, kf.Ime+' '+kf.Prezime as 'TipKlijenta'
from Klijenti as k join KlijentFizickoLice as kf on k.KlijentID=kf.KlijentFizickoLiceID

use AgencijaDogadjajiDW
select * from DimKlijenti

-- ETL Zaposlenici
use Agencija

select z.ZaposlenikID, z.Ime+' ' + z.Prezime as 'TipZaposlenika', o.Fakultet as 'Fakultet'
from Zaposlenici as z join Organizatori as o on z.ZaposlenikID=o.OrganizatorID 
union
select z.ZaposlenikID, z.Ime+' '+z.Prezime as 'TipZaposlenika', 'bez fakulteta' as 'Fakultet'
from Zaposlenici as z join Hostese as h on z.ZaposlenikID=h.HostesaID

use AgencijaDogadjajiDW
select * from DimZaposlenici

-- INKREMENTALNO DimZaposlenici

select * from Zaposlenici

select * from KlijentFizickoLice

use AgencijaDogadjajiDW
select * from DimZaposlenici
select * from DimZaposlenici

update DimZaposlenici
set TipZaposlenika=?,Fakultet=?
where ZaposleniciAltKey=?

use Agencija
select * from Zaposlenici where ZaposlenikID=1001
insert into Zaposlenici (ZaposlenikID,Ime,Prezime,Spol,JMBG,Email,BrojTelefona,Adresa,PoslovnicaID,GradID)
values (1001,'test','test','F','7852','fgh','7862','asdfdg',4,2)
select * from DimZaposlenici where ZaposleniciAltKey=1000

update Zaposlenici set Spol='test' where ZaposlenikID=1 


