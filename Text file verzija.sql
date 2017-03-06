/*
DROP SEQUENCE seq_RacInstKar;
DROP SEQUENCE seq_MustInsId;
DROP SEQUENCE seq_MustInsPos;
DROP SEQUENCE seq_MustInsZap;
DROP SEQUENCE seq_MustInsDug;
DROP SEQUENCE seq_ZapInsId;
DROP SEQUENCE seq_ZapInsPos;
DROP SEQUENCE seq_ZapInsPosReg;

DROP SEQUENCE seq_Bankomati;
DROP SEQUENCE seq_Drzave;
DROP SEQUENCE seq_Dugovanja;
DROP SEQUENCE seq_Funkcije;
DROP SEQUENCE seq_Hipoteke;
DROP SEQUENCE seq_Kartice;
DROP SEQUENCE seq_Krediti;
DROP SEQUENCE seq_Lokacije;
DROP SEQUENCE seq_Odjeli;
DROP SEQUENCE seq_Osobe;
DROP SEQUENCE seq_Poslovnice;
DROP SEQUENCE seq_Racuni;
DROP SEQUENCE seq_Regije;
DROP SEQUENCE seq_TipKartice;
DROP SEQUENCE seq_TipKredita;
DROP SEQUENCE seq_TipRacuna;
DROP SEQUENCE seq_Zaposlenja;
DROP SEQUENCE seq_Transakcije;
DROP SEQUENCE seq_Otpustanja;
DROP SEQUENCE seq_BrojLKGenerator;

DROP TABLE Otpustanja CASCADE CONSTRAINTS;
DROP TABLE Transakcije CASCADE CONSTRAINTS;
DROP TABLE Bankomati CASCADE CONSTRAINTS;
DROP TABLE Drzave CASCADE CONSTRAINTS;
DROP TABLE Dugovanja CASCADE CONSTRAINTS;
DROP TABLE Funkcije CASCADE CONSTRAINTS;
DROP TABLE Hipoteke CASCADE CONSTRAINTS;
DROP TABLE Kartice CASCADE CONSTRAINTS;
DROP TABLE Krediti CASCADE CONSTRAINTS;
DROP TABLE Lokacije CASCADE CONSTRAINTS;
DROP TABLE Musterije CASCADE CONSTRAINTS;
DROP TABLE Odjeli CASCADE CONSTRAINTS;
DROP TABLE Osobe CASCADE CONSTRAINTS;
DROP TABLE Poslovnice CASCADE CONSTRAINTS;
DROP TABLE Racuni CASCADE CONSTRAINTS;
DROP TABLE Regije CASCADE CONSTRAINTS;
DROP TABLE TipKartice CASCADE CONSTRAINTS;
DROP TABLE TipKredita CASCADE CONSTRAINTS;
DROP TABLE TipRacuna CASCADE CONSTRAINTS;
DROP TABLE Zaposlenici CASCADE CONSTRAINTS;
DROP TABLE Zaposlenja CASCADE CONSTRAINTS;
*/

--b)Kreiranje tabela

CREATE SEQUENCE seq_Bankomati;
CREATE SEQUENCE seq_Drzave;
CREATE SEQUENCE seq_Dugovanja;
CREATE SEQUENCE seq_Funkcije;
CREATE SEQUENCE seq_Hipoteke;
CREATE SEQUENCE seq_Kartice;
CREATE SEQUENCE seq_Krediti;
CREATE SEQUENCE seq_Lokacije;
CREATE SEQUENCE seq_Odjeli;
CREATE SEQUENCE seq_Osobe;
CREATE SEQUENCE seq_Otpustanja;
CREATE SEQUENCE seq_Poslovnice;
CREATE SEQUENCE seq_Racuni;
CREATE SEQUENCE seq_Regije;
CREATE SEQUENCE seq_TipKartice;
CREATE SEQUENCE seq_TipKredita;
CREATE SEQUENCE seq_TipRacuna;
CREATE SEQUENCE seq_Transakcije;
CREATE SEQUENCE seq_Zaposlenja;
CREATE TABLE Bankomati (bankomati_id number(10) NOT NULL, stanje number(12, 2) NOT NULL CHECK(stanje >= 0), poslovnice_id number(10) NOT NULL, PRIMARY KEY (bankomati_id));
CREATE TABLE Drzave (drzave_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (drzave_id));
CREATE TABLE Dugovanja (dugovanja_id number(10) NOT NULL, iznos number(10, 2) NOT NULL CHECK(iznos > 0 ), rok_otplate date NOT NULL, PRIMARY KEY (dugovanja_id));
CREATE TABLE Funkcije (funkcije_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, opis varchar2(255), odjeli_id number(10) NOT NULL, PRIMARY KEY (funkcije_id));
CREATE TABLE Hipoteke (hipoteke_id number(10) NOT NULL, musterije_id number(10) NOT NULL, iznos number(10) NOT NULL CHECK(iznos > 0), rok_otplate date NOT NULL, otplaceno number(10) DEFAULT 0 NOT NULL CHECK(otplaceno >= 0), PRIMARY KEY (hipoteke_id));
CREATE TABLE Kartice (kartice_id number(10) NOT NULL, tip_kartice_id number(10) NOT NULL, pin varchar2(4) DEFAULT '0000' NOT NULL, PRIMARY KEY (kartice_id));
CREATE TABLE Krediti (krediti_id number(10) NOT NULL, iznos number(10) NOT NULL CHECK(iznos > 0), rata_placeno number(10) DEFAULT 0 NOT NULL CHECK(rata_placeno >= 0), rata_preostalo number(10) NOT NULL CHECK(rata_preostalo >= 0), fiksna_kamata number(1) NOT NULL CHECK(fiksna_kamata = 0 or fiksna_kamata = 1), datum_povecanja_kamate date, datum_smanjenja_kamate date, redovan number(1) CHECK(redovan = 0 or redovan = 1), musterije_id number(10) NOT NULL, ziranti_id number(10) NOT NULL, tip_kredita_id number(10) NOT NULL, PRIMARY KEY (krediti_id));
CREATE TABLE Lokacije (lokacije_id number(10) NOT NULL, ulica varchar2(255), grad varchar2(255) NOT NULL, regije_id number(10) NOT NULL, PRIMARY KEY (lokacije_id));
CREATE TABLE Musterije (osobe_id number(10) NOT NULL, poslovnice_id number(10) NOT NULL, zaposlenja_id number(10) UNIQUE, dugovanja_id number(10) UNIQUE, PRIMARY KEY (osobe_id));
CREATE TABLE Odjeli (odjeli_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (odjeli_id));
CREATE TABLE Osobe (osobe_id number(10) NOT NULL, ime varchar2(255) NOT NULL, prezime varchar2(255) NOT NULL, lokacije_id number(10), broj_licne_karte varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (osobe_id));
CREATE TABLE Otpustanja (otpustanja_id number(10) NOT NULL, poslovnice_id number(10) NOT NULL, osobe_id number(10) NOT NULL, funkcije_id number(10) NOT NULL, PRIMARY KEY (otpustanja_id));
CREATE TABLE Poslovnice (poslovnice_id number(10) NOT NULL, nadredjena_id number(10), sredstva number(10) DEFAULT 1000000 NOT NULL CHECK(sredstva >= 0), lokacije_id number(10) NOT NULL, otvorena number(1) DEFAULT 1 NOT NULL CHECK(otvorena = 0 or otvorena = 1), PRIMARY KEY (poslovnice_id));
CREATE TABLE Racuni (racuni_id number(10) NOT NULL, musterije_id number(10) NOT NULL UNIQUE, tip_racuna_id number(10) NOT NULL, kartice_id number(10), stanje number(10) DEFAULT 0 NOT NULL, PRIMARY KEY (racuni_id));
CREATE TABLE Regije (regije_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, drzave_id number(10) NOT NULL, PRIMARY KEY (regije_id));
CREATE TABLE TipKartice (tip_kartice_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (tip_kartice_id));
CREATE TABLE TipKredita (tip_kredita_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, max_iznos number(10) NOT NULL CHECK(max_iznos > 0), kamatna_stopa float(10) NOT NULL CHECK(kamatna_stopa >= 0), min_rata number(10) NOT NULL CHECK(min_rata > 0), min_period_otplate number(10) NOT NULL CHECK(min_period_otplate > 0), max_period_otplate number(10) NOT NULL, max_dozvoljeno_dugovanje number(10) NOT NULL CHECK(max_dozvoljeno_dugovanje > 0), PRIMARY KEY (tip_kredita_id));
CREATE TABLE TipRacuna (tip_racuna_id number(10) NOT NULL, naziv varchar2(255) NOT NULL UNIQUE, max_velicina_transakcije number(10) NOT NULL CHECK(max_velicina_transakcije > 0), mjesecni_odbitak number(10, 3) DEFAULT 0 NOT NULL CHECK(mjesecni_odbitak >= 0), minimalno_stanje number(10) DEFAULT 0 NOT NULL, PRIMARY KEY (tip_racuna_id));
CREATE TABLE Transakcije (transakcije_id number(10) NOT NULL, racuni_id number(10) NOT NULL, iznos number(10, 2) NOT NULL, datum date DEFAULT SYSDATE NOT NULL, PRIMARY KEY (transakcije_id));
CREATE TABLE Zaposlenici (osobe_id number(10) NOT NULL, poslovnice_id number(10) NOT NULL, funkcije_id number(10) NOT NULL, plata number(10) DEFAULT 0 NOT NULL CHECK(plata >= 0), PRIMARY KEY (osobe_id));
CREATE TABLE Zaposlenja (zaposlenja_id number(10) NOT NULL, plata number(10, 2) NOT NULL, stalno number(1) NOT NULL CHECK(stalno = 0 or stalno = 1), PRIMARY KEY (zaposlenja_id));
ALTER TABLE Poslovnice ADD CONSTRAINT FKPoslovnice696291 FOREIGN KEY (nadredjena_id) REFERENCES Poslovnice (poslovnice_id);
ALTER TABLE Lokacije ADD CONSTRAINT FKLokacije211072 FOREIGN KEY (regije_id) REFERENCES Regije (regije_id);
ALTER TABLE Poslovnice ADD CONSTRAINT FKPoslovnice135742 FOREIGN KEY (lokacije_id) REFERENCES Lokacije (lokacije_id);
ALTER TABLE Musterije ADD CONSTRAINT FKMusterije526802 FOREIGN KEY (osobe_id) REFERENCES Osobe (osobe_id);
ALTER TABLE Osobe ADD CONSTRAINT FKOsobe754161 FOREIGN KEY (lokacije_id) REFERENCES Lokacije (lokacije_id);
ALTER TABLE Musterije ADD CONSTRAINT FKMusterije744824 FOREIGN KEY (poslovnice_id) REFERENCES Poslovnice (poslovnice_id);
ALTER TABLE Musterije ADD CONSTRAINT FKMusterije549111 FOREIGN KEY (zaposlenja_id) REFERENCES Zaposlenja (zaposlenja_id);
ALTER TABLE Zaposlenici ADD CONSTRAINT FKZaposlenic942803 FOREIGN KEY (poslovnice_id) REFERENCES Poslovnice (poslovnice_id);
ALTER TABLE Musterije ADD CONSTRAINT FKMusterije218853 FOREIGN KEY (dugovanja_id) REFERENCES Dugovanja (dugovanja_id);
ALTER TABLE Krediti ADD CONSTRAINT FKKrediti703962 FOREIGN KEY (tip_kredita_id) REFERENCES TipKredita (tip_kredita_id);
ALTER TABLE Racuni ADD CONSTRAINT FKRacuni118345 FOREIGN KEY (tip_racuna_id) REFERENCES TipRacuna (tip_racuna_id);
ALTER TABLE Racuni ADD CONSTRAINT FKRacuni814613 FOREIGN KEY (kartice_id) REFERENCES Kartice (kartice_id);
ALTER TABLE Kartice ADD CONSTRAINT FKKartice639567 FOREIGN KEY (tip_kartice_id) REFERENCES TipKartice (tip_kartice_id);
ALTER TABLE Bankomati ADD CONSTRAINT FKBankomati216020 FOREIGN KEY (poslovnice_id) REFERENCES Poslovnice (poslovnice_id);
ALTER TABLE Funkcije ADD CONSTRAINT FKFunkcije140016 FOREIGN KEY (odjeli_id) REFERENCES Odjeli (odjeli_id);
ALTER TABLE Regije ADD CONSTRAINT FKRegije804833 FOREIGN KEY (drzave_id) REFERENCES Drzave (drzave_id);
ALTER TABLE Zaposlenici ADD CONSTRAINT FKZaposlenic61589 FOREIGN KEY (funkcije_id) REFERENCES Funkcije (funkcije_id);
ALTER TABLE Otpustanja ADD CONSTRAINT FKOtpustanja76040 FOREIGN KEY (poslovnice_id) REFERENCES Poslovnice (poslovnice_id);
ALTER TABLE Otpustanja ADD CONSTRAINT FKOtpustanja141982 FOREIGN KEY (osobe_id) REFERENCES Osobe (osobe_id);
ALTER TABLE Otpustanja ADD CONSTRAINT FKOtpustanja957254 FOREIGN KEY (funkcije_id) REFERENCES Funkcije (funkcije_id);
ALTER TABLE Transakcije ADD CONSTRAINT FKTransakcij726880 FOREIGN KEY (racuni_id) REFERENCES Racuni (racuni_id);
ALTER TABLE Hipoteke ADD CONSTRAINT FKHipoteke953992 FOREIGN KEY (musterije_id) REFERENCES Musterije (osobe_id);
ALTER TABLE Krediti ADD CONSTRAINT FKKrediti227602 FOREIGN KEY (ziranti_id) REFERENCES Musterije (osobe_id);
ALTER TABLE Krediti ADD CONSTRAINT FKKrediti96370 FOREIGN KEY (musterije_id) REFERENCES Musterije (osobe_id);
ALTER TABLE Racuni ADD CONSTRAINT FKRacuni760166 FOREIGN KEY (musterije_id) REFERENCES Musterije (osobe_id);
ALTER TABLE Zaposlenici ADD CONSTRAINT FKZaposlenic160826 FOREIGN KEY (osobe_id) REFERENCES Osobe (osobe_id);

