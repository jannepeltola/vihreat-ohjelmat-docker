Tämä ohjelmisto pohjautuu avoimen lähdekoodin projektiin [Atomic Server](https://atomicserver.eu/). Dokumentaatio löytyy [täältä](https://docs.atomicdata.dev).

## Kehitysympäristön pystytys

1. Asenna `docker`ja `docker-compose` [alustallesi sopivalla tavalla](https://docs.docker.com/get-docker/). Halukkaat voivat asentaa vain Dockerin asiakasohjelmat ja ajaa Docker-daemonina [Colimaa](https://github.com/abiosoft/colima).
2. Rakenna konttien kuvat ja aja ympäristö: `bash start.sh`. Tämä luo tarvittavien konttien kuvat koneellesi ajettavaksi ja nostaa ympäristön pystyyn `docker-compose`lla.
3. Ohjelmien tarkastelusovellus on nyt tarjolla osoitteessa http://localhost:5175 ja Atomic Server osoitteessa http://localhost:9883.

**ÄLÄ KÄYTÄ KEHITYSYMPÄRISTÖÄ TUOTANNOSSA. ATOMIC-SERVERIÄ EI OLE KOVENNETTU.**

## Kehittäminen

Ohjelma-alusta on toteutettu laajentamalla Atomic Serverin selainpakettia `browser`.  Laajennuskoodi sijaitsee pääosin uusissa paketeissa `browser/vihreat-ohjelmat` ja `browser/vihreat-lib`.  Lisäksi kansio `vihreat-data` sisältää työkaluja datan generointiin.

### `vihreat-data`

Sisältää ontologian (datamallin) määrittelyn sekä työkalun `generate-ld`, jolla ontologia ja muu testidata generoidaan Atomic Serverin ymmärtämään JSON-AD -muotoon. Docker-kuvan uudeelleenrakentaminen luo uuden instanssin uudella ontologialla ja testisisällöllä (olemassa oleva tietokanta tuhoutuu!).

### `browser/vihreat-ohjelmat`

Sisältää ohjelma-alustan asiakassivun. Sivulla voi kuka tahansa (tulevaisuudessa) hakea ja tarkastella ohjelmia.

### `browser/vihreat-lib`

Sisältää ohjelma-alustan [ontologian TypeScript-tyypit](https://docs.atomicdata.dev/js-cli) ja yhteisiä React-komponentteja. Asiakas- ja admin-sivuille yhteinen koodi löytyy täältä (esim. ohjelmanäkymä).

# Docker
Yli kaksi gigaa muistia!