/*

INDIZES

CLUST IX
=Tabelle in sortierter Form
nur 1x pro Tabelle
gut bei Bereichsabfragen, weil sortiert
gut bei eindeutigen Werten 
per SSMS wird immer beim PK ein CL IX gesetzt.. in vielen F�lle dumm


NON CLUST IX
= Kopie von Daten in sortierter Form
ca 1000 mal Tabelle
gut bei geringen Resultset (id)

--------------------------
eindeutiger IX
zusammengesetzter IX
max 16 Spalten/32 und max 900 Schl�ssell�nge

gefilterter IX
nicht alle Datens�tze

IX mit eingeschlossenen Spalten
1023 Spalten
belastet den Baum nicht

partitionierter IX
entspricht gefilteren IX auf yhsikalischer Ebene
----DE------FR-------IT-----UK-------------------------



abdeckender IX
= idelae IX..reinen SEEK, kein Lookup , kein Scan


realer hypothetischer IX-- diese erstellt der Database Tuning Advisor ... unsichtbar im Hintergrun und l�scht sie nach getaner Arbeit wieder


ind Sicht
-------------------------------
Columnstore (Gruppiert und nicht gruppiert)




--Vosrsicht: Index Scan ist nicht schlecht-- weniger Aufwand als Table Scan, aber SEEK w�re besser

--Optimierer entscheidet sich f�r Index-scan , wenn dieser weniger Kosten als Table-scan verursacht
-- user_scan, index_scan  ..nie gebrauchte Indizes evtl l�schen
-- user_scan, index_scan  .. besser als table scan

toDO mit Indizes: Defragmentieren , �berfl�ssige entfernen und fehlende erstellen

-- Brent Ozar SP_blitzIndex-- First Responder Kit 0 Euro

--Wartung--> Wartungsplan: IX Rebuild IX Reorg Statistiken

--Stat:  akt nach 20% �nderung plus 500  zu sp�t, weil ab  ca 1% -- jeden Tag aktualisieren

--IX Reorg ab 10% 
--Rebuild ab 30%

exec sp_updatestats


TIPP:

IX mit eingeschlossenen Spalten
Die Schl�sselspalten blden sich aus den Spalten der where Bedingung
Die eingeschlossenen Spalten entnimmt man aus dem SELECT 


CLUSTERED INDEX.. als Prim�schl�ssel oft pure Verschwendung
CL spielt seine Vorteile bei Berecihsabfragen aus und wird nie Lookup Vorg�nge erzeugen... 
allerdings gibt es diesen nur 1 mal pro Tabellen... Also gut vorher �berlegen
--�ber die Entwurfsansicht der Tabelle--> rechte Maus--> Indizes und Schl�ssel-- als Clustered erstellen (Ja / Nein) l��t sich das �ndern.




*/

select * into ku2 from ku1

dbcc showcontig('ku2') -- 40455

alter table ku2 add id int identity

dbcc showcontig('ku2') -- 41092

set statistics io, time on
select * from ku2 where id =  100 --  57210,  vs  41092

select * from sys.dm_db_index_physical_stats(db_id(), object_id('ku2'),NULL,NULL, 'detailed')

--forward record counts muss NULL sein
--wenn man einen HEAP kann das passieren (neue Spalten)
--ID sind im "Anhang gelandet" und verbrauchen deutlich mehr Platz als notwendig
--CL IX = L�sung


alter table ku1 add id int identity


--CL IX auf Orderdate ist fix

--Welcher Plan? -- T SCAN
select id from ku1 where id = 100  --57206

--besser durch: NIX_ID  --IX SEEK
select id from ku1 where id = 100  --3

--Plan   IX Seek + Lookup       Seiten: 4
select id, freight from ku1 where id = 100

--Lookup unbedingt vermeiden!!!!
select id, freight from ku1 where id < 10500 --ab 10500 ca Table scan

--besser mit: _ID_FR
select id, freight from ku1 where id < 900500 --ab 10500 ca Table scan

--weil der NIX_ID immer noch da ist, sind U D I schlechter 

select * from ku1
where country = 'USA' and freight < 1



select country, city,Sum(UnitPrice*quantity)
from ku1
where employeeid = 2
group by country, city

--where ? 
--select ?

--NIX_EMPID_SCY_incl_CnameLname_Pname
select companyname, lastname, productname
from ku1
where EmployeeID= 2 and Shipcountry = 'USA'

--kein Vorschlag mehr, aber es sollten 2 sein
select companyname, lastname, productname
from ku1
where EmployeeID= 2 or Shipcountry = 'USA'


select country, count(*) from ku1
group by country


create view vdemo
as
select country, count(*) as ANz from ku1
group by country

select * from vdemo

select country, count(*) from ku1
group by country

create or alter view vdemo  with schemabinding
as
select country, count_big(*) as ANz from dbo.ku1
group by country



select * into ku3 from ku1


select Companyname, avg(quantity), min(quantity)
from ku1
where
		country = 'germany'
group by CompanyName


select Companyname, avg(quantity), min(quantity)
from ku3
where
		country = 'germany'
group by CompanyName


--KU3 mit Clumnstore IX .. 3,5 MB


--InMemoryTabellen --schreiben






--Stimmt das oder nicht?

--es stimmt!!!!
--und das genauso im RAM



select Companyname, avg(quantity), min(quantity)
from ku3
where
		city = 'Berlin'
group by CompanyName


create function fRngSumme (@bestnr int) returns money
as
begin
return(select sum(unitprice*quantity) from [Order Details] where orderid = @bestnr)
end


select dbo.frngsumme (10249)




select * from orders where dbo.frngsumme(orderid )< 20000

alter table Orders add RngSumme as dbo.frngsumme(orderid)

select * from orders where rngSumme < 20000

select * from orders where orderdate 



--Wartung der Indizes
--rebuild reorg

--rebuild ab Fragmentierung 30%
--reorg darunter
--unter 10 % nix

--Fehlende IX finden
--�berfl�ssige IX entfernen

select * from sys.dm_db_index_usage_stats

--1 = CL IX
--0 = Heap
--> 1   NCL IX




