--c)Popunjavanje

INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Administracija');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'IT');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Salter');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Pravni poslovi');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Elektronsko bankarstvo');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Kupoprodaja');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Upravljanje sredstvima');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Komercijalno bankarstvo');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Hipotekarno bankarstvo');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Izdavanje kredita');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Ostalo osoblje');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Analiza');
INSERT INTO Odjeli(odjeli_id, naziv) VALUES (seq_Odjeli.NEXTVAL, 'Ljudski resursi');

INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Zastitar', 10);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Cistac', 10);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Salterski sluzbenik', 3);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Finansijski analiticar', 11);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'IT tehnicar', 2);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Kreditni sluzbenik', 9);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Sef saltera', 3);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Interni revizor - mlaði', 12);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Interni revizor - stariji', 12);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Referent za pravne poslove', 4);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Saradnik za procjenu nekretnina', 11);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Licni bankar', 6);
INSERT INTO Funkcije(funkcije_id, naziv, odjeli_id) VALUES (seq_Funkcije.NEXTVAL, 'Diretor poslovnice', 1);

INSERT INTO TipKredita(tip_kredita_id, naziv, max_iznos, kamatna_stopa, min_rata, min_period_otplate, max_period_otplate, max_dozvoljeno_dugovanje)
VALUES (seq_TipKredita.NEXTVAL, 'Hipotekarni', 100000, 0.02, 1000, 365 * 5, 365 * 20, 10000);
INSERT INTO TipKredita(tip_kredita_id, naziv, max_iznos, kamatna_stopa, min_rata, min_period_otplate, max_period_otplate, max_dozvoljeno_dugovanje)
VALUES (seq_TipKredita.NEXTVAL, 'Srednjorocni', 50000, 0.03, 500, 365 * 3, 365 * 10, 30000);
INSERT INTO TipKredita(tip_kredita_id, naziv, max_iznos, kamatna_stopa, min_rata, min_period_otplate, max_period_otplate, max_dozvoljeno_dugovanje)
VALUES (seq_TipKredita.NEXTVAL, 'Kratkorocni', 30000, 0.1, 300, 365 * 2, 365 * 5, 50000);
INSERT INTO TipKredita(tip_kredita_id, naziv, max_iznos, kamatna_stopa, min_rata, min_period_otplate, max_period_otplate, max_dozvoljeno_dugovanje)
VALUES (seq_TipKredita.NEXTVAL, 'Mikrokredit', 10000, 0.3, 150, 365 * 1, 365 * 3, 10000);

INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak, minimalno_stanje) VALUES (seq_TipRacuna.NEXTVAL, 'Tekuci Mini', 1000, 5, -300);
INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak, minimalno_stanje) VALUES (seq_TipRacuna.NEXTVAL, 'Tekuci Standardni', 5000, 10, -400);
INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak, minimalno_stanje) VALUES (seq_TipRacuna.NEXTVAL, 'Tekuci Veliki', 10000, 15, -500);
INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak) VALUES (seq_TipRacuna.NEXTVAL, 'Stedni Mini', 1000, 0);
INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak) VALUES (seq_TipRacuna.NEXTVAL, 'Stedni Standardni', 5000, 5);
INSERT INTO TipRacuna(tip_racuna_id, naziv, max_velicina_transakcije, mjesecni_odbitak) VALUES (seq_TipRacuna.NEXTVAL, 'Stedni Veliki', 10000, 10);

INSERT INTO TipKartice(tip_kartice_id, naziv) VALUES (seq_TipKartice.NEXTVAL, 'Debitna');
INSERT INTO TipKartice(tip_kartice_id, naziv) VALUES (seq_TipKartice.NEXTVAL, 'Kreditna');
INSERT INTO TipKartice(tip_kartice_id, naziv) VALUES (seq_TipKartice.NEXTVAL, 'Studentska');
INSERT INTO TipKartice(tip_kartice_id, naziv) VALUES (seq_TipKartice.NEXTVAL, 'Stedna');

INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Bosna i Hercegovina');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'USA');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Srbija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Makedonija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Hrvatska');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Crna Gora');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Slovenija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Kosovo');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Grcka');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Rumunija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Bugarska');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Turska');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Madjarska');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Italija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Austrija');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Njemacka');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'Francuska');
INSERT INTO Drzave(drzave_id, naziv) VALUES (seq_Drzave.NEXTVAL, 'UK');

INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Unskosanska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Posavska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Tuzlanska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Zenicko-dobojska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Bosansko-podrinjska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Srednjobosanska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Hercegovacko-neretvanska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Zapadnohercegovacka', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Sarajevska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Herceg-bosanska', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'RS', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'Brcko', 1);
INSERT INTO Regije(regije_id, naziv, drzave_id) VALUES (seq_Regije.NEXTVAL, 'New York', 2);

INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, '6th Avenue', 'New York', 13);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Pape Ivana Pavla II', 'Bihac', 1);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Bihac', 1);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Reisa Dzemaludina Causevica', 'Odzak', 2);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Orasje', 2);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Univerzitetska', 'Tuzla', 3);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Tuzla', 3);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Alije Izetbegovica', 'Visoko', 4);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Zenica', 4);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Marsala Tita', 'Gorazde', 5);
INSERT INTO Lokacije(lokacije_id,  grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Gorazde', 5);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Josipa bana Jelacica', 'Kiseljak', 6);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Travnik', 6);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Kneza Domagoja', 'Mostar', 7);
INSERT INTO Lokacije(lokacije_id,  grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Mostar', 7);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Fra Grge Matica', 'Posusje', 8);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL,  'Siroki Brijeg', 8);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Zmaja od Bosne', 'Sarajevo', 9);
INSERT INTO Lokacije(lokacije_id,  grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Sarajevo', 9);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Brigade kralja Tomislava', 'Tomislavgrad', 10);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Livno', 10);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Bulevar vojvode Stepe Stepanovica', 'Banja Luka', 11);
INSERT INTO Lokacije(lokacije_id,  grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Banja Luka', 11);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Bosne Srebrene', 'Brcko', 12);
INSERT INTO Lokacije(lokacije_id, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Brcko', 12);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Cabaravdica', 'Visoko', 4);
INSERT INTO Lokacije(lokacije_id, ulica, grad, regije_id) VALUES (seq_Lokacije.NEXTVAL, 'Salke Nezecica', 'Sarajevo', 9);

INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, NULL, 100000000, 1);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 2);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 4);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 6);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 8);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 10);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 12);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 14);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 16);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 18);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 20);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 22);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, sredstva, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 1, 1000000, 24);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 2, 3);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 3, 5);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 4, 7);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 5, 9);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 6, 11);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 7, 13);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 8, 15);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 9, 17);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 10, 19);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 11, 21);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 12, 23);
INSERT INTO Poslovnice(poslovnice_id, nadredjena_id, lokacije_id) VALUES (seq_Poslovnice.NEXTVAL, 13, 25);

INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 50000, 5);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 25000, 7);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 100000, 3);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 30000, 16);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 30000, 22);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 45000, 13);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 60000, 4);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 150000, 5);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 50000, 18);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 75000, 18);
INSERT INTO Bankomati(bankomati_id, stanje, poslovnice_id) VALUES (seq_Bankomati.NEXTVAL, 200000, 17);

create SEQUENCE seq_BrojLKGenerator;

INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime, lokacije_id) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL, 'Amar', 'Buric', 26);
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime, lokacije_id) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL, 'Elvir', 'Crncevic', 27);
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Amer', 'Djedovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Ajla', 'Dzanko');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Azra', 'Hasic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Dzenir', 'Omanovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Dejan', 'Becic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Belmin', 'Basalija');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Asim', 'Besirovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Berina', 'Sero');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Jan', 'Oruc');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Haris', 'Secic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Lamija', 'Sabic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Faruk', 'Sogolj');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Adna', 'Grabus');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Amel', 'Galijasevic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Osman', 'Habibovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Denin', 'Hadzagic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Emina', 'Hadzic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Ajla', 'Fisic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Hanna', 'Fejzic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Mirza', 'Mlaco');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Adi', 'Milisic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Kenan', 'Bojadzic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Almira', 'Mujezinovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Husein', 'Muminovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Ema', 'Mojsilovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Edin', 'Kasum');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Lejla', 'Katica');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Berzad', 'Sisic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Dzenana', 'Klicic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Jasmina', 'Skamo');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Merisa', 'Sehalic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Adem', 'Dzaferovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Lamija', 'Dzamdzic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Tarik', 'Dzananovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Faris', 'Delic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Muris', 'Bibic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Zerina', 'Biogradlija');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Irhad', 'Brajlovac');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Mustafa', 'Bojicic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Dzenita', 'Lagumdzija');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Edo', 'Kulovac');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Melika', 'Kudic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Adis', 'Arnaut');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Ajna', 'Kulosmanovic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Hena', 'Avdagic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Orhan', 'Konjhodzic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Emir', 'Kovacevic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Sulijana', 'Kreco');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Adnan', 'Krkalic');
INSERT INTO Osobe(osobe_id, broj_licne_karte, ime, prezime) VALUES (seq_Osobe.NEXTVAL, seq_BrojLKGenerator.NEXTVAL,  'Irvina', 'Krak');


CREATE SEQUENCE seq_ZapInsId;
CREATE SEQUENCE seq_ZapInsPos START WITH 12 INCREMENT BY 1 MINVALUE 0;
--Sekvence su koristene za lakse inserte, da se ne bi moralo hardkodirat u potpunosti

SELECT seq_ZapInsPos.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 1, 1000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 2, 500);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 700);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 4, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 5, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 6, 400);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 7, 1300);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 13, 2000);

SELECT seq_ZapInsPos.NEXTVAL FROM dual;


INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 1, 3000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 2, 2000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 1000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 500);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 6, 750);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 7, 600);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 13, 2500);

SELECT seq_ZapInsPos.NEXTVAL FROM dual;


INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 1, 700);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 2, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 1400);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 500);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 9, 2500);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 10, 750);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 13, 950);

SELECT seq_ZapInsPos.NEXTVAL FROM dual;


INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 1, 1400);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 2, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 1230);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 3400);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 190);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 10, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 12, 1200);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 13, 900);


SELECT seq_ZapInsPos.NEXTVAL FROM dual;


INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 1, 900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 2, 290);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 1900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 3, 2900);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 9, 890);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 6, 390);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 12, 800);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPos.CURRVAL, 13, 2000);


CREATE SEQUENCE seq_ZapInsPosReg START WITH 2 INCREMENT BY 1 MINVALUE 1;

SELECT seq_ZapInsPosReg.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 10, 3000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 13, 5000);

SELECT seq_ZapInsPosReg.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 10, 2000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 13, 900);

SELECT seq_ZapInsPosReg.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 10, 3000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 13, 2400);

SELECT seq_ZapInsPosReg.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 10, 2000);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 13, 3000);

SELECT seq_ZapInsPosReg.NEXTVAL FROM dual;

INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 10, 2500);
INSERT INTO Zaposlenici(osobe_id, poslovnice_id, funkcije_id, plata) VALUES (seq_ZapInsId.NEXTVAL, seq_ZapInsPosReg.CURRVAL, 13, 4000);

INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1000, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 600, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1200, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 850, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1150, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 950, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 2200, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1700, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1500, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 800, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 750, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 990, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 5000, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 2200, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 800, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 1500, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 770, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 750, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 900, 0);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 2300, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 2500, 1);
INSERT INTO Zaposlenja(zaposlenja_id, plata, stalno) VALUES (seq_Zaposlenja.NEXTVAL, 640, 0);

INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1500, SYSDATE + 200);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 2000, SYSDATE + 150);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 300, SYSDATE + 500);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 4000, SYSDATE + 600);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1200, SYSDATE + 130);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1700, SYSDATE + 70);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1900, SYSDATE + 400);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1200, SYSDATE + 450);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 3450, SYSDATE + 900);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 900, SYSDATE + 200);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 300, SYSDATE + 450);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1900, SYSDATE + 140);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1500, SYSDATE + 100);
INSERT INTO Dugovanja(dugovanja_id, iznos, rok_otplate) VALUES (seq_Dugovanja.NEXTVAL, 1100, SYSDATE + 60);

CREATE SEQUENCE seq_MustInsId;
CREATE SEQUENCE seq_MustInsZap;
CREATE SEQUENCE seq_MustInsDug;
CREATE SEQUENCE seq_MustInsPos START WITH 12 INCREMENT BY 1 MINVALUE 0;

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, NULL);

SELECT seq_MustInsPos.NEXTVAL FROM dual;

INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, NULL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, seq_MustInsZap.NEXTVAL, seq_MustInsDug.NEXTVAL);
INSERT INTO Musterije(osobe_id, poslovnice_id, zaposlenja_id, dugovanja_id) VALUES (seq_MustInsId.NEXTVAL, seq_MustInsPos.CURRVAL, NULL, seq_MustInsDug.NEXTVAL);

INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate, otplaceno) VALUES (seq_Hipoteke.NEXTVAL, 1, 100000, SYSDATE + 400, 9000);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate, otplaceno) VALUES (seq_Hipoteke.NEXTVAL, 4, 50000, SYSDATE + 900, 4000);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate, otplaceno) VALUES (seq_Hipoteke.NEXTVAL, 9, 500000, SYSDATE + 1000, 7000);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate, otplaceno) VALUES (seq_Hipoteke.NEXTVAL, 11, 300000, SYSDATE + 5 * 365, 4500);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 3, 200000, SYSDATE + 9 * 365);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 13, 250000, SYSDATE + 8 * 365);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 17, 400000, SYSDATE + 5 * 365);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 6, 100000, SYSDATE + 4 * 365);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 18, 230000, SYSDATE + 3 * 365);
INSERT INTO Hipoteke(hipoteke_id, musterije_id, iznos, rok_otplate) VALUES (seq_Hipoteke.NEXTVAL, 24, 80000, SYSDATE + 2 * 365);

INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 1);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 2);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 4);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 3);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 4);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 2);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 3);
INSERT INTO Kartice(kartice_id, tip_kartice_id) VALUES (seq_Kartice.NEXTVAL, 4);

CREATE SEQUENCE seq_RacInstKar;

INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 1, 1, seq_RacInstKar.NEXTVAL, 1000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 2, 3, NULL, 5000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 3, 4, seq_RacInstKar.NEXTVAL, 15000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 5, 5, seq_RacInstKar.NEXTVAL, 950);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 7, 2, NULL, 600);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 9, 6, seq_RacInstKar.NEXTVAL, 35000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 12, 6, seq_RacInstKar.NEXTVAL, 400);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 13, 2, seq_RacInstKar.NEXTVAL, 900);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 15, 4, NULL, 1450);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 16, 3, seq_RacInstKar.NEXTVAL, 7000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id, stanje) VALUES (seq_Racuni.NEXTVAL, 17, 2, seq_RacInstKar.NEXTVAL, 30000);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id) VALUES (seq_Racuni.NEXTVAL, 19, 2, NULL);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id) VALUES (seq_Racuni.NEXTVAL, 21, 1, NULL);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id) VALUES (seq_Racuni.NEXTVAL, 23, 2, NULL);
INSERT INTO Racuni(racuni_id, musterije_id, tip_racuna_id, kartice_id) VALUES (seq_Racuni.NEXTVAL, 27, 1, NULL);

INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 100000, 5, 12, 1, NULL, NULL, 1, 1, 2, 4);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 500000, 7, 4, 1, NULL, NULL, 0, 2, 30, 1);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 1200000, 9, 5, 1, NULL, NULL, 1, 3, 9, 2);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 300000, 11, 11, 1, NULL, NULL, 1, 4, 4, 3);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 900000, 2, 4, 1, NULL, NULL, 0, 5, 6, 1);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 650000, 3, 4, 1, NULL, NULL, 1, 7, 19, 3);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 1000000, 3, 9, 1, NULL, NULL, 0, 14, 24, 4);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 950000, 16, 5, 1, NULL, NULL, 1, 15, 23, 2);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 200000, 3, 8, 1, NULL, NULL, 0, 17, 22, 3);
INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata, datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id, ziranti_id, tip_kredita_id)
VALUES (seq_Krediti.NEXTVAL, 100000, 4, 4, 1, NULL, NULL, 0, 19, 11, 4);

--d) 30 sql upita

SELECT o.ime || ' ' || o.prezime as "Ime i prezime"
from osobe o, zaposlenici z
where o.osobe_id = z.osobe_id;
--Svi zaposlenici

select o.ime || ' '  || o.prezime as "Ime i prezime"
from osobe o, musterije m, poslovnice p,
lokacije l
where o.osobe_id = m.osobe_id
and m.poslovnice_id = p.poslovnice_id
and p.lokacije_id = l.lokacije_id
and l.grad = 'Bihac';
--Sve musterije koje su vezane za poslovnice u Bihacu

select o.ime || ' ' || o.prezime as "Ime i prezime", iznos as "Dug"
from osobe o, musterije m, dugovanja d
where o.osobe_id = m.osobe_id
and m.dugovanja_id = d.dugovanja_id;
--Sve musterije koje imaju dugovanja

select b.stanje, Nvl(l.ulica, 'Nepoznato') as ulica
from bankomati b, poslovnice p, lokacije l, regije r
where b.poslovnice_id = p.poslovnice_id
and p.lokacije_id = l.lokacije_id
and l.regije_id = r.regije_id
and r.naziv = 'Tuzlanska';
--Svi bankomati u tuzlanskoj regiji

select o.ime || ' ' || o.prezime as "Ime i prezime"
from osobe o, musterije m, krediti k
where o.osobe_id = m.osobe_id
and m.osobe_id = k.musterije_id
and k.rata_preostalo < (12 - To_Number(To_Char(SYSDATE, 'MM')));
-- Sve musterije koje ce otplatiti kredit do kraja godine

Select distinct f.naziv as Funkcija
from funkcije f, zaposlenici z, poslovnice p, lokacije l, regije r, drzave d
where f.funkcije_id = z.funkcije_id
and p.poslovnice_id = z.poslovnice_id
and p.lokacije_id = l.lokacije_id
and l.regije_id = r.regije_id
and r.drzave_id = d.drzave_id
and d.naziv like '%Bosna%';
--Sve funkcije koje postoje u Bosni

select DISTINCT o2.ime || ' ' || o2.prezime as "Zirant"
from osobe o1, osobe o2, musterije m1, musterije m2, krediti k
where o1.osobe_id = m1.osobe_id
and o2.osobe_id = m2.osobe_id
and k.musterije_id = m1.osobe_id
and m2.osobe_id = k.ziranti_id
and m2.zaposlenja_id IS NULL;
--Spisak svih ziranata koji su nezaposleni

select o.ime || ' ' || o.prezime as "Ime i prezime"
from osobe o, musterije m, racuni r, kartice k, tipkartice tk
where o.osobe_id = m.osobe_id
and r.musterije_id = m.osobe_id
and k.kartice_id = r.kartice_id
and k.tip_kartice_id = tk.tip_kartice_id
and tk.naziv like 'Debitna';
--Sve musterije sa debitnim karticama

select DISTINCT o1.ime || ' ' || o1.prezime as "Ime i prezime"
from osobe o1, osobe o2, musterije m1, musterije m2, krediti k, hipoteke h
where o1.osobe_id = m1.osobe_id
and o2.osobe_id = m2.osobe_id
and k.musterije_id = m1.osobe_id
and m2.osobe_id = k.ziranti_id
and h.musterije_id = m2.osobe_id
and To_number(h.rok_otplate - SYSDATE) / 12 > k.rata_preostalo;
--Musterije koje ce otplatiti kredit prije nego njihovi ziranti hipoteku

select o.ime || ' ' || o.prezime as "Ime i prezime",
l1.grad as "Grad"
from lokacije l1, lokacije l2, osobe o, musterije m, racuni r, poslovnice p
where o.osobe_id = m.osobe_id
and o.lokacije_id = l1.lokacije_id
and p.lokacije_id = l2.lokacije_id
and l1.grad = l2.grad
and r.musterije_id = m.osobe_id
and m.poslovnice_id = p.poslovnice_id;
-- Sve musterije koje su otvorile racun u poslovnici koja se nalazi u gradu
--u kojem zive

SELECT p.poslovnice_id AS id, l.grad AS lokacija
FROM poslovnice p, lokacije l
WHERE p.lokacije_id = l.lokacije_id
START WITH p.poslovnice_id = 15
CONNECT BY PRIOR nadredjena_id = poslovnice_id;
--Hijerarhija nadredjenih za poslovnicu 15

select p.poslovnice_id AS id, sum(k.iznos) AS "Suma keredita"
from poslovnice p, musterije m, krediti k
where k.musterije_id = m.osobe_id
and m.poslovnice_id = p.poslovnice_id
group by p.poslovnice_id
ORDER BY p.poslovnice_id;
--Sumarni iznosi izdatih kredita po poslovnici

select o.naziv as "Naziv odjela", p.poslovnice_id as id,  sum(z.plata) as suma
from zaposlenici z, funkcije f, odjeli o, poslovnice p
where z.poslovnice_id = p.poslovnice_id
and z.funkcije_id = f.funkcije_id
and f.odjeli_id = o.odjeli_id
group by p.poslovnice_id, o.naziv
having avg(z.plata) > 1000
ORDER BY o.naziv, p.poslovnice_id;
--Suma plata po odjelima za odjele gdje je prosjecna plata veca od 1000

select p.poslovnice_id as id, max(r.stanje) as "Najvece stanje", min(r.stanje) as "Najmanje stanje"
from musterije m, racuni r, poslovnice p
where m.poslovnice_id = p.poslovnice_id
and r.musterije_id = m.osobe_id
group by p.poslovnice_id;
--Najvece i najmanje stanje na racunima po poslovnici

