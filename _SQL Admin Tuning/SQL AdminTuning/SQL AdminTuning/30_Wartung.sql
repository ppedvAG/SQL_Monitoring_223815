--> f�r SQL 2014 und fr�her empfiehlt sich statt Wartungsplan das Script von Ola Hallengren zu verwenden
--hier werden Fragmentierungen ber�cksichtigt

-- > 30 % --> Rebuild
-- < 10 %       kein Defrag notwendig
-- 10 bis 30  ---> Reorg


/*

zu einer Wartung geh�rt auch das Aktualisieren von Statistiken.
Statistiken: SQL pr�ft  -vor Ausf�hrung von Abfragen - wieviele Zeilen zur�ckkommen.
Diese Anzahl wird aus dem Histogramm gebildet, dass der SQL Server automatisch erstellt.
Histogramm: Verteilung der Daten innerhalb einer Spalte (oder auch mehr Spalten)
Werden nicht bei jedem I U D aktualisiert und k�nnen somit falsch sein..

--Plan muss aber aufgrund der zu erwartenden Menge f�r SEEK oder SCAN entscheiden...


Je "korrekter" diese sind, desto exakter kann ein Ausf�hrungsplan eingesch�tzt werden...


Tools.. Datenbankoptimierungsassistent

Finden einer geeigneten IX Strategie
Einstellungen: 
Indizes und Indizierte Sichten
Partitionierung oder Columnstore w�hlen
Keine pyhs. Entwurfsstrukturen beibehalten
Erweiterte Optionen
	wenn m�glich Online
	max RAM H�ckchen



---Tool Perfmon und Profiler

Daten des Perfmon k�nne in Profiler geladen werden
--Aufzeichnung neu �ffnen
--Datei--> Import der Perfmon Daten

die Aufzeichnung des Profiler kann auch f�r den Datenbankoptimierungsratgeber verwendet werden.-- IX finden und L�schen auf der Basis eines typischen Workload
(oder �ber QueryStore)



*/
