<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    <!-- Sprache, default ist Deutsch -->
    <xsl:param name="language" select="(//lang, 'de')[1]"/>
    <!-- Default Standort-URL -->
    <xsl:param name="locationurl" select="'https://www.uni-giessen.de/ub/de/ueber-uns/standorte/'"/>
    <!-- Tabelle "bbtabelle" mit allen Infomationen zu den Standorten:
         c : [pflicht] Standort-Code wie er in effectiveLocation/discoveryDisplayName übergeben wird, gleichzeitig Sortierkriterium
         n : [pflicht, wiederholbar] Name des Standorts wir er ausgegeben werden soll, ggf. sprachabhängig <n xml:lang="de">...</n><n xml:lang="en">...</n>
             (Bei Fehlen des Sprachtextes wird der Text der ersten Sprache verwendet.)
         ind : [optional] Ausleihindikator, überschreibt für diesen Standort den Wert, der aus FOLIO kommt
         url : [optional] URL für den Nutzer mit Infomationen für den Nutzer (z.B. Normdatensatz), default siehe oben
         map : [optional, wiederholbar] mit linktype="mapongo" oder linktype="bibmap" oder linktype="semapp", z.B. <map linktype="mapongo"/>
         campus : [optional] Für standortübergreifende Angaben, z.B. Magazinbestände oder Handapparate -->
    <xsl:variable name="bbtabelle">
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL05</c>
            <n xml:lang="de">WiWi/BWL 5; Licher Str. 74</n>
            <url>http://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=025</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Psychiat-Neurol</c>
            <n xml:lang="de">Bibl. Psychiatr. / Neurol.; Klinikstr. 36 </n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=259</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/ÖkologischerLandbau</c>
            <n xml:lang="de">Prof. f. Ökolog. Landbau, Schwerp. Nachw. Bodennutzung; Phil. II C, Zi. 116b</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=372</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Milchwissenschaften</c>
            <n xml:lang="de">Bibl. Milchwissenschaften; Ludwigstr. 21, EG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=172</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBSemapp</c>
            <ind>9 g nicht_ausleihbar</ind>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <map linktype="semapp"/>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL05</c>
            <n xml:lang="de">Wiwi/VWL 5; Licher Str. 66</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=335</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZNL/Magazin</c>
            <n xml:lang="de">ZwBibl. Natur- u. Lebenswiss. (ZNL); Heinrich-Buff-Ring 58, 5. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=002</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Genetik</c>
            <n xml:lang="de">Bibl. Genetik; Heinrich-Buff-Ring 58, 3. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=157</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Klinik-Wiederkäuer</c>
            <n xml:lang="de">Bibl. Klinik Wiederkaeuer; Frankfurter Str. 110, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=186</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZNL/Handapparate</c>
            <n xml:lang="de">ZwBibl. Natur- u. Lebenswiss. (ZNL); Heinrich-Buff-Ring 58, 5. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=002</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Mathe-Informatik</c>
            <n xml:lang="de">Bibl. Mathematik; Arndtstr. 2 </n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=120</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Mathe-Informatik-HAP</c>
            <n xml:lang="de">Bibl. Mathematik; Arndtstr. 2 </n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=120</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL09</c>
            <n xml:lang="de">Wiwi/BWL 9; Licher Str. 70</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=342</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZRW/Unbekannt</c>
            <n xml:lang="de">ZwBibl. Recht und Wirtschaft, Licher Str. 68</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=010</url>
        </e>
        <e>
            <c>ILN204/E/E/Datenbanken</c>
            <n xml:lang="de">Bibliothekssystem Gießen: Datenbanken</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=993</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Tierhygiene</c>
            <n xml:lang="de">Bibl. Hygiene d. Tiere; Frankfurter Str. 89-91, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=179</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZP2/Unbekannt</c>
            <n xml:lang="de">ZwBibl. im Phil. II F</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=009</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/LW-Inklusion-ZfL</c>
            <n xml:lang="de">Lernwerkstatt Inklusion / Zentrum für Lehrerbildung </n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=374</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZHB/Magazin</c>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/Freihand2OG</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <map linktype="mapongo"/>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Hermann-Hoffmann-Akademie</c>
            <n xml:lang="de">Bibl. Hermann-Hoffmann-Akademie; Senckenbergstr. 17 u. 25, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=151</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZP2/Handapparate</c>
            <n xml:lang="de">ZwBibl. im Phil. II F</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=009</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Fachbibliotheken</c>
            <n xml:lang="de">Dezentrale Fachbibliotheken</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL01</c>
            <n xml:lang="de">Wiwi/VWL 1; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=331</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Klass-Philologie</c>
            <n xml:lang="de">Bibl. Klass. Philologie; Phil. I G, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=111</url>
        </e>
        <e>
            <c>ILN204/E/E/E-Journals</c>
            <n xml:lang="de">Elektronische Zeitschriftenbibliothek der Universität Gießen</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=992</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL04</c>
            <n xml:lang="de">Wiwi/VWL 4; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=345</url>
        </e>
        <e>
            <c>ILN204/CG/Aufsatz/Aufsatzkatalogisate</c>
            <n xml:lang="de">Standort / Signatur siehe Link weiter oben hinter "Erschienen in:"</n>
            <ind>9 y unbekannt</ind>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=950</url>
        </e>
        <e>
            <c>ILN204/CG/Aufsatz/dodummy</c>
            <ind>y</ind>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL02</c>
            <n xml:lang="de">Wiwi/VWL 2; Licher Str. 74</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=332</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/SlavistikMediathek</c>
            <n xml:lang="de">Slavistik / Mediathek; Phil. I D, R. 504</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=116</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Ländliches-Genossenschaftswesen</c>
            <n xml:lang="de">Bibl. Ländl. Genossensch.; Senckenbergstr. 3, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=209</url>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagPhil1</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Hygiene-Umweltmedizin</c>
            <n xml:lang="de">Bibl. Hygiene u. Umweltmedizin; Friedrichstr. 16, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=237</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagKeller</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Mediothek-Musikwiss</c>
            <n xml:lang="de">Mediothek Musikwiss., Phil. II D</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=055</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Prozesstechnik</c>
            <n xml:lang="de">Bibl. Prozesstechnik; Stephanstr. 24</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=192</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Zoologie1</c>
            <n xml:lang="de">Bibl. Zoologie I; Stephanstr. 24, EG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=154</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Reproduktionsmedizin-und-Neugeborenenkunde</c>
            <n xml:lang="de">Bibl. Tierklinik f. Reproduktionsmedizin u. Neugeborenenkunde; Frankfurter Str. 106</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=187</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZRW/Freihand</c>
            <n xml:lang="de">ZwBibl. Recht und Wirtschaft, Licher Str. 68</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=010</url>
        </e>
        <e>
            <c>ILN204/CG/UB/Freihand1OG</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <map linktype="mapongo"/>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Anatomie</c>
            <n xml:lang="de">Bibl. Anatomie; Aulweg 123</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=231</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZHB/Handapparate</c>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL03</c>
            <n xml:lang="de">Wiwi/BWL 3</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=023</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/Sonderstandorte</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Virologie</c>
            <n xml:lang="de">Bibl. Virologie (Vet.-Med.); BFS, Schubertstr. 81, 2.OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=189</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZHB/Erwerbungssignatur</c>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
        </e>
        <e>
            <c>ILN204/CG/UB/Erwerbungssignatur</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
        </e>
        <e>
            <c>ILN204/CG/ZRW/Erwerbungssignatur</c>
            <n xml:lang="de">ZwBibl. Recht und Wirtschaft, Licher Str. 68</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=010</url>
        </e>
        <e>
            <c>ILN204/CG/ZHB/ZHBSemapp</c>
            <ind>g nicht_ausleihbar</ind>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
            <map linktype="semapp"/>
        </e>
        <e>
            <c>ILN204/CG/ZRW/Handapparate</c>
            <n xml:lang="de">ZwBibl. Recht und Wirtschaft, Licher Str. 68</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=010</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Veterinaerphysiologie</c>
            <n xml:lang="de">Bibl. Vet. Physiologie; Frankfurter Str. 100, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=175</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL02</c>
            <n xml:lang="de">Wiwi/BWL 2; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=022</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZHB/Unbekannt</c>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Pferdeklinik</c>
            <n xml:lang="de">Pferdeklinik; Frankfurter Str. 108, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=185</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/E/E/E-Books</c>
            <n xml:lang="de">Bibliothekssystem Gießen: E-Books</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=994</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL08</c>
            <n xml:lang="de">Wiwi/BWL 8; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=028</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Tieraerztliche-Nahrungsmittelkunde</c>
            <n xml:lang="de">Bibl. Tierärztl. Nahrungsmittelk.; Frankfurter Str. 92, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=178</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZP2/ZP2Semapp</c>
            <ind>g nicht_ausleihbar</ind>
            <n xml:lang="de">ZwBibl. im Phil. II F</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=009</url>
            <map linktype="semapp"/>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Pathologie</c>
            <n xml:lang="de">Bibl. Pathologie; Langhansstr. 10</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=234</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Rechtsmedizin</c>
            <n xml:lang="de">Bibl. Rechtsmedizin; Frankfurter Str. 58a, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=238</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/Unbekannt</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Parhmakol-Toxikol-BFS</c>
            <n xml:lang="de">Bibl. Pharmakol. u. Toxikol.; BFS, Schubertstr. 81, 3.OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=190</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMag3</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagZNL</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-Statistik-Oekonometrie</c>
            <n xml:lang="de">Wiwi/ Statistik &amp; Oekonometrie; Licher Str. 64</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=341</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Germanistik</c>
            <n xml:lang="de">Bibl. Germanistik; Phil. I B, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=090</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Germanistik-HAP</c>
            <n xml:lang="de">Bibl. Germanistik; Phil. I B, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=090</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/DidWerkSpr</c>
            <n xml:lang="de">Didaktische Werkstatt Sprachen, Otto-Behaghel-Str. 10B, Raum 230</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=376</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Biochemie-Endokrinologie</c>
            <n xml:lang="de">Bibl. Biochem. u. Endokrin.; Frankfurter Str. 100, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=176</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/Handapparate</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Veterinaeranatomie</c>
            <n xml:lang="de">Bibl. Vet. Anatomie; Frankfurter Str. 98, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=174</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/EDZ</c>
            <n xml:lang="de">Europ. Dokumentationszentrum, Licher Str. 76</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=015</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/LernwerkstattIFIB</c>
            <n xml:lang="de">Lernwerkstatt des IFIB, Karl-Gloeckner-Str. 21 B, Raum 013</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=375</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Geschichte-der-Medizin</c>
            <n xml:lang="de">Bibl. Geschichte der Medizin; Iheringstr. 6</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=236</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL07</c>
            <n xml:lang="de">Wiwi/BWL 7; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=027</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL06</c>
            <n xml:lang="de">Wiwi/VWL 6; Licher Str. 66</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=336</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/AKWildbiologie</c>
            <n xml:lang="de">Bibl. AK Wildbiologie; Leihgesterner Weg 217</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=380</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Testothek-Psychologie</c>
            <n xml:lang="de">Testothek im Fachgebiet Psychologie</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=061</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/E/E/Online Medien</c>
            <n xml:lang="de">Elektronische Zeitschriftenbibliothek der Universität Gießen</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=992</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Biochemie</c>
            <n xml:lang="de">Bibl. Biochemie; Friedrichstr. 24, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=233</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Veterinärpathologie</c>
            <n xml:lang="de">Bibl. Vet. Pathologie; Frankfurter Str. 96, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=177</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZRW/ZRWSemapp</c>
            <ind>g nicht_ausleihbar</ind>
            <n xml:lang="de">ZwBibl. Recht und Wirtschaft, Licher Str. 68</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=010</url>
            <map linktype="semapp"/>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Anglistik</c>
            <n xml:lang="de">Bibl. Anglistik; Phil. I B, 3. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=100</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Anglistik-HAP</c>
            <n xml:lang="de">Bibl. Anglistik; Phil. I B, 3. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=100</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Strahelnschutz</c>
            <n xml:lang="de">Strahlenschutz; Leihgesterner Weg 217</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=138</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-VWL03</c>
            <n xml:lang="de">Wiwi/VWL 3; Licher Str. 66</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=333</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL01</c>
            <n xml:lang="de">Wiwi/BWL 1; Licher Str. 66</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=021</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBSLS</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagPohlheim</c>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
            <campus>Magazin</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL10</c>
            <n xml:lang="de">Wiwi/BWL 10; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=343</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Augenklinik</c>
            <n xml:lang="de">Bibl. Augenklinik; Friedrichstr. 18, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=258</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Biomathematik</c>
            <n xml:lang="de">Bibl. AG Biomathematik; Frankfurter Str. 95, EG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=211</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Historisches-Institut</c>
            <n xml:lang="de">Bibl. Histor. Institut; Phil. I C 2, 1. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=084</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZP2/Erwerbungssignatur</c>
            <n xml:lang="de">ZwBibl. im Phil. II F</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=009</url>
        </e>
        <e>
            <c>ILN204/CG/ZHB/Freihand</c>
            <n xml:lang="de">Zeughausbibl.; Senckenbergstr. 3, Erdgeschoss</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=005</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Romanistik</c>
            <n xml:lang="de">Bibl. Romanistik; Phil. II G, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=112</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Romanistik-HAP</c>
            <n xml:lang="de">Bibl. Romanistik; Phil. II G, 2. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=112</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Arbeitsmedizin</c>
            <n xml:lang="de">Bibl. Arbeitsmed.; Aulweg 129/III, 4. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=235</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Physiologie</c>
            <n xml:lang="de">Bibl. Physiologie; Aulweg 129, 4. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=232</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/AAA-DaF</c>
            <n xml:lang="de">Bibl. Akad. Auslandsamt, Deutsch als Fremdspr., Goethestr. 58, R. 230</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=322</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/E/E/GEB</c>
            <n xml:lang="de">Gießener Elektronische Bibliothek</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=990</url>
        </e>
        <e>
            <c>ILN204/CG/ZNL/Unbekannt</c>
            <n xml:lang="de">ZwBibl. Natur- u. Lebenswiss. (ZNL); Heinrich-Buff-Ring 58, 5. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=002</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Tierschutz-Ethologie</c>
            <n xml:lang="de">Bibl. Tierschutz und Ethologie; Frankfurter Str. 104</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=180</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Uniarchiv-SLS</c>
            <n xml:lang="de">Universitaetsarchiv; Otto-Behaghel-Str. 8, 1. OG, Sonderlesesaal</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=290</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Gefluegelkrankheiten</c>
            <n xml:lang="de">Bibl. Gefluegelkrankheiten; Frankfurter Str. 114</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=182</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Dermatologie</c>
            <n xml:lang="de">Bibl. Dermatologie; Gaffkystr. 14, EG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=250</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Sudetendeutsches-Woerterbuch</c>
            <n xml:lang="de">Sudetendt. Wörterbuch; Zeughaus, Senckenbergstr. 3, 2.OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=092</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZNL/Freihand</c>
            <n xml:lang="de">ZwBibl. Natur- u. Lebenswiss. (ZNL); Heinrich-Buff-Ring 58, 5. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=002</url>
        </e>
        <e>
            <c>ILN204/CG/UB/UBFernleihen</c>
            <n xml:lang="de">UB Fernleihen</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=000</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL06</c>
            <n xml:lang="de">Wiwi/BWL 6; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=026</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/FB-Klass-Archaeologie</c>
            <n xml:lang="de">Bibl. Klass. Archaeol.; Phil. I D, EG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=082</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZP2/Freihand</c>
            <n xml:lang="de">ZwBibl. im Phil. II F</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=009</url>
        </e>
        <e>
            <c>ILN204/CG/DezFB/Kleintier-Innere-Chirurgie</c>
            <n xml:lang="de">Bibl. Kleintierklinik (Innere und Chirurgie)</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=184</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/AngewTheaterwiss</c>
            <n xml:lang="de">Angewandte Theaterwissenschaft / Mediathek; Gutenbergstr. 6</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=117</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/DezFB/WiWi-BWL04</c>
            <n xml:lang="de">Wiwi/BWL 4; Licher Str. 62</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=024</url>
            <campus>Fachbibliotheken</campus>
        </e>
        <e>
            <c>ILN204/CG/ZNL/Erwerbungssignatur</c>
            <n xml:lang="de">ZwBibl. Natur- u. Lebenswiss. (ZNL); Heinrich-Buff-Ring 58, 5. OG</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/bik?bik=002</url>
        </e>        

    </xsl:variable>

    <xsl:variable name="hap-tabelle">
        <hap nr="hap10109999">Lernzentrum Veterin&#xe4;rmedizin, Frankfurter Str. 98</hap>
        <hap nr="hap10117070">Prof. Augsberg, Hein-Heckroth-Str. 5</hap>
        <hap nr="hap10117071">Prof. Bast, Licher Str. 64</hap>
        <hap nr="hap10117072">Prof. Sch&#xf6;ndorf-Haubold, Hein-Heckroth-Str. 5</hap>
        <hap nr="hap10117073">Prof. Marauhn, Licher Str. 76</hap>
        <hap nr="hap10117074">Prof. Reimer, Hein-Heckroth-Str. 5</hap>
        <hap nr="hap10117075">Prof. Adolphsen, Licher Str. 76</hap>
        <hap nr="hap10117076">Prof. Walker, Licher Str. 72</hap>
        <hap nr="hap10117077">Prof. Ekkenga, Licher Str. 76</hap>
        <hap nr="hap10117078">Prof. Dubovitskaya, Licher Str. 72</hap>
        <hap nr="hap10117079">Prof. Gutzeit, Licher Str. 76</hap>
        <hap nr="hap10117080">Prof. Keiser, Licher Str. 76</hap>
        <hap nr="hap10117081">Prof. Gruber, Licher Str. 76</hap>
        <hap nr="hap10117082">Prof. Benicke, Licher Str. 76</hap>
        <hap nr="hap10117083">Prof. Kretschmer, Bismarckstr. 16</hap>
        <hap nr="hap10117084">Prof. Rotsch, Bismarckstr. 16</hap>
        <hap nr="hap10117085">Prof. Hauck, Licher Str. 76</hap>
        <hap nr="hap10117086">Prof. Bannenberg, Licher Str. 64</hap>
        <hap nr="hap10117087">Prof. Britz, Hein-Heckroth-Str. 5</hap>
        <hap nr="hap10117093">Juniorprof. von Achenbach, \Oeffentl. Recht, Licher Str. 64</hap>
        <hap nr="hap10117094">Juniorprof. Czelk, B&#xfc;rgerl. Recht, Licher Str. 64</hap>
        <hap nr="hap10117097">Prof. Rudkowski, Licher Str. 72</hap>
        <hap nr="hap10117098">Prof. Hailbronner, Licher Str. 64</hap>
        <hap nr="hap10117099">Prof. Auer, Licher Str. 76</hap>
        <hap nr="hap10217087">Juniorprof. Gissel, Gesundheits&#xf6;konomie VWL VIII, Licher Str.
            62</hap>
        <hap nr="hap10217088">Prof. Bertschek, VWL IX, Licher Str. 64</hap>
        <hap nr="hap10217090">Prof. Pr&#xf6;llochs, Data Science und Digitalisierung, Licher Str.
            74</hap>
        <hap nr="hap10217091">Prof. J. Pfeiffer, BWL, Digitalisierung, E-Business und Operations
            Management, Licher Str. 74</hap>
        <hap nr="hap10217092">Prof. Stockburger, Daten&#xf6;konomie VWL X, Licher Str. 62</hap>
        <hap nr="hap10310010">Prof. Gronemeyer, Inst. f. Soziologie, Phil. II H</hap>
        <hap nr="hap10310172">Prof. Bruesemeister, Inst. f. Soziologie, Phil. II E</hap>
        <hap nr="hap10310173">Prof. Schl&#xfc;ter, Inst. f. Soziologie, Phil. II E, Zi. 017b</hap>
        <hap nr="hap10310176">Prof. Ahrens, Inst. f. Soziologie, Phil. II E</hap>
        <hap nr="hap10310271">Prof. Grasse, Politikwiss., Phil. II E, Zi.109</hap>
        <hap nr="hap10310272">Prof. Kreide, Inst. f. Politikwiss., Phil. II E</hap>
        <hap nr="hap10310274">Prof. de Ne\-ve, Inst. f. Politikwiss., Phil. II E</hap>
        <hap nr="hap10310275">Prof. Abendsch&#xf6;n, Inst. f. Politikwiss., Phil. II E</hap>
        <hap nr="hap10310276">Prof. Breitmeier, Inst. f. Politikwiss., Phil. II E</hap>
        <hap nr="hap10310277">Prof. Gawrich, Inst. f. Politikwiss., Phil. II E</hap>
        <hap nr="hap10310280">Prof. Schmitt, Did. d. Sozialwiss., Phil. II E</hap>
        <hap nr="hap10320170">Prof. Miethe, Inst. f. Erziehungswiss., Phil. II B</hap>
        <hap nr="hap10320171">Prof. Wiezorek, Phil. II B</hap>
        <hap nr="hap10320173">Prof. K&#xe4;pplinger, Inst. f. Erziehungswiss., Phil. II B</hap>
        <hap nr="hap10320174">Prof. C. Schmidt, Berufsp&#xe4;dagogik, Phil II, Haus B</hap>
        <hap nr="hap10320175">Prof. Stecher, Inst. f. Erziehungswiss., Emp. Bildungsforschung, Phil.
            II B</hap>
        <hap nr="hap10320176">Prof. Braun, Inst. f. Erziehungswiss., Lehrerbildung, Bismarckstr.
            37</hap>
        <hap nr="hap10320270">Prof. Stoeppler, Inst. f. Heil- u. Sonderp&#xe4;d., Phil. II B</hap>
        <hap nr="hap10320271">Prof. Timberlake , Inst. f. Heil- u. Sonderp&#xe4;d., Phil. II
            B</hap>
        <hap nr="hap10320272">Prof. van Minnen, Inst. f. Heil- u. Sonderp&#xe4;d., Phil. II
            B</hap>
        <hap nr="hap10320273">Prof. von Stechow, Heil- u. Sonderp&#xe4;d., Phil. II, Haus B</hap>
        <hap nr="hap10320370">Prof. Seifert, Inst. f. Schulp&#xe4;d., Phil. II B</hap>
        <hap nr="hap10320371">Prof. Rakoczy, Erziehungswiss. Schwerpunkt Schulp&#xe4;d. u. emp.
            Bildungsf. Phil. II B 123</hap>
        <hap nr="hap10320374">Prof. Neuss, Inst. f. Schulp&#xe4;d. und Did. d. Sozialwiss., Phil. II
            B</hap>
        <hap nr="hap10320375">Prof. Hinzke, Erziehungswiss. mdS Lehrerfortbildungsf., Bismarckstr.
            37, R. 204</hap>
        <hap nr="hap10320376">Prof. Ernst, Inst. f. Kindheits- und Schulp&#xe4;dagogik, Ludwigstr.
            34 (ZMI)</hap>
        <hap nr="hap10329997">F&#xf6;rderwerkstatt d. Abt. Sprachheilp&#xe4;dagogik, Phil. II B, R.
            013</hap>
        <hap nr="hap10329998">Bildungswerkstatt, Phil. II B 122 a</hap>
        <hap nr="hap10329999">Didaktische Lernwerkstatt / Arbeitsstelle f&#xfc;r Inklusion, Phil. II
            B, R. 013</hap>
        <hap nr="hap10330101">Diathek / Herr Dr. Steinm&#xfc;ller, Inst. f. Kunstp&#xe4;dagogik,
            Phil. II, Haus H</hap>
        <hap nr="hap10330170">Prof. Buschk&#xfc;hle, Inst. f. Kunstp&#xe4;dagogik, Phil. II, Haus
            H</hap>
        <hap nr="hap10330171">Prof. Schnurr</hap>
        <hap nr="hap10330173">Prof. Schepers, Inst. f. Kunstp&#xe4;dagogik, Phil. II, Haus H</hap>
        <hap nr="hap10340171">Prof. Bullerjahn, Inst. f. Musikwiss. u. Musikpaed., Phil. II
            D</hap>
        <hap nr="hap10409999">Mediathek Evangelische und Katholische Theologie, Phil. II H
            209</hap>
        <hap nr="hap10410170">Prof. Eisen, Ev. Theologie, Phil. II H</hap>
        <hap nr="hap10410171">Prof. Brinkmann, Inst. f. Evangel. Theologie, Phil. II, Haus H</hap>
        <hap nr="hap10410172">Prof. David, Ev. Theologie, Phil. II H</hap>
        <hap nr="hap10410173">Prof. Lexutt, Ev. Theologie, Phil. II H</hap>
        <hap nr="hap10420171">Prof. Pruchniewicz, Inst. f. Kath. Theol., Phil II H</hap>
        <hap nr="hap10420173">Prof. Schmidt, Kath. Theologie, Phil. II H</hap>
        <hap nr="hap10437001">Didaktik d. Geschichte, Phil. I C, Zi. 204</hap>
        <hap nr="hap10437070">Handapparat Alte Geschichte, Histor. Inst., Alte Geschichte, Phil. I
            G</hap>
        <hap nr="hap10437072">Prof. Weckel, Fachjournalistik Geschichte, Phil. I, C</hap>
        <hap nr="hap10440170">Prof. Ruby, Inst. f. Kunstgesch., Otto-Behaghel-Str. 10G, Raum
            G332</hap>
        <hap nr="hap10440171">Prof. Sp&#xe4;th, Kunstgeschichte, Phil. I G</hap>
        <hap nr="hap10447171">Inst. f. Kunstgeschichte, Phil. I, G</hap>
        <hap nr="hap10450170">Prof. Lorenz, Klass. Arch&#xe4;ologie, Otto-Behaghel-Str. 10 D</hap>
        <hap nr="hap10470170">SFB Erinnerungskulturen, Islamwissenschaft, Phil. I E</hap>
        <hap nr="hap10470171">Prof. Kirchner, Professur f. Turkologie, Phil. I E</hap>
        <hap nr="hap10470172">Prof. Sarikaya, Prof. f. Islamische Theologie, Phil. I E</hap>
        <hap nr="hap10470174">Prof. C\,akir-Mattner, Prof. f. Isl. Theol. musl. Lebensgest., Phil. I
            D</hap>
        <hap nr="hap10490170">Prof. \Oezmen, Zentr. f. Philos., Rathenaustr. 8</hap>
        <hap nr="hap10510113">Arbeitsstelle Holocaustliteratur, Phil. I D, 4. OG</hap>
        <hap nr="hap10510170">Prof. Voeste, Inst. f. Germanistik, Phil. I, Haus B</hap>
        <hap nr="hap10510171">Prof. Hennig, Inst. f. Germanistik, Phil. I, Haus B, Raum 111</hap>
        <hap nr="hap10510172">Prof. Lobin, Angew. Sprachw. u. Computerlinguistik, Phil. I D</hap>
        <hap nr="hap10510173">Prof. Gloning, Germanist. Sprachwiss., Phil. I, Haus B</hap>
        <hap nr="hap10510272">Prof. Jacob, Inst. f. Germanistik, Arbeitsber. Literatur, Phil I, Haus B</hap>
        <hap nr="hap10510273">Prof. Simonis, Germanistik, Phil. I G, Zi. 29</hap>
        <hap nr="hap10510274">Prof. Wirth, Inst. f. Germanistik, Neuere dt. Lit., Phil. I, Haus B</hap>
        <hap nr="hap10510275">Prof. Dietl, Inst. f. Germanistik, Phil. I, Haus B, Zi. 135</hap>
        <hap nr="hap10510370">Prof. M&#xf6;bius, Inst. f. Germanistik, Literaturdid., Haus B, Zi.
            206</hap>
        <hap nr="hap10510371">Prof. Dube, Inst. f. Germanistik, Phil. I B</hap>
        <hap nr="hap10510372">Prof. Lehnen, Germanist. Sprach- u. Mediendidaktik, Phil. I B, 2.
            Stock</hap>
        <hap nr="hap10510375">Prof. Feilke, Prof. f. Did. der dt. Sprache und Literatur, Phil. I
            Haus B</hap>
        <hap nr="hap10510376">Prof. Gamper, Deutsch als Zweitsprache, Phil. I Haus D</hap>
        <hap nr="hap10520173">Prof. Olson, Anglophone Literatur-, Kultur- und Medienwiss., Phil. I
            B</hap>
        <hap nr="hap10520174">Prof. Rostek, Anglophone Literatur-, Kultur- und Medienwiss., Phil. I
            B</hap>
        <hap nr="hap10520176">Prof. Luo, Intercultural Communication and Business, Phil. I B</hap>
        <hap nr="hap10530170">Prof. Born, Inst. f. Roman. Phil., Phil. II G</hap>
        <hap nr="hap10530171">Prof. Seiler, Inst. f. Roman. Phil., Phil. II, G</hap>
        <hap nr="hap10530174">Prof. Dolle, Inst. f. Roman. Philol. u. Lit., Phil II G</hap>
        <hap nr="hap10530175">Prof. Martinez, Inst. f. Roman. Philol. u. Lit., Phil II G</hap>
        <hap nr="hap10539999">Selbst-Lern-Werkstatt Romanistik, Phil. II G</hap>
        <hap nr="hap10540171">Prof. Wingender, Inst. f. Slavistik, Phil. II G, 1. OG</hap>
        <hap nr="hap10540172">Prof. Uffelmann, Inst. f. Slavistik, Phil. I, Haus D</hap>
        <hap nr="hap10540173">Prof. Daiber, Inst. f. Slavistik, Phil. I, Haus D, Zi. 517</hap>
        <hap nr="hap10550171">Prof. Siegmund, Inst. f. Angew. Theaterwiss., Phil. II A</hap>
        <hap nr="hap10610014">Prof. Billino, Neuropsych. d. Lebensspanne, Phil. I F</hap>
        <hap nr="hap10610015">Prof. Drewing, Allg. Psychol., Phil. I F</hap>
        <hap nr="hap10617040">Prof. Stark, Klin. Psychol./VT-Ambulanz, Phil.I F</hap>
        <hap nr="hap10617070">Prof. Gegenfurtner, Allg. Psychol., Phil. I F</hap>
        <hap nr="hap10617071">Prof. Knauff, Allg. Psychol., Phil I F</hap>
        <hap nr="hap10617073">Prof. Schuster, Psycholog. Methodenlehre,</hap>
        <hap nr="hap10617074">Prof. Klehe, Arbeits- u. Organisationspsychol., Phil. I F</hap>
        <hap nr="hap10617076">Prof. Sch&#xf6;ne, P&#xe4;d. Psychol., Phil. I F</hap>
        <hap nr="hap10617077">Prof. Brunstein, P&#xe4;d. Psychol., Phil. I F</hap>
        <hap nr="hap10617079">Prof. Kersting, Psycholog. Diagnostik, Phil. I F</hap>
        <hap nr="hap10617080">Prof. Hermann, Klin. Psychol., Phil. I F</hap>
        <hap nr="hap10617081">Prof. Hennig, Diff. Psychol., Phil. I F</hap>
        <hap nr="hap10617082">Prof. Schwarzer, Entwicklungspsychol., Phil I F</hap>
        <hap nr="hap10617083">Prof. H&#xe4;usser, Sozialpsychol., Phil. I D</hap>
        <hap nr="hap10617090">Prof. Fleming, Allg. Psychol., Phil. I F, 3. OG</hap>
        <hap nr="hap10617092">Prof. Wittmann, Biolog. Psychol., Phil. I, Haus F</hap>
        <hap nr="hap10617093">Prof. Fiehler, Allg. Psychol., Phil. I F, 3.OG</hap>
        <hap nr="hap10617095">Prof. Schwenck, Prof. klin. Kinder- u. Jugendpsychol., Phil. I
            C</hap>
        <hap nr="hap10617097">Prof. Eitel, P&#xe4;dagog. Psychol., Phil. I</hap>
        <hap nr="hap10617170">Prof. de Haas, Experiment. Psychologie, Phil. I F</hap>
        <hap nr="hap10620170">Prof. Oesterhelt, Inst. f. Sportwissenschaft, Kugelberg 62</hap>
        <hap nr="hap10620171">Prof. Munzert, Sportpsych. u. Bewegungswiss.</hap>
        <hap nr="hap10620172">Prof. M&#xfc;ller, Sportwiss., Kugelberg 62</hap>
        <hap nr="hap10620173">Prof. Kr&#xfc;ger, Leistungsphysiologie und Sporttherapie, Kugelberg
            62</hap>
        <hap nr="hap10620174">Professur f&#xfc;r Sportp&#xe4;d. u. Sportsoz., Kugelberg 62</hap>
        <hap nr="hap10620175">Prof. Hegele, Inst. f. Sportwiss., Kugelberg 62</hap>
        <hap nr="hap10629999">Dr. D&#xf6;hring, Inst. f. Sportwiss., Kugelberg 62</hap>
        <hap nr="hap10710270">Prof. Holzer, Inst. f. Informatik, Arndstr. 2</hap>
        <hap nr="hap10710172">Prof. Witzel, Math. Inst., Diskrete Mathematik und Geometrie,
            Arndtstr. 2</hap>
        <hap nr="hap10710173">Prof. Buhmann, Math. Inst., Numerik, Heinrich-Buff-Ring 44</hap>
        <hap nr="hap10710174">Prof. Ould-Ahmedou, Math. Inst., AG Analysis, Arndtstr. 2</hap>
        <hap nr="hap10710177">Prof. Metsch, Math. Inst., AG Diskr. Math., Arndstr. 2</hap>
        <hap nr="hap10710178">Prof. Meiners, Math. Inst., AG Stochastik, Arndstr. 2</hap>
        <hap nr="hap10710179">Prof. M&#xfc;hlherr, Math. Inst., AG Algebra, Arndtstr. 2</hap>
        <hap nr="hap10710181">Prof. Davydov, Math. Inst., Numerik, Heinrich-Buff-Ring 44</hap>
        <hap nr="hap10710182">Prof. Overbeck, Math. Inst., AG Finanzmathematik, Arndstr. 2</hap>
        <hap nr="hap10710199">Dr. Eichner, Math. Inst., AG Stochastik, Arndtstr. 2</hap>
        <hap nr="hap10710274">Prof. Kaiser, Inst. f. Informatik, Arndtstr. 2</hap>
        <hap nr="hap10710299">Prof. Kutrib, Inst. f. Informatik, Arndtstr. 2</hap>
        <hap nr="hap10710370">Prof. Schreiber, Didaktik d. Mathematik, Phil. II C</hap>
        <hap nr="hap10710372">Prof. Lengnink, Did. d. Mathematik, Phil. II C</hap>
        <hap nr="hap10719998">Lernzentrum Mathematik, Heinrich-Buff-Ring 16, R. P516</hap>
        <hap nr="hap10719999">Testothek Mathematik, Phil. II C</hap>
        <hap nr="hap10720170">Prof. Eickhoff, 1. Physikal. Inst., Heinrich-Buff-Ring 16</hap>
        <hap nr="hap10720171">Prof. Chatterjee, 1. Physikal. Inst., Heinrich-Buff-Ring 16, 2.
            OG</hap>
        <hap nr="hap10720172">Prof. Klar, 1. Physikal. Inst., Heinrich-Buff-Ring 16, 4. OG</hap>
        <hap nr="hap10720173">Prof. Heiliger, 1. Physikal. Inst., Heinrich-Buff-Ring 16, Zi.
            211</hap>
        <hap nr="hap10720174">Prof. Hannemann, 1. Physikal. Inst., Heinrich-Buff-Ring 16</hap>
        <hap nr="hap10720177">Prof. Thoma, 1. Physikal. Inst., Heinrich-Buff-Ring 16, Zi.
            309</hap>
        <hap nr="hap10720271">Prof. Brinkmann, 2. Physikal. Inst., Heinrich-Buff-Ring 16, 1.
            OG</hap>
        <hap nr="hap10720274">Prof. Scheidenberger, 2. Physikal. Inst., Heinrich-Buff-Ring
            14</hap>
        <hap nr="hap10720275">Prof. H&#xf6;hne, 2. Physikal. Inst., Heinrich-Buff-Ring 16</hap>
        <hap nr="hap10720370">Prof. Schlettwein, Angew. Physik, Heinrich-Buff-Ring 16, 1. OG</hap>
        <hap nr="hap10720371">Prof. Kohl, Angew. Physik, Heinrich-Buff-Ring 14</hap>
        <hap nr="hap10720372">Prof. Schirmeisen</hap>
        <hap nr="hap10720373">Prof. D&#xfc;rr, Inst. f. Angew. Physik, Heinrich-Buff-Ring 16</hap>
        <hap nr="hap10720471">Prof. Bunde, Theoret. Physik 3, Heinrich-Buff-Ring 16, 4. OG</hap>
        <hap nr="hap10720474">Prof. Fischer, Theoret. Physik, Heinrich-Buff-Ring 16, 4. OG</hap>
        <hap nr="hap10720477">Prof. von Smekal, Inst. f. Theoret. Physik, Heinrich-Buff-Ring
            16</hap>
        <hap nr="hap10720478">Prof. Sanna, Inst. f. Theoret. Physik, Heinrich-Buff-Ring 16</hap>
        <hap nr="hap10720570">Prof. von Aufschnaiter, Didaktik d. Physik, Phil. II C</hap>
        <hap nr="hap10729998">Physik Demonstrationspraktikum, Hoersaalgeb.,</hap>
        <hap nr="hap10729999">Physik Vorlesungsvorbereitung, Hoersaalgeb., Heinrich-Buff-Ring
            14</hap>
        <hap nr="hap10730170">Prof. Luterbacher, Inst. f&#xfc;r Geographie, Senckenbergstr.
            1</hap>
        <hap nr="hap10730171">Prof. Dittmann, Inst. f&#xfc;r Geographie, Senckenbergstr. 1</hap>
        <hap nr="hap10730172">Prof. Hennemann, Inst. f&#xfc;r Geographie, Senckenbergstr. 1</hap>
        <hap nr="hap10730173">Prof. Diller, Inst. f&#xfc;r Geographie, Schlossgasse 7</hap>
        <hap nr="hap10730174">Prof. Fuchs, Inst. f&#xfc;r Geographie, Senckenbergstr. 1</hap>
        <hap nr="hap10730175">Prof. Mehren, Did. Geographie, Phil. II, Haus G</hap>
        <hap nr="hap10730176">Prof. Schneider, Inst. f&#xfc;r Geographie, Senckenbergstr. 1</hap>
        <hap nr="hap10730270">Prof. Haversath, Did. Geographie, Phil. II, Haus G</hap>
        <hap nr="hap10730271">Prof. Werle, Did. d. Geographie, Phil. II G</hap>
        <hap nr="hap10739999">Dr. Volker, Geographie, Schlossgasse 7, Zi. 211</hap>
        <hap nr="hap10810170">Prof. Bindereif, Inst. f. Biochemie, Heinrich-Buff-Ring 58</hap>
        <hap nr="hap10810171">Prof. Str&#xe4;sser, Inst. f. Biochemie, Heinrich-Buff-Ring 17</hap>
        <hap nr="hap10810199">Prof. Friedhoff, Inst. f. Biochemie, Heinrich-Buff-Ring 58</hap>
        <hap nr="hap10810270">Prof. Ziemek, Inst. f. Biologiedid., Phil. II C, Raum 05A</hap>
        <hap nr="hap10810271">Prof. Kremer, Inst. f. Biologiedid., Phil. II C</hap>
        <hap nr="hap10810371">Prof. Wissemann, AG Spezielle Botanik, Heinrich-Buff-Ring 38</hap>
        <hap nr="hap10810370">Prof. Becker, Inst. f. Botanik, Heinrich-Buff-Ring 38</hap>
        <hap nr="hap10810470">Prof. M&#xfc;ller, Inst. f. Pflanzenoekol. , IFZ</hap>
        <hap nr="hap10810471">Dr. Lenhart, Inst. f. Pflanzenoekol., IFZ</hap>
        <hap nr="hap10810472">Prof. Kunze, Angew. Oekol., IFZ</hap>
        <hap nr="hap10810670">Prof. Thormann, Inst. f. Mikro- und Molekularbiologie, IFZ, Raum B
            243</hap>
        <hap nr="hap10810671">Prof. Klug, Inst. f. Mikrobiol. u. Molekularbiol., IFZ</hap>
        <hap nr="hap10810760">Prof. Werding, Tieroekologie, IFZ</hap>
        <hap nr="hap10810772">Prof. Prpic-Sch&#xe4;per, Allg. u. Spezielle Zool., Heinrich-Buff-Ring
            38</hap>
        <hap nr="hap10810780">Prof. Wolters, Tieroekologie, IFZ</hap>
        <hap nr="hap10810781">Prof. Wilke, Allg. und Spezielle Zool., IFZ</hap>
        <hap nr="hap10810782">Prof. Encarnacao, Allg. u. Spez. Zoologie, IFZ, Heinrich-Buff-Ring
            26-32</hap>
        <hap nr="hap10810784">Prof. Poppenborg Martin, Tieroekologie, IFZ, Heinrich-Buff-Ring
            26-32</hap>
        <hap nr="hap10810870">Prof. Manzini, Inst. f&#xfc;r Tierphysiologie, MZVG,
            Heinrich-Buff-Ring 38</hap>
        <hap nr="hap10810871">Prof. Lakes-Harlan, Standort</hap>
        <hap nr="hap10810970">Prof. Kr&#xfc;ger, Mol. Immunologie, Schubertstr. 81</hap>
        <hap nr="hap10811070">Dr. Zeidler, Pflanzenphysiologie, Senckenbergstr. 3, 3. OG</hap>
        <hap nr="hap10817071">Prof. Goesmann, Systembiologie, Heinrich-Buff-Ring 58, Zi. 03</hap>
        <hap nr="hap10817072">Prof. Janssen, Algorithm. Bioinformatik, Heinrich-Buff-Ring 58</hap>
        <hap nr="hap10820170">Prof. G&#xf6;ttlich, Inst. f. Organ. Chemie, Heinrich-Buff-Ring 17,
            Zi. B 227</hap>
        <hap nr="hap10820171">Prof. Maison, Inst. f. Organ. Chemie, Heinrich-Buff-Ring 58</hap>
        <hap nr="hap10820270">Prof. Schindler, Inst. f. Anorgan. u. Analyt. Chemie,
            Heinrich-Buff-Ring 17, Zi. B 121</hap>
        <hap nr="hap10820271">Prof. M&#xfc;ller-Buschbaum, Anorg. u. Analyt. Chemie,
            Heinrich-Buff-Ring 17, Zi. B 128</hap>
        <hap nr="hap10820272">Prof. Spengler, Inst. f. Anorgan. u. Analyt. Chemie,
            Heinrich-Buff-Ring 17, Zi. B 157</hap>
        <hap nr="hap10820371">Prof. Over, Physikal.-Chem. Inst., Heinrich-Buff-Ring 17, Zi. B
            41</hap>
        <hap nr="hap10820372">Prof. Smarsly, Phys.-Chem. Inst., Heinrich-Buff-Ring 17, Zi. B
            42</hap>
        <hap nr="hap10820373">Prof. Mollenhauer, Phys.-Chem. Inst., Heinrich-Buff-Ring 17</hap>
        <hap nr="hap10820470">Prof. Graulich, Didaktik d. Chemie, Heinrich-Buff-Ring 17, B
            13</hap>
        <hap nr="hap10820499">Handapp. Didaktik d. Chemie, Heinrich-Buff-Ring 17</hap>
        <hap nr="hap10820570">Prof. Zorn, Inst. f. Lebensmittelchemie, Heinrich-Buff-Ring 17, Zi. B
            246</hap>
        <hap nr="hap10820571">Prof. Hamscher, Inst. f. Lebensmittelchemie u. -biotechnologie,
            Heinrich-Buff-Ring 17, Zi. B 246</hap>
        <hap nr="hap10820572">Prof. R&#xfc;hl,</hap>
        <hap nr="hap10910170">Prof. Teuber, Agrarpol. u. Marktforschung, Zeughaus</hap>
        <hap nr="hap10910172">Prof. Nuppenau, Agrarpolitik u. Marktforschung, Zeughaus,
            Senckenbergstr. 3</hap>
        <hap nr="hap10910173">Prof. Petrick, Agrar-, Ern&#xe4;hrungs- und Umweltpolitik,
            Zeughaus</hap>
        <hap nr="hap10910301">Inst. f. Bodenkunde u. Bodenerhaltung, IFZ</hap>
        <hap nr="hap10910370">Prof. Siemens, Inst. f. Bodenkunde u. Bodenerhaltung, IFZ</hap>
        <hap nr="hap10910470">AG Prozesstechnik, Stephanstr. 24</hap>
        <hap nr="hap10910572">Prof. Herzig, Betriebslehre d. Agrar- u. Ernaehrungswirtsch.,
            Zeughaus, Senckenbergstr. 3</hap>
        <hap nr="hap10910573">Prof. Aurbacher, Prof. fuer Landwirtschaftl. Produktionsoekonomik,
            Zeughaus</hap>
        <hap nr="hap10910670">Prof. Kaempfer, Mikrobiol. d. Recyclingprozesse, IFZ</hap>
        <hap nr="hap10910671">Prof. Schnell, Allgem. u. Bodenmikrobiol., IFZ</hap>
        <hap nr="hap10910770">Prof. Breuer, Landschafts-, Wasser- und Stoffhaushalt, IFZ</hap>
        <hap nr="hap10910771">Prof. Gaeth, Abfall- u. Ressourcenmanagement, IFZ</hap>
        <hap nr="hap10910772">Prof. Kleinebecker, Landschaftsoekol. u. Landschaftsplanung</hap>
        <hap nr="hap10910775">Prof. Clifton-Brown, Nachw. Rohstoffe u. Bioressourcen, IFZ</hap>
        <hap nr="hap10910870">Prof. Snowdon, Pflanzenzuechtung, IFZ</hap>
        <hap nr="hap10910871">Prof. Frei, Pflanzenbau u. Ertragsphysiologie, IFZ</hap>
        <hap nr="hap10910971">Prof. Frisch, Biometrie u. Populationsgenetik, IFZ</hap>
        <hap nr="hap10911071">Prof. Vilcinskas, Angew. Entomologie, IFZ</hap>
        <hap nr="hap10911073">Prof. Sch&#xe4;fer, Inst. f. Phytopathologie, IFZ</hap>
        <hap nr="hap10911170">Prof. K&#xf6;nig, Tierzucht u. Haustiergenetik, Ludwigstr. 21b</hap>
        <hap nr="hap10911172">Prof. Koenig von Borstel, Tierzucht u. Haustiergenetik, Leihgesterner
            Weg 52</hap>
        <hap nr="hap10911174">Prof. L&#xfc;hken, Tierzucht u. Haustiergenetik, Ludwigstr. 21</hap>
        <hap nr="hap10911271">Prof. Sch&#xe4;berle, Inst. f. Insektenbiotechnologie, Ohlebergsweg
            12</hap>
        <hap nr="hap10911272">Prof. Schetelig, Inst. f. Insektenbiotechnologie, Winchesterstr.
            2</hap>
        <hap nr="hap10920170">Prof. Becker, Biochem. d. Ernaehrung d. Menschen, IFZ</hap>
        <hap nr="hap10920171">Prof. Morlock, Lebensmittelwiss., IFZ</hap>
        <hap nr="hap10920172">Prof. Eckert, Ernaehrungswiss., Wilhelmstr. 20</hap>
        <hap nr="hap10920173">Prof. Wagner, Inst. f. Ernaehrungswiss., Wilhelmstr. 20</hap>
        <hap nr="hap10920175">Prof. Fasshauer, Inst. f. Ern&#xe4;hrungswiss., Goethestr. 55</hap>
        <hap nr="hap10920178">AG Ern&#xe4;hrungsoekologie, Zeughaus, Senckenbergstr. 3</hap>
        <hap nr="hap10920179">Prof. Wenzel, Ern&#xe4;hrungswiss., Molekulare Ern.forschung,
            IFZ</hap>
        <hap nr="hap10920183">Prof. Gisch, Ern&#xe4;hrungspsychologie, Zeughaus, Senckenbergstr.
            3</hap>
        <hap nr="hap10920180">Prof. Eckert, Ernaehrungswiss., Wilhelmstr. 20</hap>
        <hap nr="hap10920270">Prof. B&#xf6;rnke, Inst. f. Pflanzenern&#xe4;hrung, IFZ</hap>
        <hap nr="hap10920271">Prof. Santner, Inst. f. Pflanzenern&#xe4;hrung, IFZ</hap>
        <hap nr="hap10920370">Prof. Eder, Inst. f. Tiernaehrung u. Ern&#xe4;hrungsphysiol.,
            IFZ</hap>
        <hap nr="hap10920470">Prof. Br&#xe4;unig, Wirtschaftsl. d. Haush., Senckenbergstr. 3</hap>
        <hap nr="hap10920472">Prof. Gwozdz, Versorgungs- und Verbrauchsforschung, Senckenbergstr.
            3</hap>
        <hap nr="hap10920474">Prof. Godemann, Kommunikation u. Beratung in Agrar- u.
            Ern&#xe4;hrungswiss., Senckenbergstr. 3</hap>
        <hap nr="hap10920475">Prof. Gwozdz, Versorgungs- und Verbrauchsforschung, Senckenbergstr.
            3</hap>
        <hap nr="hap10920476">Prof. Wahlen, Ern&#xe4;hrungssoziologie, Senckenbergstr. 3</hap>
        <hap nr="hap11017072">Prof. Kr&#xe4;mer, Tierschutz u. Ethologie, Frankfurter Str.
            110</hap>
        <hap nr="hap11010370">Prof. L&#xfc;tteke, Biochem. u. Endokrinol., Frankfurter Str.
            100</hap>
        <hap nr="hap11010371">Prof. Mazurek, Vet.-Physiologie u. - biochemie, Frankf. Str.
            100</hap>
        <hap nr="hap11010472">Prof. Olias, Vet.-Pathologie, Frankfurter Str. 96</hap>
        <hap nr="hap11010473">Prof. Herden, Vet.-Pathologie, Frankfurter Str. 96</hap>
        <hap nr="hap11010670">Prof. Weber, Inst. f. Virologie, BFS, Schubertstr. 81</hap>
        <hap nr="hap11010770">Prof. Ewers, Inst. f. Hygiene u. Infektionskrankh., Frankfurter Str.
            89</hap>
        <hap nr="hap11010870">Prof. Taubert, Inst. f. Parasitologie, BFS, Schubertstr. 81</hap>
        <hap nr="hap11010872">Prof. Falcone, Parasitologie,Zoonosen, BFS, Schubertstr. 81</hap>
        <hap nr="hap11010972">Prof. Geyer, Inst. f. Pharmakol. und Toxikol., BFS, Schubertstr.
            81</hap>
        <hap nr="hap11010970">Prof. Hamann, Inst. f. Pharmakol. und Toxikol., BFS, Schubertstr.
            81</hap>
        <hap nr="hap11010672">Prof. Lamp, Inst. f. Virologie, BFS, Schubertr. 81</hap>
        <hap nr="hap11011071">Prof. Kramer, Chirurg. Vet.-Klinik, Frankfurter Str. 108, Zi.
            137</hap>
        <hap nr="hap11011171">Prof. Fey, Klinik f. Pferde - Innere Med., Frankfurter Str.
            126</hap>
        <hap nr="hap11011270">Prof. Gr&#xfc;nberg, Klinik f. Wiederk&#xe4;uer, Frankfurter Str.
            104</hap>
        <hap nr="hap11011471">Prof. Wenisch, Inst. f. Vet.-Anatomie, -Histol. u. Embryologie,
            Frankfurter Str. 98</hap>
        <hap nr="hap11011473">Prof. Moritz, Kleintierklinik, Frankfurter Str. 114</hap>
        <hap nr="hap11011476">Prof. M. Schmidt, Kleintierklinik, Frankfurter Str. 108</hap>
        <hap nr="hap11011477">Prof. Pa&#xdf;lack, Kleintierklinik, Frankfurter Str. 114</hap>
        <hap nr="hap11011573">Prof. Burk, Pferdeorthop&#xe4;die, Frankfurter Str. 108, Zi.
            113</hap>
        <hap nr="hap11011771">Prof. Rummel, Vet.-Physiologie u. -Biochemie, Frankfurter Str.
            100</hap>
        <hap nr="hap11110370">Prof. Roelcke, Geschichte der Medizin, Leihgesterner Weg 52</hap>
        <hap nr="hap11110372">Prof. Knipper, Geschichte der Medizin, Leihgesterner Weg 52</hap>
        <hap nr="hap12500001">Dr. Hergenhan, ZMI, Ludwigstr. 34</hap>
        <hap nr="hap12510070">Ludwig-B&#xf6;rne-Professur, Prof. Leggewie, ZMI, Liebigstr.
            35</hap>
        <hap nr="hap12900001">ZfL Referat Studien- u. Pr&#xfc;fungsangelegenheiten, Rathenaustr.
            8</hap>
        <hap nr="hap30100501">Tierschutzbeauftragte/r, Frankfurter Str. 110</hap>
        <hap nr="hap60500805">Vertriebenenprojekt / Zeitgeschichte, Ludwigstr. 34, 1. Stock</hap>
        <hap nr="hap62000539">ZfbK, Studiencoaching, Karl-Gl&#xf6;ckner-Str. 5 A, Raum 122</hap>
        <hap nr="hap62202094">Panel on Planetary Thinking, Liebigstr. 35</hap>
        <hap nr="hap62202488">Projekt SoHaMi, Phil. II B</hap>
        <hap nr="hap62700561">Proj. NIDIT / ZfbK, Leihgesterner Weg 52</hap>
    </xsl:variable>

    <xsl:template name="selectlanguage">
        <xsl:param name="fields"/>
        <xsl:choose>
            <xsl:when test="$fields[@xml:lang = $language]">
                <xsl:value-of select="$fields[@xml:lang = $language]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$fields[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        <xsl:for-each
            select="holdings/holding[(holdingsTypeId = '996f93e2-5b5e-4cf2-9168-33ced1f95eed') and not(xs:boolean(discoverySuppress))]">
            <!-- für elektronische Bestände -->
            <!-- evtl. sortieren <xsl:sort select="..."/> -->
            <!-- EPN vorangestellt -->
            <!-- name() != effectiveLocation : Standortangaben ignorieren, um abt_name
                                               abt_num und abt_link zu unterdrücken -->
            <xsl:apply-templates select="./*[name() != 'effectiveLocation']|./*[name() != 'effectiveLocation']/*">
                <xsl:sort select="index-of(('hrid'),name())" order="descending"/>
            </xsl:apply-templates>
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_ind</xsl:with-param>
                <xsl:with-param name="value" select="'x online'"/>
            </xsl:call-template>
            <xsl:if test="notes[holdingsNoteTypeId = 'd1d99196-8904-4b2e-9125-9f7bbbf54cc1' and
                                note = '0']">
                <xsl:call-template name="DAIA">
                    <xsl:with-param name="tag">aus_status</xsl:with-param>
                    <xsl:with-param name="value" select="'frei'"/>
                </xsl:call-template>            
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each
            select="holdings/holding[(holdingsTypeId != '996f93e2-5b5e-4cf2-9168-33ced1f95eed') and not(xs:boolean(discoverySuppress))]">
            <!-- für nicht elektronische Bestände -->
            <xsl:sort select="effectiveLocation/discoveryDisplayName" order="ascending" lang="de"/>
            <xsl:sort select="callNumber" order="ascending" lang="de"/>
            <xsl:if test="not(items/item)">
                <xsl:apply-templates select="./hrid|./notes/note|./effectiveLocation/discoveryDisplayName">
                    <xsl:sort select="index-of(('hrid'),name())" order="descending"/>
                </xsl:apply-templates>
                <xsl:call-template name="DAIA">
                    <xsl:with-param name="tag">aus_ind</xsl:with-param>
                    <xsl:with-param name="value" select="'y unbekannt'"/>
                </xsl:call-template>
                <xsl:call-template name="DAIA">
                    <xsl:with-param name="tag">sig</xsl:with-param>
                    <xsl:with-param name="value" select="string-join((callNumberPrefix,callNumber),' ')"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:for-each select="items/item[not(xs:boolean(discoverySuppress))]">
                <xsl:sort select="(enumeration,chronology)[1]" order="ascending"/>
                <xsl:sort select="hrid" order="ascending"/>                
                <xsl:apply-templates select="./*|./*/*|../../notes/note">
                    <xsl:sort select="index-of(('discoveryDisplayName','status','effectiveCallNumberComponents','hrid'),name())" order="descending"/> 
                </xsl:apply-templates>
                <xsl:if test="not(chronology|enumeration)"> <!-- keine Angaben zum Einzelband -->
                    <xsl:apply-templates select="../../holdingsStatements/*"/>                 
                </xsl:if>
                <xsl:if test="status/name='Intellectual item'">
                    <xsl:for-each select="../../pieces/piece[not(xs:boolean(discoverySuppress)) and xs:boolean(displayOnHolding)]"> <!-- Hefteingänge -->
                        <xsl:sort select="caption"/>
                        <xsl:call-template name="DAIA">
                            <xsl:with-param name="tag">aus_text</xsl:with-param>
                            <xsl:with-param name="value" select="enumeration"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:if>
                <!-- Standortangabe als Code.
                     MF: anders als im Fall von Mainz aktuell noch in effectiveLocation/code 
                     und nicht in effectiveLocation/discoveryDisplayName
                -->
                <xsl:variable name="map"
                    select="$bbtabelle/e[c = current()/effectiveLocation/code]/map"/>
                <xsl:choose>
                    <xsl:when test="$map/@linktype = 'mapongo'">
                        <xsl:call-template name="mapongo"/>
                    </xsl:when>
                    <xsl:when test="$map/@linktype = 'bibmap'">
                        <xsl:call-template name="bibmap"/>
                    </xsl:when>
                    <xsl:when test="$map/@linktype = 'semapp'">
                        <xsl:call-template name="semapp"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="hrid">
        <!-- wird sowohl aus dem Holding als auch aus dem Item genutzt -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">epn</xsl:with-param>
            <xsl:with-param name="value" select="concat(ancestor::holding/hrid, '-', .)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="error">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">error</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="effectiveLocation/code">
        <!-- Standortangabe als Code -->
        <!-- Standortangabe als Code.
            MF: anders als im Fall von Mainz aktuell noch in effectiveLocation/code 
                und nicht in effectiveLocation/discoveryDisplayName
        -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_num</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_name</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$bbtabelle/e[c = current()]/n"/>
                </xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_link</xsl:with-param>
            <xsl:with-param name="value" select="($bbtabelle/e[c = current()]/url, $locationurl)[1]"
            />
        </xsl:call-template>
        
        <!-- Ergänzung eines aus_text für den Spezialfall do-Dummy-Aufnahmen -->
        <xsl:if test=". = 'ILN204/CG/Aufsatz/dodummy'">
            <xsl:variable name="dodummy-hint-text">
                <xsl:text>Titel nicht in diesem Katalog nachgewiesen, bitte suchen Sie im &lt;a href=&quot;</xsl:text>
                <xsl:text>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/LNG=DU/CHARSET=ISO-8859-1/PRS=HOL/CMD?ACT=SRCH&amp;IKT=12&amp;TRM=</xsl:text>
                <xsl:value-of select="ancestor::instanceData/instance/hrid"/>
                <xsl:text>&quot;&gt;Hessischen Verbundkatalog&lt;/a&gt;.</xsl:text>
            </xsl:variable>
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_text</xsl:with-param>
                <xsl:with-param name="value" select="$dodummy-hint-text"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="notes[holdingsNoteTypeId = '013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note">
        <!-- Standorthinweis (aus 8201) -->
        <!-- Falls 8201 mit hap beginnt und eine mehrstellige Zahl folgt,
             dann handelt es sich um einen Gießener Handapparat. -->
        <xsl:choose>
            <xsl:when test="matches(., 'hap\d+')">
                <xsl:call-template name="hap-giessen"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="DAIA">
                    <xsl:with-param name="tag">standort</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template
        match="notes[not(holdingsNoteTypeId = '013e0b2c-2259-4ee8-8d15-f463f1aeb0b1') and staffOnly = 'false']/note">

        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_text</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="holdingsStatements/statement">
        <!-- max. 3 holdingsstatements mit je max. 1 statement-->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">
                <xsl:text>zeit_bestand0</xsl:text>
                <xsl:number count="holdingsStatements"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <xsl:template match="holdingsStatements/note">
        <!-- max. 1 holdingsstatement mit max. 1 note -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">
                <xsl:text>aus_text</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="enumeration | chronology">
        <xsl:choose>
            <!-- Wenn Art des Inhalts = Zeitschrift -->
            <xsl:when test="ancestor::instanceData/instance/natureOfContentTermIds = '0abeee3d-8ad2-4b04-92ff-221b4fce1075'">
                <xsl:variable name="pos"><xsl:number count="enumeration|chronology"/></xsl:variable>
                <xsl:if test="$pos=1">
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag">zeit_bestand01</xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="DAIA">
                    <xsl:with-param name="tag">aus_text</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- TBD volume, displaySummary -->

    <xsl:template match="status[name(..) = 'item']">
        <!-- Trigger für Status (als immer eindeutig vorhanden vorausgesetzt) für Status und Ausleihindikator - emuliert LBS -->
        <!-- MF: Hier war für Gießen eine Änderung in der substring-Funktion notwendig, da 
                 der Ausleihindikator bei uns an der dritten Stelle steht,
                 also z.B. "0 u ausleihbar" -->
        <xsl:variable select="substring(
                               ($bbtabelle/e[c = current()/../effectiveLocation/code]/ind,
                                ../temporaryLoanType/name, ../permanentLoanType/name)[1],
                              3, 1)" name="ind"/>
        <!-- + temp loan type -->
        <xsl:variable name="result">
            <xsl:variable name="emulator">
                <status name="Aged to lost"/>
                <status name="Available">                            <b>UF</b><c>UF</c><d>UF</d><e>EM</e><i>IF</i><o>SX</o><s>SX</s><u>UF</u><y>YY</y></status><!-- b,c,d ist in Mainz ausleihbar -->
                <status name="Awaiting delivery"/> <!-- wird in Mainz nicht benutzt -->
                <status name="Awaiting pickup">                      <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><o>SX</o><s>CN</s><u>UV</u><y>YY</y></status>
                <status name="Checked out">                          <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><o>SX</o><s>CN</s><u>UV</u><y>YY</y></status>
                <status name="Claimed returned"/>
                <status name="Declared lost"/>
                <status name="In process">                           <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><o>SX</o><s>CN</s><u>UV</u><y>YY</y></status>
                <status name="In process - not requestable"/>
                <status name="Intellectual item">                    <b>UI</b><c>UI</c><d>UI</d><e>EM</e><i>II</i><o>SX</o><s>SX</s><u>UI</u><y>YY</y></status>
                <status name="In transit">                           <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><o>SX</o><s>CN</s><u>UV</u><y>YY</y></status>
                <status name="Long missing">                         <b>EM</b><c>EM</c><d>EM</d><e>EM</e><i>EM</i><o>SX</o><s>EM</s><u>EM</u><y>YY</y></status>
                <status name="Lost and paid"/>
                <status name="Missing">                              <b>EM</b><c>EM</c><d>EM</d><e>EM</e><i>EM</i><o>SX</o><s>EM</s><u>EM</u><y>YY</y></status>                
                <status name="On order">                    <a>XO</a><b>XO</b><c>XO</c><d>XO</d><e>XO</e><i>XO</i><o>SX</o><s>XO</s><u>XO</u><y>YY</y></status><!-- Indikator a für Gießen ergänzt -->
                <status name="Order closed"/> <!-- Status kann in Hebis und GBV nicht erreicht werden -->
                <status name="Paged">                                <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><o>SX</o><s>CN</s><u>UV</u><y>YY</y></status>
                <status name="Restricted"/>
                <status name="Unavailable"/>
                <status name="Unknown"/>
                <status name="Withdrawn"/>
            </xsl:variable>
            <xsl:variable name="campusubgiessen">
                <hinweis-ii campus="Magazin">
                    <h>https://paia.link</h>
                    <t1 xml:lang="de">&lt;a href='https://magazin.stock'&gt;Magazin&lt;/a&gt;</t1>
                </hinweis-ii>
                <hinweis-u campus="Magazin">
                    <h>https://paia.link</h>
                    <t1 xml:lang="de">&lt;a href='https://magazin.stock'&gt;Magazin&lt;/a&gt;</t1>
                </hinweis-u>
                <hinweis-ui campus="Magazin">
                    <h>https://paia.link</h>
                    <t1 xml:lang="de">&lt;a href='https://magazin.stock'&gt;Magazin&lt;/a&gt;</t1>
                </hinweis-ui>
                <hinweis-s campus="Fachbibliotheken">
                    <t2 xml:lang="de">Bitte erfragen Sie die Ausleihbedingungen vor Ort</t2>
                    <t2 xml:lang="en">Please inquire about the borrowing conditions on site</t2>
                </hinweis-s>
            </xsl:variable>
            <!-- Liste der zu unterscheidenden Fälle im Discovery-System
                 Code aus zwei Großbuchstaben: Zuordnungscode für diesen Fall
                 i : Ausleihindikator, der weitergereicht wird
                 s : Status, der weitergereicht wird
                 t1, t2, t3, t4 : Informationstext zu diesem Fall (Bei Fehlen des Sprachtextes wird der Text der ersten vorhandenen Sprache verwendet.)                 
                 h : Link, wie er hinter dem Bestellbutton hinterlegt werden soll -->
            <xsl:variable name="cases">
                <UF>
                    <i>u ausleihbar</i>
                    <s>verfuegbar</s>
                    <xsl:copy-of
                        select="$campusubgiessen/hinweis-u[@campus = $bbtabelle/e[c = current()/../effectiveLocation/code]/campus]/*"
                    />
                </UF>
                <!-- bestellbar -->
                <IF>
                    <i>i Lesesaal</i>
                    <s>unbekannt</s>
                    <t1 xml:lang="de">nur für den Lesesaal</t1>
                    <t1 xml:lang="en">reading room only</t1>
                    <xsl:copy-of
                        select="$campusubgiessen/hinweis-u[@campus = $bbtabelle/e[c = current()/../effectiveLocation/code]/campus]/*"
                    />
                </IF>
                <!-- nur für den Lesesaal bestellbar -->
                <SX>
                    <i>s Praesenzbestand</i>
                    <s>unbekannt</s>
                    <t1 xml:lang="de">vor Ort benutzbar</t1>
                    <t1 xml:lang="en">not available for loan</t1>
                    <xsl:copy-of
                        select="$campusubgiessen/hinweis-s[@campus = $bbtabelle/e[c = current()/../effectiveLocation/code]/campus]/*"
                    />
                </SX>
                <!-- Päsenzbestand -->
                <EM>
                    <i>e vermisst</i>
                    <s>vermisst</s>
                    <t1 xml:lang="de">vermisst</t1>
                    <t1 xml:lang="en">missing</t1>
                </EM>
                <!-- vermisst -->
                <UV>
                    <i>u ausleihbar</i>
                    <s>ausgeliehen</s>
                    <h>https://paia.link</h>
                    <d>
                        <xsl:value-of
                            select="xs:dateTime((current()/../status/date, current-dateTime())[1]) + xs:dayTimeDuration('P28D')"
                        />
                    </d>
                </UV>
                <!-- vormerkbar -->
                <IV>
                    <i>i Lesesaal</i>
                    <s>vormerkbar</s>
                    <h>https://paia.link</h>
                    <t1 xml:lang="de">nur für den Lesesaal</t1>
                    <t1 xml:lang="en">reading room only</t1>
                </IV>
                <!-- nur für den Lesesaal vormerkbar -->
                <CN>
                    <i>c</i>
                    <s>nicht vormerkbar</s>
                </CN>
                <!-- Präsenzbestand -->
                <XO>
                    <i>a bestellt</i>
                    <s>gesperrt</s>
                </XO>
                <!--  -->
                <UI>
                    <i>u ausleihbar</i>
                    <xsl:copy-of
                        select="$campusubgiessen/hinweis-ui[@campus = $bbtabelle/e[c = current()/../effectiveLocation/code]/campus]/*"
                    />
                </UI>
                <!-- Intellectual Item -->
                <II>
                    <i>i Lesesaal</i>
                    <t1 xml:lang="de">nur für den Lesesaal</t1>
                    <t1 xml:lang="en">reading room only</t1>
                    <xsl:copy-of
                        select="$campusubgiessen/hinweis-ii[@campus = $bbtabelle/e[c = current()/../effectiveLocation/code]/campus]/*"
                    />
                </II>
                <!-- Fallbehandlung Fachbibliotheken, ind = o -->
                <XX>
                    <i>g nicht_ausleihbar</i>
                    <s>unbekannt</s>
                </XX>
                <YY>
                    <i>y unbekannt</i>
                </YY>
                <!-- XX=Default: Nicht verfügbar -->
            </xsl:variable>
            <xsl:copy-of
                select="$cases/*[name() = ($emulator/status[@name = current()/name]/*[name() = $ind], 'XX')[1]]/*"
            />
        </xsl:variable>
        <xsl:if test="$result/s">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag"><xsl:text>aus_status</xsl:text></xsl:with-param>
                <xsl:with-param name="value" select="$result/s"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$result/i">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_ind</xsl:with-param>
                <xsl:with-param name="value" select="$result/i"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:for-each select="$result/t1[1] | $result/t2[1] | $result/t3[1] | $result/t4[1]">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_text</xsl:with-param>
                <xsl:with-param name="value">
                    <xsl:call-template name="selectlanguage">
                        <xsl:with-param name="fields" select="../*[name() = name(current())]"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:if test="$result/h">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_link</xsl:with-param>
                <xsl:with-param name="value" select="$result/h"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="($result/d) and (not(current()/../loan/dueDate))">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_datum</xsl:with-param>
                <xsl:with-param name="value"
                    select="format-dateTime($result/d, '[D01]-[M01]-[Y0001]')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="loan/dueDate">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_datum</xsl:with-param>
            <xsl:with-param name="value" select="format-dateTime(., '[D01]-[M01]-[Y0001]')"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="electronicAccess/uri">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">online_link</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="effectiveCallNumberComponents">
        <xsl:if test="not(callNumber='')">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">sig</xsl:with-param>
                <xsl:with-param name="value" select="string-join((prefix, callNumber), ' ')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="mapongo">
        <!-- item -->
        <xsl:variable name="locationtext">
            <!-- Mapongo-Link -->
            <t xml:lang="de">Standort in der Bibliothek anzeigen</t>
            <t xml:lang="en">Show location</t>
        </xsl:variable>
        <xsl:variable name="mapongopar">
            <xsl:text>s=</xsl:text>
            <xsl:value-of
                select="encode-for-uri(string-join((effectiveCallNumberComponents/prefix, effectiveCallNumberComponents/callNumber), ' '))"/>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:text>&lt;a target=&quot;_blank&quot; href=&quot;https://ub-giessen.mapongo.de/viewer?p=1&amp;</xsl:text>
                <xsl:value-of select="$mapongopar"/>
                <xsl:text>&quot;&gt;</xsl:text>
                <xsl:text>&lt;img style="vertical-align:center" name="inline_arrow" hspace="0" vspace="0" border="0" alt="</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>" src="https://opac.uni-giessen.de/static/img_psi/2.0/gui/bibmaplink.png"/&gt;&lt;b&gt;</xsl:text>                
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>&lt;/b&gt;&lt;/a&gt;</xsl:text>
                <!-- QR-Code -->
                <!-- <xsl:text>&lt;img width=&quot;130&quot; height=&quot;130&quot; src=&quot;https://ub-giessen.mapongo.de/static_images/projects/1/search_qrcode.png?</xsl:text>
                <xsl:value-of select="$mapongopar"/>
                <xsl:text>&quot;&gt;</xsl:text> -->
               </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="bibmap">
        <xsl:variable name="locationtext">
            <!-- Bibmap-Link -->
            <t xml:lang="de">Standort in der Bibliothek anzeigen</t>
            <t xml:lang="en">show location</t>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:text>&lt;a target="_blank" href="http://bibmap.ub.uni-giessen.de/bm/BIBMAP_Server?signatur=</xsl:text>
                <xsl:value-of select="encode-for-uri(effectiveCallNumberComponents/callNumber)"/>
                <xsl:text>"&gt;&lt;img style="vertical-align:center" name="inline_arrow" hspace="0" vspace="0" border="0" alt="</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>" src="https://opac.uni-giessen.de/static/img_psi/2.0/gui/bibmaplink.png"/&gt;&lt;b&gt;</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>&lt;/b&gt;&lt;/a&gt;</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="semapp">
        <xsl:variable name="locationtext">
            <!-- Mapongo-Link -->
            <t xml:lang="de">Standort in der Bibliothek anzeigen</t>
            <t xml:lang="en">show location</t>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:choose>
                    <xsl:when test="effectiveLocation/code = 'ILN204/CG/UB/UBSemapp'">
                        <xsl:text>&lt;a target="_blank" href="http://bibmap.ub.uni-giessen.de/bm/BIBMAP_Server?begriff=sem_app"&gt;</xsl:text>
                    </xsl:when>
                    <xsl:when test="effectiveLocation/code = 'ILN204/CG/ZP2/ZP2Semapp'">
                        <xsl:text>&lt;a target="_blank" href="http://bibmap.ub.uni-giessen.de/zp2/BIBMAP_Server?begriff=semester&amp;ln=de"&gt;</xsl:text>
                    </xsl:when>
                    <xsl:when test="effectiveLocation/code = 'ILN204/CG/ZHB/ZHBSemapp'">
                        <xsl:text>&lt;a target="_blank" href="https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/545"&gt;</xsl:text>
                    </xsl:when>
                    <xsl:when test="effectiveLocation/code = 'ILN204/CG/ZRW/ZRWSemapp'">
                        <xsl:text>&lt;a target="_blank" href="https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/444"&gt;</xsl:text>
                    </xsl:when>
                    <!-- Default: Standort-Website UB -->
                    <xsl:otherwise>
                        <xsl:text>&lt;a target="_blank" href="https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1"&gt;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&lt;img style="vertical-align:center" name="inline_arrow" hspace="0" vspace="0" border="0" alt="</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>" src="https://opac.uni-giessen.de/static/img_psi/2.0/gui/bibmaplink.png"/&gt;&lt;b&gt;</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>&lt;/b&gt;&lt;/a&gt;</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_text</xsl:with-param>
            <xsl:with-param name="value">Semesterapparat</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="hap-giessen">
        <!-- Gießener Handapparat-Informationen -->
        <xsl:variable name="locationtext">
            <!-- Mapongo-Link -->
            <t xml:lang="de">Standort</t>
            <t xml:lang="en">Location</t>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:text>&lt;b&gt;</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>:&lt;/b&gt; </xsl:text>
                <xsl:text>&lt;a target="_blank" href="https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/hap?hap=</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>"&gt;</xsl:text>
                <xsl:value-of select="$hap-tabelle/hap[@nr = current()/text()]"/>
                <xsl:text>&lt;/a&gt;</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*"/>

    <xsl:template name="DAIA">
        <!-- Template für alle DAIA-Tags, Default-Node für den Wert ist "." -->
        <xsl:param name="tag"/>
        <xsl:param name="value"/>
        <xsl:text>&#10;DAIAinfo </xsl:text>
        <xsl:value-of select="$tag"/>
        <xsl:text> </xsl:text>
        <xsl:choose>
            <xsl:when test="$value">
                <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> ofniAIAD</xsl:text>
    </xsl:template>


</xsl:stylesheet>