select p.poslovnice_id as id, f.naziv as funkcija, count(f.funkcije_id) as "Broj zaposlenih"
from zaposlenici z, poslovnice p, funkcije f
where z.poslovnice_id = p.poslovnice_id and f.funkcije_id = z.funkcije_id
group by p.poslovnice_id, f.naziv
having count(f.funkcije_id) > 3;
--Broj zaposlenih po funkciji u kojim je taj broj veci od 3

select m.osobe_id as id, count(*) as "Broj kredita"
from musterije m, krediti k
where m.osobe_id = k.musterije_id
GROUP BY m.osobe_id
ORDER BY m.osobe_id;
--Broj kredita po musteriji

select o.ime || ' ' || o.prezime as "Ime i prezime"
from osobe o, musterije m
where o.osobe_id = m.osobe_id
and m.poslovnice_id in (
	select p.poslovnice_id
	from poslovnice p, lokacije l, regije r
	where p.lokacije_id = l.lokacije_id
	and r.regije_id = l.regije_id
	and r.naziv LIKE '%Unskosanska%'
);
--Sve musterije iz Unskosanske regije

select r.naziv "Naziv regije"
from regije r
where exists (
	select *
	from poslovnice p, lokacije l
	where p.lokacije_id = l.lokacije_id
	and l.regije_id = r.regije_id
);
--Sve regije u kojima postoji bar jedna poslovnica

select o.ime || ' ' || o.prezime as "Ime i prezime"
from osobe o, musterije m, racuni r, poslovnice p,
lokacije l
where o.osobe_id = m.osobe_id
and r.musterije_id = m.osobe_id
and m.poslovnice_id = p.poslovnice_id
and p.lokacije_id = l.lokacije_id
and l.grad like 'Visoko'
and r.stanje > all (
	select r2.stanje
	from musterije m2, racuni r2, poslovnice p2,
	lokacije l2
	where m2.osobe_id = r2.musterije_id
	and m2.poslovnice_id = p2.poslovnice_id
	and p2.lokacije_id = l2.lokacije_id
	and l2.grad like 'Sarajevo'
);
--Svi ljudi iz Visokog koji imaju vise para od svih ljudi iz Sarajeva

SELECT p.poslovnice_id AS id
FROM poslovnice p
where (
  SELECT Max(z.plata)
  FROM zaposlenici z
  WHERE z.poslovnice_id = p.poslovnice_id
) < ANY (
  SELECT z2.plata
  FROM zaposlenici z2, poslovnice p2
  WHERE p.nadredjena_id = p2.poslovnice_id
  AND z2.poslovnice_id = p2.poslovnice_id
);
--Sve poslovnicama u kojim rade osobe koje zaradjuju vise
--od neke osobe u nadredjenoj poslovnici

SELECT o.ime || ' ' || o.prezime AS "Ime i prezime"
FROM osobe o, zaposlenici z
WHERE o.osobe_id = z.osobe_id
AND z.plata > ALL (
  SELECT zap.plata
  FROM musterije m, zaposlenja zap
  WHERE m.zaposlenja_id = zap.zaposlenja_id
  AND zap.plata < ANY (
    SELECT zap2.plata
    FROM musterije m2, zaposlenja zap2
    WHERE m2.zaposlenja_id = zap2.zaposlenja_id
    AND m2.osobe_id IN (
	SELECT ziranti_id
	FROM krediti
    )
  )
);
--Svi zaposlenici koji imaju vecu platu
--od musterija koji imaju platu manju
--od bilo kojeg ziranta

SELECT r.racuni_id AS id, r.stanje AS stanje
FROM racuni r
WHERE r.musterije_id IN (
  SELECT k.ziranti_id
  FROM krediti k
  WHERE k.ziranti_id IN (
    SELECT h.musterije_id
    FROM hipoteke h
  )
);
--Racuni svih ziranata koji imaju hipoteku

SELECT p.poslovnice_id AS id
FROM poslovnice p
WHERE p.poslovnice_id IN (
  SELECT nadredjena_id
  FROM poslovnice
  WHERE sredstva > (
    SELECT Avg(sredstva)
    FROM poslovnice
  )
);
--Nadredjene poslovnice svih poslovnica
--koje imaju natprosjecno sredstava

SELECT o.ime || ' ' || o.prezime AS "Ime i prezime", d.iznos
FROM osobe o, musterije m, dugovanja d
WHERE o.osobe_id = m.osobe_id
AND d.dugovanja_id = m.dugovanja_id
AND (
  SELECT Max(z.plata)
  FROM musterije m2, zaposlenja z
  WHERE z.zaposlenja_id = m2.zaposlenja_id
  AND m2.osobe_id IN (
    SELECT ziranti_id
    FROM krediti
  )
) > (
  SELECT Avg(z.plata)
  FROM musterije m2, zaposlenja z
  WHERE z.zaposlenja_id = m2.zaposlenja_id
  AND m2.osobe_id IN (
    SELECT ziranti_id
    FROM krediti
  )
);
--Dugovanja svih musterija
--koji imaju ziranta sa vecom platom
--od prosjecne plate svih ziranata

SELECT p.poslovnice_id AS id, p.sredstva AS sredstva
FROM poslovnice p
WHERE p.poslovnice_id IN (
  SELECT p2.nadredjena_id
  FROM poslovnice p2
  WHERE (
    SELECT Avg(k.iznos)
    FROM krediti k
    WHERE k.musterije_id IN (
	SELECT m.osobe_id
	FROM musterije m
	WHERE m.poslovnice_id = p2.poslovnice_id
    )
  ) > (
    SELECT Avg(k.iznos)
    FROM krediti k
  )
)
ORDER BY id;
--Sredstva svih poslovnica koje su nadredjene poslovnicama
--ciji je avg iznos kredita veci od avg iznosa svih kredita

SELECT p.poslovnice_id AS "Poslovnica ID" , m.osobe_id AS "Osoba ID", Sum(k.iznos) AS "Suma"
FROM poslovnice p, musterije m, krediti k
WHERE m.poslovnice_id = p.poslovnice_id
AND k.musterije_id = m.osobe_id
GROUP BY ROLLUP (p.poslovnice_id, m.osobe_id)
ORDER BY p.poslovnice_id, osobe_id;
--Rollup suma kredita po musteriji po poslovnici

SELECT p.poslovnice_id AS "Poslovnica ID", f.naziv AS "Funkcija", o.naziv AS "Odjel",
Count(z.osobe_id)	AS "Broj uposlenih"
FROM poslovnice p, zaposlenici z, funkcije f, odjeli o
WHERE p.poslovnice_id = z.osobe_id
AND z.funkcije_id = f.funkcije_id
AND f.odjeli_id = o.odjeli_id
GROUP BY CUBE(p.poslovnice_id, o.naziv, f.naziv)
ORDER BY p.poslovnice_id, o.naziv, f.naziv;
--Cube broj zaposlenih po odjelima, funkcijama, poslovnicama

SELECT ROWNUM AS rank, poslovnice_id AS "ID", broj_musterija AS "Broj musterija"
FROM (
  SELECT p.poslovnice_id, Count(m.osobe_id) AS broj_musterija
  FROM poslovnice p, musterije m
  WHERE m.poslovnice_id = p.poslovnice_id
  GROUP BY p.poslovnice_id
  ORDER BY broj_musterija
)
WHERE ROWNUM <= 5;
--Top 5 poslovnica sa najvise musterija

SELECT ROWNUM AS Rank, id AS "Osobe ID", krediti AS "Suma kredita"
FROM (
  SELECT m.osobe_id AS id, Sum(k.iznos) AS krediti
  FROM  musterije m, krediti k
  WHERE k.musterije_id = m.osobe_id
  GROUP BY m.osobe_id
  ORDER BY krediti
)
WHERE ROWNUM <= 3;
--3 Musterije sa najvecim sumarnim iznosom kredita

SELECT o.ime || ' ' || o.prezime AS "Ime i prezime"
FROM osobe o, zaposlenici z
WHERE o.osobe_id = z.osobe_id
INTERSECT
SELECT o.ime || ' ' || o.prezime
FROM osobe o, musterije m
WHERE o.osobe_id = m.osobe_id;
--Presjek skupa ljudi koji su ujedno i musterije i zaposlenici
--(pod pretpostavkom da je ime i prezime unique id za svaku osobu)

--h) 10 triggera

CREATE OR REPLACE TRIGGER provjera_ziranta
BEFORE INSERT OR UPDATE OF ziranti_id ON krediti
FOR EACH ROW
BEGIN
  IF(:NEW.ziranti_id = :NEW.musterije_id)
  THEN  Raise_Application_Error(-20500, 'Musterija ne moze biti zirant sama sebi');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_tipa_kartice
BEFORE INSERT OR UPDATE OF tip_kartice_id ON kartice
FOR EACH row
DECLARE
  v_tip_racuna VARCHAR2(255);
  v_tip_kartice VARCHAR2(255);
BEGIN
  SELECT tp.naziv
  INTO v_tip_racuna
  FROM racuni r, tipracuna tp
  WHERE r.tip_racuna_id = tp.tip_racuna_id
  AND r.kartice_id = :OLD.kartice_id;

  SELECT tp.naziv
  INTO v_tip_kartice
  FROM tipkartice tp
  WHERE  tp.tip_kartice_id = :NEW.tip_kartice_id;

  IF(v_tip_racuna LIKE 'Stedni' AND v_tip_kartice NOT LIKE 'Stedna')
  THEN  Raise_Application_Error(-20500, 'Nepoklapajuci tip kartice za dati racun');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_datuma
