create database AgencijaDogadjaji
use AgencijaDogadjaji

create table Drzava(
DrzavaID int not null  primary key identity (1,1),
Naziv nvarchar(50) not null
)

create table Grad(
GradID int not null primary key identity (1,1),
Naziv nvarchar(50) not null,
DrzavaID int not null foreign key references Drzava(DrzavaID)
)

create table Klijenti(
KlijentID int not null primary key,
Email nvarchar(50) not null,
BrojTelefona nvarchar(50) not null,
BrojRacuna int,
GradID int not null foreign key references Grad(GradID)
)

create table KlijentPravnoLice(
KlijentPravnoLiceID int not null foreign key references Klijenti(KlijentID),
NazivFirme nvarchar(50) not null,
constraint PK_KlijentPravnoLiceID primary key (KlijentPravnoLiceID)
)

create table KlijentFizickoLice(
KlijentFizickoLiceID int not null foreign key references Klijenti(KlijentID),
Ime nvarchar(50) not null,
Prezime nvarchar(50) not null,
Spol nvarchar(10),
JMBG nvarchar(13) not null,
constraint PK_KlijentFizickoLiceID primary key (KlijentFizickoLiceID)
)

create table Dogadjaji(
DogadjajID int not null primary key identity(1,1),
Vrsta nvarchar(50) not null,
Naziv nvarchar(50),
BrojGostiju int not null,
Datum nvarchar(10) not null,
KlijentID int not null foreign key references Klijenti(KlijentID),
GradID int not null  foreign key references Grad(GradID)
)

create table Uplata(
UplataID int not null primary key identity(1,1),
Iznos decimal(12,2) not null,
DatumUplate nvarchar(10) not null,
KlijentID int not null foreign key references Klijenti(KlijentID),
DogadjajID int not null foreign key references Dogadjaji(DogadjajID)
)

create table Partneri(
PartnerID int not null primary key identity(1,1),
Kategorija nvarchar(50) not null,
Ime nvarchar(50) not null,
Prezime nvarchar(50) not null,
Email nvarchar(50) not null,
BrojTelefona nvarchar(50)
)

create table PartneriDogadjaji(
PartneriDogadjajiID int not null primary key identity(1,1),
PartnerID int not null foreign key references Partneri(PartnerID),
DogadjajID int not null foreign key references Dogadjaji(DogadjajID),
Cijena decimal(12,2) not null
)

create table Poslovnica(
PoslovnicaID int not null primary key identity (1,1),
BrojTelefona nvarchar(50) not null,
Email nvarchar(50) not null,
GradID int not null foreign key references Grad(GradID),
Adresa nvarchar(50),
Naziv nvarchar(50) not null
)

create table Zaposlenici(
ZaposlenikID int not null primary key,
Ime nvarchar(50) not null,
Prezime nvarchar(50) not null,
Spol nvarchar(10),
JMBG nvarchar(13) not null,
Email nvarchar(50) not null,
BrojTelefona nvarchar(50) not null,
Adresa nvarchar(50) not null,
PoslovnicaID int not null foreign key references Poslovnica(PoslovnicaID),
GradID int not null foreign key references Grad(GradID)
)

create table Organizatori(
OrganizatorID int not null foreign key references Zaposlenici(ZaposlenikID),
GodineStaza int not null,
Fakultet nvarchar(50) not null,
constraint PK_Organizatori primary key (OrganizatorID)
)

create table Hostese(
HostesaID int not null constraint FK_HostesaID foreign key references Zaposlenici(ZaposlenikID),
Jezik nvarchar(50) not null,
Dostupnost bit not null,
constraint PK_Hostese primary key (HostesaID)
)

create table HosteseDogadjaji(
HosteseDogadjajiID int not null primary key identity (1,1),
HostesaID int not null foreign key references Hostese(HostesaID),
DogadjajID int not null foreign key references Dogadjaji(DogadjajID),
)

create table OrganizatoriDogadjaji(
OrganizatoriDogadjajiID int not null primary key identity (1,1),
OrganizatorID int not null foreign key references Organizatori(OrganizatorID),
DogadjajID int not null foreign key references Dogadjaji(DogadjajID)
)
