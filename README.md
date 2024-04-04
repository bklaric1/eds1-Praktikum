Entwurf digitaler Systeme 1
===========================

Im Rahmen der Veranstaltung Entwurf digitaler Systeme 1 werden einige digitale Systeme entworfen.

  * VGA Bildgenerator
  * serielle Binär zu BCD Umwandlung
  
Technische Umsetzung
--------------------

### Entwicklungsumgebung

Die Schaltungsteile sind in VHDL beschrieben. Als FPGA Board
wird das Altera DE1 Board verwendet. Die Designsoftware ist kostenlos von Altera erhaeltlich. 

  * Synthese: Altera Quartus II
  * Simulation: Altera Mentor Modelsim (Web Edition)

Die Designsoftware ist auf einer virtuellen Maschine fertig installiert. Eine Beschreibung ist hier: http://www.hs-augsburg.de/~beckmanf/dokuwiki/doku.php?id=ubuntu_virtual_cae_system

### Ordnerstruktur

  * src: hier sind alle VHDL Quelldateien
  * sim: hier sind die Makefiles fuer die Simulation der Komponenten
  * pnr: Place and Route - Die makefiles fuer die Synthese der Schaltung
  * scripts: Globale scripts

### Download, Simulation und Synthese 

Das Projekt ist unter git Versionsverwaltung. Für den Zugriff auf den git server der Hochschule über das git Protokoll müssen Sie im VPN sein. Zum Download sind die folgenden Schritte notwendig: 

```
mkdir projects
cd projects
git clone https://gitlab.elektrotechnik.hs-augsburg.de/beckmanf/eds1.git
cd eds1
```

Simulationstest:

```
cd sim
cd bin2bcd
make sim
```

Synthesetest:

```
cd ../../pnr
cd de1_meta
make compile
```

Um das Design auf das Board zu laden muss das Board mit dem Kabel an den USB Anschluss des Rechners angeschlossen sein. Dann:

```
make prog
```

Ein einfaches make zeigt die moeglichen Targets.