BEFORE UPDATE OF datum_povecanja_kamate ON krediti
FOR EACH ROW
BEGIN
  IF(:NEW.datum_povecanja_kamate < SYSDATE)
  THEN Raise_Application_Error(-20500, 'Datum mora biti poslije trenutnog');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_iznosa_kredita
BEFORE INSERT OR UPDATE OF iznos ON krediti
FOR EACH ROW
DECLARE
  v_max_iznos NUMBER(10);
BEGIN
  SELECT max_iznos
  INTO v_max_iznos
  FROM tipkredita tp
  WHERE tp.tip_kredita_id = :NEW.tip_kredita_id;

  IF(:NEW.iznos > v_max_iznos)
  THEN Raise_Application_Error(-20500, 'Iznos je veci od maksimalnog iznosa za dati tip kredita');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_broja_rata
BEFORE INSERT OR UPDATE OF rata_placeno ON krediti
FOR EACH ROW
DECLARE
  v_min_rata NUMBER(10);
BEGIN
  SELECT min_rata
  INTO v_min_rata
  FROM tipkredita tp
  WHERE tp.tip_kredita_id = :NEW.tip_kredita_id;

  IF(:NEW.rata_placeno + :NEW.rata_preostalo > v_min_rata)
  THEN Raise_Application_Error(-20500, 'Ukupan broj rata je manji od minimalnog broja rata za dati kredit');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_duga
BEFORE INSERT OR UPDATE OF musterije_id ON krediti
FOR EACH ROW
DECLARE
  v_dug NUMBER(10);
  v_max_dug NUMBER(10);
BEGIN
  SELECT d.iznos
  INTO v_dug
  FROM musterije m, dugovanja d
  WHERE m.osobe_id = :NEW.musterije_id
  AND m.dugovanja_id = d.dugovanja_id;

  SELECT tp.max_dozvoljeno_dugovanje
  INTO v_max_dug
  FROM tipkredita tp
  WHERE tp.tip_kredita_id = :NEW.tip_kredita_id;

  IF(v_dug > v_max_dug)
  THEN Raise_Application_Error(-20500, 'Musterija ima prevelik dug da bi dobio kredit');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_broja_kredita
BEFORE INSERT OR UPDATE OF musterije_id ON krediti
FOR EACH ROW
DECLARE
  v_broj_kredita NUMBER(10);
BEGIN
  SELECT Count(*)
  INTO v_broj_kredita
  FROM musterije m, krediti k
  WHERE m.osobe_id = k.musterije_id
  AND m.osobe_id = :NEW.musterije_id;

  IF(v_broj_kredita >= 3)
  THEN Raise_Application_Error(-20500, 'Musterija ima maksimalan broj kredita');
  END IF;
END;
/


CREATE OR REPLACE TRIGGER provjera_stanja_na_racunu
BEFORE INSERT OR UPDATE OF stanje ON racuni
FOR EACH ROW
DECLARE
  v_min_stanje NUMBER(10);
BEGIN
  SELECT minimalno_stanje
  INTO v_min_stanje
  FROM tipracuna tip
  WHERE tip.tip_racuna_id = :NEW.tip_racuna_id;

  IF(:NEW.stanje < v_min_stanje)
  THEN Raise_Application_Error(-20500, 'Stanje ne moze biti manje od mininalnog stanja za dati tip racuna');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_stanja_poslovnice
BEFORE UPDATE OF sredstva ON poslovnice
FOR EACH ROW
DECLARE
  v_suma_stanja_bankomata NUMBER(10);
BEGIN
  SELECT Sum(b.stanje)
  INTO v_suma_stanja_bankomata
  FROM bankomati b
  WHERE b.poslovnice_id = :OLD.poslovnice_id;

  IF(:NEW.sredstva < v_suma_stanja_bankomata)
  THEN Raise_Application_Error(-20500, 'Poslovnica ne moze imati manje sredstava od novca na bankomatima');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER provjera_vel_trans
BEFORE UPDATE OF stanje ON racuni
FOR EACH ROW
DECLARE
  v_max_transakcija NUMBER(10);
BEGIN
  SELECT max_velicina_transakcije
  INTO v_max_transakcija
  FROM tipracuna tp
  WHERE tp.tip_racuna_id = :NEW.tip_racuna_id;

  IF(Abs(:NEW.stanje - :OLD.stanje) > v_max_transakcija)
  THEN Raise_Application_Error(-20500, 'Transkacija prelazi max dozvoljenu za tip racuna');
  END IF;
END;
/

--e)5 indeksa

CREATE INDEX racuni_kartice_idx
ON racuni(kartice_id);
--Veliki broj null vrijednosti

CREATE INDEX krediti_musterije_idx
ON krediti(musterije_id);
--Koristi se u mnogo where klauza

CREATE INDEX poslovnice_lokacije_idx
ON poslovnice(lokacije_id);
--Koristi se u mnogo where klauza

CREATE INDEX krediti_ziranti_idx
ON krediti(ziranti_id);
--Koristi se u mnogo where klauza

CREATE INDEX poslovnice_nadredjena_idx
ON poslovnice(nadredjena_id);
--Upiti vracaju mal procenat ukupnog broja podataka

--f) 10+ funkcija

CREATE OR REPLACE FUNCTION sumarno_stanje_na_racunima
  (v_id IN musterije.osobe_id%TYPE)
  RETURN NUMBER
IS
  v_suma  racuni.stanje%TYPE := 0;
BEGIN
    SELECT Sum(r.stanje)
    INTO v_suma
    FROM racuni r
    WHERE r.musterije_id = v_id;
    RETURN (v_suma);
END;
/

CREATE OR REPLACE FUNCTION ukupan_iznos_kredita
  (v_id IN musterije.osobe_id%TYPE)
  RETURN NUMBER
IS
  v_suma  racuni.stanje%TYPE := 0;
BEGIN
    SELECT Sum(k.iznos)
    INTO v_suma
    FROM krediti k
    WHERE k.musterije_id = v_id;
    RETURN (v_suma);
END;
/

CREATE OR REPLACE FUNCTION zarada_od_odbitaka
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_suma  racuni.stanje%TYPE := 0;
BEGIN
    SELECT Sum(tp.mjesecni_odbitak)
    INTO v_suma
    FROM musterije m, racuni r, tipracuna tp
    WHERE m.poslovnice_id = v_id
    AND r.musterije_id = m.osobe_id
    AND tp.tip_racuna_id = r.tip_racuna_id;
    RETURN (v_suma);
END;
/

CREATE OR REPLACE FUNCTION ukupan_dug
  (v_id IN musterije.osobe_id%TYPE)
  RETURN NUMBER
IS
  v_suma  NUMBER := 0;
  v_temp  NUMBER;
BEGIN
    SELECT d.iznos
    INTO v_temp
    FROM dugovanja d, musterije m
    where m.dugovanja_id = d.dugovanja_id
    AND m.osobe_id = v_id;
    v_suma := v_suma + v_temp;
    SELECT Sum(h.iznos)
    INTO v_temp
    FROM hipoteke h
    WHERE h.musterije_id = v_id;
    v_suma := v_suma + v_temp;
    v_suma := v_suma + ukupan_iznos_kredita(v_id);
    RETURN (v_suma);
END;
/


CREATE OR REPLACE FUNCTION je_podoban_za_kredit
  (v_id IN musterije.osobe_id%TYPE,
  v_tip_kredita IN tipkredita.tip_kredita_id%TYPE)
  RETURN NUMBER
IS
  v_je_podoban  NUMBER(1) := 1;
  v_max_dug TipKredita.max_dozvoljeno_dugovanje%TYPE;
BEGIN
  SELECT max_dozvoljeno_dugovanje
  INTO v_max_dug
  FROM tipKredita
  WHERE tip_kredita_id = v_tip_kredita;
  IF(ukupan_dug(v_id) > v_max_dug) THEN v_je_podoban := 0;
  END IF;
  RETURN (v_je_podoban);
END;
/

CREATE OR REPLACE FUNCTION ukupno_plate
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_suma  zaposlenici.plata%TYPE := 0;
BEGIN
  SELECT Sum(z.plata)
  INTO v_suma
  FROM zaposlenici z
  WHERE z.poslovnice_id = v_id;
  RETURN (v_suma);
END;
/

CREATE OR REPLACE FUNCTION dobit_od_kredita
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_suma  zaposlenici.plata%TYPE := 0;
BEGIN
  SELECT Sum (k.iznos / (k.rata_placeno + k.rata_preostalo))
  INTO v_suma
  FROM krediti k, musterije m
  WHERE k.musterije_id = m.osobe_id
  AND m.poslovnice_id = v_id;
  --Znam da ne valja formula jer moze bit promjenljivo
  --ali mi nedostaje informacija u tabelama
  /*
  FROM krediti_red IN (
   SELECT k.rata_placeno AS rata_placeno,
   k.rata_place + k.rata_preostalo AS ukupno_rata,
   k.iznos AS iznos
   FROM krediti k, musterije m
   WHERE m.poslovnice_id = v_id) LOOP
    v_suma := v_suma + (krediti_red.iznos / krediti_red.ukupno_rata);;
  END LOOP;      */
  RETURN (v_suma);
