
Prozessor: Prozessorzeit
Diese sollte nat�rlich nicht auf Dauer allzu hoch sein. Messunen �ber 50% bis 60%, sollten abgekl�rt werden (Auslagerungen, Kompilierungen etc)
PhysicalDisk: AverageDiskQueueLength
Dieser Wert sollten nicht �ber 2 sein. Der Wert gibt n�mlich an, ob Der physik. Datentr�ger Daten schnell genug wegschreiben kann.
Speicher: Seiten/sec
Seiten, die entweder vom Speicher auf den Datentr�ger geschrieben werden oder davon gelesen und in den Sepicher geschrieben werden. Der Wert sollte auf Dauer kleiner als 20 sein.
BufferManager: BufferCacheHitRatio
Die %-Quote gibt an, wieviel der angefragten Daten (Seiten) aus dem Speichercahce geholt werden k�nnen. Der Wert sollte gr��er 90% sein. Dadurch, dass der SQL Server jede Menge �Read Ahead Vorg�nge erzeugt, ist der Wert nicht allzuaussagekr�ftig. Bereits nach Start des SQL Dienstes weist er einen Wert von kanpp unter 100% aus� obwohl noch keine Daten abgefragt wurden??!!
Plan Cache: Trefferquote
Jede Frage ben�tigt einen Ausf�hrungsplan. Im g�nstigsten Fall liegt dieser bereits vor. Falls nicht, muss ein neuer Plan erstellt und kompiliert werden. Das kostet Prozessorzeit.
Falls also die Prozessorleistung sehr hoch ist, sollten sie diesen Wert und Transactions / sec untersuchen. Die Trefferquote sollte so hoch wie m�glich sein.
GenerelStatitics: User Connections
Anzahl der Benutzerverbindungen
Puffer Manager: Page Life Expectancy
Seiten werden in den Speicher geladen, um die Requests der Clients schnell bedienen zu k�nnen. Die gecachten Seiten k�nnen aufgrund von zu wenig Platz zugunsten anderer Seiten aus dem Cache entfernt werden. Der Wert sollte nicht unter 300 liegen. Sonst haben Sie zu wenig Hauptspeicher
SQL Statistics: Kompilierungen /sec
Ausf�hrungspl�ne bed�rfen einer kompilierung und evtl auch einer Recompilierung. Diese f�hrt zu einer h�heren CPU Last. Sollte dieser Wert sich erh�hen, k�nnen Sie evtl durch paramtriesierung ihrer Abfragen eine Verbesserung erreichen.
SQL Statistics: Recompilierungen /sec
Dieser Wert steigt, sobald kompilierte Pl�ne durch verschiedene SET Einstellungen erneut kompiliert werden m�ssen.
SQL Benutzerdefinierbar: User Counter 1 (bis 10)
Ein Indikator der mir pers�nlich sehr gut gef�llt. �bergibt man der sp_Usercounter1 eine ganze Zahl  so wird diese sofort im Systemmonitor dargestellt. SO lie�e sich z.B. der Tagesumsatz im Verh�ltnis zur CPU oder Speicher darstellen. In Worten: Ab einem bestimmten  Umsatz proTag braucht man eine besser CPU. 
SQL Locks: durschnittliche Wartezeit (ms)
