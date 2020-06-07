# Skyline Bot

Aqui trobem la implementació d'un bot de telegram per a poder generar i operar amb skylines en python3.

## Preparacio

A continuació s’explica com s’ha de fer per a poder executar el bot.

### Prerequisits

Per a poder executar el bot necessitem Python3 instal·lat en el nostre sistema, en ubuntu en principi ve en el sistema per defecte però si no esta instalat es pot realitzar el seguent:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3.6
```

Per a les altres llibreries necessitem executar la seguent comanda:

```bash
pip install -r example-requirements.txt
```

### Intal·lació

En ser un bot programat amb python no necessitem cap compilació prèvia per a la seva execució, el que si hem de realitzar abans de tot, es dins de l'arxiu `bot.py` en l'apartat de `TOKEN` li hem de posar el token que reben del `BotFather` de telegram per a que tot funcioni.

## Execució

Una vegada hem posat el token al bot, només cal utilitzar la seguent comanda a la terminal:

```bash
python3 bot.py
```
Una vegada hem posat la comanda en molt poc temps el bot queda operatiu i ja podem interactuar amb ell mitjançant telegram.


## Funcionament

A continuació s’explica un poc el funcionament del bot, la clase Skyline i el parser de la gramàtica que s'utilitza per a la generació de skylines

### Bot de telegram

El bot de telegram per a cada comanda definida en el help té una funció programada, es aspectes importants del bot és la utilització de `context.user_data[]` que és un diccionari individual per a cada usuari que interactua amb el bot.

En aquest diccionari hi posen un `userID` que és el nom d'usuari que aparentment es unic, l'utilitza el bot per a poder guardar les variables que l'usuari vol o el nom de les fotografies per a poder evitar el maxim nombre possible de solapaments de noms amb els arxius.

Per l'altra banda també i crea la entrada `skylines` que és un diccionari utilitzat per a la assignació de skylines.

Finalment el bot utilitza la clase `pickle` per a la gestió de guardat i recuperació de variables.

### Clase Skyline

Un skyline està representat per una llista origninalment buida `buildings` que conté objectes del tipus `Building` i dues variables més `area`, que representa la suma de les arees dels edificis que conformen la llista `buildings` i finalment `hei` que representa l'edifici més alt de l'skyline

La clase `Building` te com a variables `xmin`, `xmax` representant la seva coordenada minima i maxima, per representar la altura d'aquesta te la variable `y` i finalment per representar la area de cada edifici tenim la variable `area` i `overlaped`, overlaped s'utilitza, en el cas de solapaments de saber quina es la altura efectiva de l'edifici en aquests casos.

Cada cerca dins de la llista de buildings es fa a partir d'una cerca dicotomica per a que el cost de buscar la posició d'un nou edifici sigui baix.

### Parser

En el parser s'especifquen les diferents operacions entre skylines i la definició de les variables que els componen, alhora de definir els skylines de dins els paresentesi i les diferents llistes he optat per a canviarli el nom perquè alhora de visitar i evaluar les expressions és més simple ja que podem saber exactament en quines posicions del elements que conformen el context. 

## Creat amb
* [Python3] (https://www.python.org/) - Llenguantge de programació utilitzat per al Bot, la clase Skyline i EvalVisitor

* [Antlr4] (https://www.antlr.org/) - LLenguatge utilitzat per a la creació del parser i el visitor

## Autors

* **Bartomeu Perelló Comas** - *Tot el projecte* - [GitHub](https://github.com/IDarkgenesis)