END;
/

CREATE OR REPLACE FUNCTION dobit_na_kraju_mjeseca
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_suma  NUMBER := 0;
BEGIN
  v_suma := dobit_od_kredita(v_id) + zarada_od_odbitaka(v_id)
  - ukupno_plate(v_id);
  RETURN (v_suma);
END;
/


CREATE OR REPLACE FUNCTION sredstva_na_kraju_mjeseca
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_trenutno  NUMBER := 0;
BEGIN
  SELECT sredstva
  INTO v_trenutno
  FROM poslovnice
  WHERE poslovnice_id = v_id;
  v_trenutno := v_trenutno + dobit_na_kraju_mjeseca(v_id);
  RETURN (v_trenutno);
END;
/

CREATE OR REPLACE FUNCTION nadji_musteriju
  (v_broj_licne_karte IN osobe.broj_licne_karte%TYPE)
  RETURN NUMBER
IS
  v_id  NUMBER := -1;
  v_temp number;
BEGIN
  SELECT Count(*)
  INTO v_temp
  FROM musterije m, osobe o
  WHERE m.osobe_id = o.osobe_id
  AND o.broj_licne_karte = v_broj_licne_karte;
  IF(v_temp = 0) THEN
    RETURN -1; --Vraca -1 ako ne postoji musterija
  END IF;
  SELECT m.osobe_id
  INTO v_id
  FROM musterije m, osobe o
  WHERE m.osobe_id = o.osobe_id
  AND o.broj_licne_karte = v_broj_licne_karte;
  RETURN v_id;
END;
/

CREATE OR REPLACE FUNCTION dodaj_musteriju
  (v_ime IN osobe.ime%TYPE,
   v_prezime IN osobe.prezime%TYPE,
   v_broj_licne_karte IN osobe.broj_licne_karte%TYPE,
   v_poslovnice_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_id  NUMBER := -1;
  v_temp NUMBER;
BEGIN
  SELECT Count(*)
  INTO v_temp
  FROM musterije m, osobe o
  WHERE m.osobe_id = o.osobe_id
  AND o.broj_licne_karte = v_broj_licne_karte;
  IF(v_temp <> 0) THEN
    Raise_Application_Error(-20002, 'Musterija je vec registrovana');
  END IF;
  SELECT Count(*)
  INTO v_temp
  FROM osobe o
  WHERE o.broj_licne_karte = v_broj_licne_karte;
  IF(v_temp = 0) THEN
    --Ako se osoba ne nalazi ni u tabeli Osobe treba je dodati
    INSERT INTO osobe(osobe_id, ime, prezime, broj_licne_karte)
    VALUES (seq_Osobe.NEXTVAL, v_ime, v_prezime, v_broj_licne_karte);
  END IF;

  SELECT o.osobe_id
  INTO v_id
  FROM osobe o
  WHERE o.broj_licne_karte = v_broj_licne_karte;

  INSERT INTO musterije(osobe_id, poslovnice_id)
  VALUES (v_id, v_poslovnice_id);

  RETURN v_id;
END;
/

CREATE OR REPLACE FUNCTION nadji_tip_kredita
  (v_naziv IN tipkredita.naziv%TYPE)
  RETURN NUMBER
IS
  v_id NUMBER;
  v_temp NUMBER;
BEGIN
  SELECT Count(*)
  INTO v_temp
  FROM tipkredita
  WHERE naziv = v_naziv;
  IF(v_temp = 0) THEN
    Raise_Application_Error(-20005, 'Tip kredita ne postoji');
  END if;
  SELECT tip_kredita_id
  INTO v_id
  FROM tipkredita
  WHERE naziv = v_naziv;
  RETURN v_id;
END;
/

CREATE OR REPLACE FUNCTION broj_transakcije_u_periodu
  (v_id IN racuni.racuni_id%TYPE,
  v_pocetak IN transakcije.datum%TYPE,
  v_kraj IN transakcije.datum%TYPE)
  RETURN NUMBER
IS
  v_br_trans  NUMBER;
BEGIN
  SELECT Count(t.transakcije_id)
  INTO v_br_trans
  FROM transakcije t
  WHERE t.racuni_id = v_id;
  RETURN (v_br_trans);
END;
/

CREATE OR REPLACE FUNCTION je_regionalna
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_je_regionalna NUMBER;
  v_nadredjena poslovnice.poslovnice_id%TYPE;
BEGIN
  SELECT nadredjena_id
  INTO v_nadredjena
  FROM poslovnice
  WHERE poslovnice_id = v_id;
  IF(v_nadredjena = 1) THEN v_je_regionalna := 1;
  ELSE v_je_regionalna := 0;
  End IF;
  RETURN (v_je_regionalna);
END;
/

CREATE OR REPLACE FUNCTION daj_stanje_podredjenih
  (v_id IN poslovnice.poslovnice_id%TYPE)
  RETURN NUMBER
IS
  v_suma NUMBER := 0;
begin
  SELECT Sum(sredstva)
  INTO v_suma
  FROM poslovnice
  WHERE nadredjena_id = v_id;
  RETURN (v_suma);
END;
/

--g) 10+ procedura

CREATE OR REPLACE PROCEDURE izvrsi_transakciju_na_kartici
  (v_id IN kartice.kartice_id%TYPE,
   v_transakcija NUMBER)
IS
  v_odgovarajuci_racun_id racuni.racuni_id%TYPE;
  CURSOR racuni_kursor IS
    SELECT r.stanje
    FROM racuni r, kartice k
    WHERE r.kartice_id = k.kartice_id
    FOR UPDATE OF r.stanje NOWAIT; 	--Koristi zakljucavanje radi sigurnosti
BEGIN

   FOR racuni_slog IN racuni_kursor LOOP
    UPDATE racuni
    SET stanje = racuni_slog.stanje + v_transakcija
    WHERE CURRENT OF racuni_kursor;
  END LOOP;

  SELECT r.racuni_id
  INTO v_odgovarajuci_racun_id
  FROM racuni r
  WHERE r.kartice_id = v_id;

  INSERT INTO transakcije(transakcije_id,
  racuni_id, iznos, datum)
  VALUES (seq_Transakcije.NEXTVAL,
  v_odgovarajuci_racun_id, v_transakcija,
  SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE otpusti
  (v_id IN zaposlenici.osobe_id%TYPE)
IS
  v_poslovnica_id poslovnice.poslovnice_id%TYPE;
  v_funkcija_id funkcije.funkcije_id%TYPE;
BEGIN
  SELECT funkcije_id, poslovnice_id
  INTO v_funkcija_id, v_poslovnica_id
  FROM zaposlenici
  WHERE osobe_id = v_id;

  INSERT INTO otpustanja(otpustanja_id,
  poslovnice_id, osobe_id, funkcije_id)
  VALUES (seq_Otpustanja.NEXTVAL,
  v_poslovnica_id, v_id,
  v_funkcija_id);

  DELETE FROM zaposlenici
  WHERE osobe_id = v_id;
END;
/

CREATE OR REPLACE PROCEDURE izdaj_kredit
  (v_id IN NUMBER,
  v_tip_kredita_id IN NUMBER,
  v_iznos NUMBER, v_rata NUMBER,
  v_fiksna_kamata NUMBER,
  v_datum_povecanja DATE,
  v_datum_smanjenja DATE,
  v_zirant_id IN NUMBER)
IS
BEGIN
  IF(je_podoban_za_kredit(v_id, v_tip_kredita_id) = 1)
  THEN
    INSERT INTO Krediti(krediti_id, iznos, rata_placeno, rata_preostalo, fiksna_kamata,
    datum_povecanja_kamate, datum_smanjenja_kamate, redovan, musterije_id,
    ziranti_id, tip_kredita_id) VALUES (seq_Krediti.NEXTVAL, v_iznos, 0, v_rata, v_fiksna_kamata,
    v_datum_povecanja, v_datum_smanjenja, 1, v_id, v_zirant_id, v_tip_kredita_id);
  ELSE
    raise_application_error(-20500, 'Musterija nije podobna za kredit');
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE uplati_ratu
  (v_krediti_id IN krediti.krediti_id%TYPE)
IS
  v_rata_placeno NUMBER;
  v_rata_preostalo NUMBER;
BEGIN
  SELECT rata_placeno, rata_preostalo
  INTO v_rata_placeno, v_rata_preostalo
  FROM krediti
  WHERE krediti_id = v_krediti_id;

  v_rata_placeno := v_rata_placeno + 1;
  v_rata_preostalo := v_rata_preostalo - 1;
  IF(v_rata_preostalo = 0) THEN
    DELETE FROM krediti
    WHERE krediti_id = v_krediti_id;
  ELSE
    UPDATE krediti
    SET rata_placeno = v_rata_placeno,
    	  rata_preostalo = v_rata_preostalo
    WHERE krediti_id = v_krediti_id;
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE uplati_na_hipoteku
  (v_hipoteke_id IN krediti.krediti_id%TYPE,
  v_iznos_uplate NUMBER)
IS
  v_iznos NUMBER;
  v_otplaceno NUMBER;
BEGIN
  SELECT iznos, otplaceno
  INTO v_iznos, v_otplaceno
  FROM hipoteke
  WHERE hipoteke_id = v_hipoteke_id;

  v_otplaceno := v_otplaceno + v_iznos;
  IF(v_otplaceno = v_iznos) THEN
    DELETE FROM hipoteke
    WHERE hipoteke_id = v_hipoteke_id;
  ELSE
    UPDATE hipoteke
    SET otplaceno = v_otplaceno
    WHERE hipoteke_id = v_hipoteke_id;
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE validiraj_pin
  (v_id IN kartice.kartice_id%TYPE,
   v_pin kartice.pin%TYPE)
IS
v_ispravni_pin kartice.pin%TYPE;
BEGIN
  SELECT pin
  INTO v_ispravni_pin
  FROM kartice
  WHERE kartice_id = v_id;
  IF(v_ispravni_pin <> v_pin) THEN
    Raise_Application_Error(-20500, 'Neispravan pin');
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE bankomat_transakcija
  (v_id IN bankomati.bankomati_id%TYPE,
   v_kartice_id IN kartice.kartice_id%TYPE,
   v_pin IN kartice.pin%TYPE,
   v_transakcija NUMBER)
IS
  v_novo_stanje NUMBER;
BEGIN
  validiraj_pin(v_kartice_id, v_pin);

  SELECT stanje
  INTO v_novo_stanje
  FROM bankomati
  WHERE bankomati_id = v_id;

  v_novo_stanje := v_novo_stanje + v_transakcija;

  IF(v_novo_stanje < 0) THEN
    Raise_Application_Error(-20500, 'Nema dovoljno novca na bankomatu');
  ELSE
    izvrsi_transakciju_na_kartici(v_kartice_id, v_transakcija);
    UPDATE bankomati
    SET stanje = v_novo_stanje
    WHERE bankomati_id = v_id;

  END IF;
END;
/

CREATE OR REPLACE PROCEDURE zatvori_poslovnicu
  (v_id IN poslovnice.poslovnice_id%TYPE)
IS
BEGIN
  FOR red IN (
    SELECT osobe_id AS id
    FROM zaposlenici
    WHERE poslovnice_id = v_id
  ) LOOP
    otpusti(red.id);
  END LOOP;

  UPDATE poslovnice
  SET otvorena = 0
  WHERE poslovnice_id = v_id;
END;
/

CREATE OR REPLACE PROCEDURE zatvori_lok_pos_u_reg
  (v_id IN regije.regije_id%TYPE,
  v_min_dobit NUMBER)
IS
BEGIN
  FOR red IN (
    SELECT p.poslovnice_id AS id
    FROM poslovnice p, lokacije l, regije r
    WHERE je_regionalna(p.poslovnice_id) = 0
    AND p.nadredjena_id IS NOT NULL
    AND l.lokacije_id = p.lokacije_id
    AND r.regije_id = l.regije_id
    AND r.regije_id = v_id
  ) LOOP
    IF(dobit_na_kraju_mjeseca(red.id) < v_min_dobit)
    	THEN zatvori_poslovnicu(red.id);
    END IF;
  END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE izvjestaj_kartice
  (v_id IN kartice.kartice_id%TYPE)
IS
BEGIN
  dbms_output.Put_line(LPad('Iznos', 5) + RPad('Datum', 15)); --display
  FOR red IN (
    SELECT t.iznos AS iznos, t.datum AS datum
    FROM transakcije t, racuni r
    WHERE t.racuni_id = r.racuni_id
    AND r.kartice_id = v_id
    ORDER BY t.datum
  ) LOOP
    --Ne znam kako drugacije ovo uraditi
    dbms_output.Put_line(LPad(To_Char(red.iznos), 5) + RPad(To_Char(red.datum, 'DD-MM-YYYY'), 15));
  END LOOP;
END;
/

declare
  broj_licne_karte VARCHAR2(100);
  ime_musterije VARCHAR2(100);
  prezime_musterije VARCHAR2(100);
  broj_licne_karte_ziranta VARCHAR2(100);
  ime_ziranta VARCHAR2(100);
  prezime_ziranta VARCHAR2(100);
  naziv_kredita VARCHAR2(100);
  v_id_tipa_kredita NUMBER;
  iznos NUMBER;
  broj_rata NUMBER;
  v_id_musterije NUMBER;
  v_id_ziranta NUMBER;
  id_poslovnice NUMBER;
  v_temp NUMBER;
BEGIN
  Dbms_Output.put_line('Test');

end;
/




--i) PL/SQL Skripta
-- Svrha je automatizacija izdavanja kredita

--Problem sa skriptom je u tome sto nisam znao na koji nacin
--uzeti bilo kakav input.
--Pokusao sam sa onim referencama koje koriste ampersand al to je samo
--doslovno replace i ignorise tok izvrsavanja komandi, tj useless je u if bloku
--Skripta se bazira na tome da trazi dodatne informacije od korisnika
--u slucaju da neke nedostaju, tako da kolicina informacija nije fiksna na pocetku

--Uglavnom, pošto nisam znao kako se traži input, potrebno je odgovarajuæe varijable
--inicijalizirat na poèetku ispravnim vrijednostima.
--Ovde je dat jedan ispravan input koji ne baca exceptione

declare
  broj_licne_karte VARCHAR2(100) := 30;
  ime_musterije VARCHAR2(100);
  prezime_musterije VARCHAR2(100);
  broj_licne_karte_ziranta VARCHAR2(100) := 60; --brojevi licnih karti su generisani sekvencom radi jednostavnosti
  ime_ziranta VARCHAR2(100) := 'Amar';
  prezime_ziranta VARCHAR2(100) := 'Buric';
  naziv_kredita VARCHAR2(100) := 'Mikrokredit';
  v_tip_kredita NUMBER;
  iznos NUMBER := 1000;
  broj_rata NUMBER := 5;
  v_id_musterije NUMBER;
  v_id_ziranta NUMBER;
  id_poslovnice NUMBER := 1;
  v_temp NUMBER;
BEGIN

  --Unos id-a poslovnice

  --Provjera postojanja poslovnice
  SELECT Count(*)
  INTO v_temp
  FROM poslovnice
  WHERE poslovnice_id = id_poslovnice;
  --Ako ne postoji baci se exception
  IF(v_temp = 0) THEN
    Raise_Application_Error(-20010, 'Poslovnica ne postoji');
  END IF;

  --Unos licne karte musterije. Broj licne karte nije pk, ali je unique za svaku osobu

  --Moja funkcija. Vraca -1 ako ne pronadje, u suprotnom vrati id musterije
  v_id_musterije := nadji_musteriju(broj_licne_karte);
  --Ako ne postoji musterija treba je unijeti
  IF(v_id_musterije = -1) THEN
    dbms_output.put_line('Musterija se ne nalazi u bazi podataka. Potrebno je unijeti ime i prezime');

    --Unos imena musterije
    --Unos prezimena musterije

    --Takodjer gore napisana funkcija.
    --Prvo provjerava da li se osoba vec nalazi u tabeli Osobe(to je slucaj,
    --ukoliko je uposlenik). Ako da, koristi taj id za dodavanje u tabelu Musterije
    --u suprotnom dodaje u obje tabele
    --Vraca id
    v_id_musterije := dodaj_musteriju(ime_musterije, prezime_musterije,
    broj_licne_karte, id_poslovnice);
  END IF;
  --Naziv tipa kredita je unique
  --Trazi id tipa na osnovu naziva
  --Baca exception ako ne postoji
  v_tip_kredita := nadji_tip_kredita(naziv_kredita);
  --Provjerava podobnost musterije za kredit
  --Odredjuje se na osnovu dugova i drugih kredita i
  --Atributa maksimalne kolicine duga za tip kredita
  IF(je_podoban_za_kredit(v_id_musterije, v_tip_kredita) = 0) THEN
    Raise_Application_Error(-20005, 'Musterija nije podobna za taj tip kredita');
  END IF;

  --Unos iznosa i broja rata

  --Radi u biti isti proces kao i za musteriju
  v_id_ziranta := nadji_musteriju(broj_licne_karte_ziranta);
  IF(v_id_ziranta = -1) THEN
    dbms_output.put_line('Zirant se ne nalazi u bazi podataka. Potrebno je unijeti ime i prezime');
    v_id_ziranta := dodaj_musteriju(ime_ziranta, prezime_ziranta,
    broj_licne_karte_ziranta, id_poslovnice);
  END IF;
  --Izdaje kredit
  --Za sve ostale provjere, poput broja rata i iznosa,
  --poklapanje id-a ziranta i musterije i druge stvari
  --se brinu vec ranije napisane procedure unutar ove procedure
  --ili napisani triggeri
  --koji po potrebi bacaju exceptione
  --Neke vrijednosti su fiksirane radi jednostavnosti
  izdaj_kredit(v_id_musterije, v_tip_kredita, iznos, broj_rata, 0,
  NULL, NULL, v_id_ziranta);
end;
/


