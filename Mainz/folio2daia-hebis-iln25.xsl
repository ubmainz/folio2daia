<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    <!-- Sprache, default ist Deutsch -->
    <xsl:param name="language" select="(//lang,'de')[1]"/>
    <!-- Default Standort-URL -->
    <xsl:param name="locationurl" select="'https://www.ub.uni-mainz.de/de/standorte'"/>
    <!-- Tabelle "bbtabelle" mit allen Infomationen zu den Standorten:
         c : [pflicht] Standort-Code wie er in effectiveLocation/discoveryDisplayName übergeben wird, gleichzeitig Sortierkriterium
         n : [pflicht, wiederholbar] Name des Standorts wir er ausgegeben werden soll, ggf. sprachabhängig <n xml:lang="de">...</n><n xml:lang="en">...</n>
             (Bei Fehlen des Sprachtextes wird der Text der ersten Sprache verwendet.)
         ind : [optional] Ausleihindikator, überschreibt für diesen Standort den Wert, der aus FOLIO kommt
         url : [optional] URL für den Nutzer mit Infomationen für den Nutzer (z.B. Normdatensatz), default siehe oben
         map : [optional, wiederholbar] mit linktype="mapongo" oder linktype="bibmap", z.B. <map linktype="mapongo"/> 
                oder (ggf. linktype überschreibend) mit url="http...", z.B. <map url="https://ub-mainz.mapongo.de/viewer?p=1&amp;b=7&amp;f=20&amp;c=23620&amp;l=19809,19815,19816"/> 
         campus : [optional] Campus Germersheim ("cg") oder Campus Mainz ("cm" bzw. "cz") für campusübergreifende Ausleihe UB Mainz, "cz" auch für Unimedizin -->
    <xsl:variable name="bbtabelle">
        <e><c>25/000-000-10-ZBFREI</c><campus>cz</campus><n xml:lang="de">Zentralbibliothek, Bücherturm</n><n xml:lang="en">Central Library, Book Tower</n><map linktype="mapongo"/></e>  
        <e><c>25/000-000-12-ZBLBS</c><campus>cz</campus><n xml:lang="de">Zentralbibliothek, Lehrbuchsammlung</n><map linktype="mapongo"/></e>
        <e><c>25/000-000-14-ZBLS</c><campus>cz</campus><n xml:lang="de">Zentralbibliothek,Lesesaal</n><map linktype="mapongo"/></e>
        <e><c>25/000-000-16-ZBMAG</c><n xml:lang="de">Zentralbibliothek, Magazin</n></e>
        <e><c>25/000-000-18-ZBRARA</c><n xml:lang="de">Zentralbibliothek, Rara</n></e>
        <e><c>25/000-000-20-ZB-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">Zentralbibliothek, Semesterapparate</n><map url="https://ub-mainz.mapongo.de/viewer?p=1&amp;b=7&amp;f=20&amp;c=23620&amp;l=19809,19815,19816"/></e>
        <e><c>25/000-000-22-ZBZEB</c><n xml:lang="de">Zentralbibliothek, Zur Erwerbung bestellt</n></e>
        <e><c>25/002-002-10-GFGPÄD</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Erziehungswissenschaft</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-12-GFGFILM</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Filmwissenschaft</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-14-GFGJOUR</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Journalistik</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-16-GFGPOL</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Politikwissenschaft</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-18-GFGPSYCH</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Psychologie</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-20-GFGPUB</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Publizistik</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-22-GFGSOZ</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Soziologie</n><map linktype="mapongo"/></e>
        <e><c>25/002-002-24-GFG-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Georg Forster-Gebäude, Semesterapparate</n><map url=""/></e>
        <e><c>25/002-002-26-GFGZEB</c><n xml:lang="de">BB Georg Forster-Gebäude, Zur Erwerbung bestellt</n></e>
        <e><c>25/002-079-GFGKUN</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Kunstgeschichte</n><map linktype="mapongo"/></e>
        <e><c>25/002-110-GFGGEO</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Geographie und Geowissenschaften</n><map linktype="mapongo"/></e>
        <e><c>25/002-113-GFGSPO</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, Sportwissenschaften</n><map linktype="mapongo"/></e>
        <e><c>25/002-126-GFGUSA</c><campus>cm</campus><n xml:lang="de">BB Georg Forster-Gebäude, USA-Bibliothek</n><map linktype="mapongo"/></e>
        <e><c>25/004-004-PHRVK</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, RVK-Aufstellung</n><map linktype="mapongo"/></e>
        <e><c>25/004-004-PH-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Philosophicum, Semesterapparate</n><map url=""/></e>
        <e><c>25/004-058-PHPHI</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Philosophie</n><map linktype="mapongo"/></e>
        <e><c>25/004-070-PHGER</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Germanistik I / Kulturanthropologie und Germanistik II</n><map linktype="mapongo"/></e>
        <e><c>25/004-071-PHAVL</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Allgemeine und Vergleichende Literaturwissenschaft</n><map linktype="mapongo"/></e>
        <e><c>25/004-072-PHANG</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Anglistik/Amerikanistik</n><map linktype="mapongo"/></e>
        <e><c>25/004-073-PHAVS</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Allgemeine und Vergleichende Spachwissenschaft</n><map linktype="mapongo"/></e>
        <e><c>25/004-074-PHROM</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Romanistik</n><map linktype="mapongo"/></e>
        <e><c>25/004-075-PHSLAV</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Slavistik</n><map linktype="mapongo"/></e>
        <e><c>25/004-076-PHPOL</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Polonicum</n><map linktype="mapongo"/></e>
        <e><c>25/004-077-PHKLP</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Klassische Philologie</n><map linktype="mapongo"/></e>
        <e><c>25/004-078-PHKLA</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Klassische Archäologie</n><map linktype="mapongo"/></e>
        <e><c>25/004-083-PHKLW</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Historische Kulturwissenschaften</n><map linktype="mapongo"/></e>
        <e><c>25/004-086-PHALG</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Alte Geschichte</n><map linktype="mapongo"/></e>
        <e><c>25/004-087-PHBYZ</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Byzantinistik</n><map linktype="mapongo"/></e>
        <e><c>25/004-088-PHMNG</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Mittlere und neuere Geschichte</n><map linktype="mapongo"/></e>
            <e><c>25/004-090-PHBUW</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Buchwissenschaft</n><map linktype="mapongo"/></e>
            <e><c>25/004-092-PHOEG</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Osteuropäische Geschichte</n><map linktype="mapongo"/></e>
        <e><c>25/004-120-PHTHW</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Theaterwissenschaft / Medienkulturwissenschaft / Alltagsmedien</n><map linktype="mapongo"/></e>
        <e><c>25/004-127-PHMAG</c><n xml:lang="de">BB Philosophicum, Magazin</n></e>
        <e><c>25/005-005-10-UMFH</c><campus>cm</campus><n xml:lang="de">BB Universitätsmedizin, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/005-005-12-UMLBS</c><campus>cm</campus><n xml:lang="de">BB Universitätsmedizin, Lehrbuchsammlung</n><map linktype="mapongo"/></e>
        <e><c>25/005-005-14-UMLS</c><campus>cm</campus><n xml:lang="de">BB Universitätsmedizin, Lesesaal</n><map linktype="mapongo"/></e>
        <e><c>25/005-035-UMRMED</c><n xml:lang="de">BB Universitätsmedizin, Institut für Rechtsmedizin</n></e>
        <e><c>25/005-043-UMPSY</c><n xml:lang="de">BB Universitätsmedizin, Klinik für Psychiatrie und Psychotherapie</n></e>
        <e><c>25/005-054-UMZMK</c><campus>cm</campus><n xml:lang="de">BB Universitätsmedizin, Zahnklinik</n><map linktype="mapongo"/></e>
        <e><c>25/006-006-10-MINT</c><campus>cz</campus><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/006-006-12-MINTLBS</c><campus>cz</campus><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Lehrbuchsammlung</n><map linktype="mapongo"/></e>
        <e><c>25/006-006-14-MINTFAK</c><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Handapparate</n></e>
        <e><c>25/006-006-16-MINT-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Semesterapparate</n><map url=""/></e>
        <e><c>25/016-016-10-TH</c><campus>cm</campus><n xml:lang="de">BB Theologie, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/016-016-12-THLBS</c><campus>cm</campus><n xml:lang="de">BB Theologie, Lehrbuchsammlung</n><map linktype="mapongo"/></e>
        <e><c>25/016-016-14-THRARA</c><n xml:lang="de">BB Theologie, Magazin</n></e>
        <e><c>25/016-016-16-THPSYCH</c><n xml:lang="de">BB Theologie, Handapparat Psychologie</n></e>
        <e><c>25/016-016-18-THFAK</c><n xml:lang="de">BB Theologie, Handapparate Fachbereich</n></e>
        <e><c>25/018-018-10-RW</c><ind>s Praesenzbestand</ind><campus>cm</campus><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/018-018-12-RWLBS</c><campus>cm</campus><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Lernzentrum</n><map linktype="mapongo"/></e>
        <e><c>25/018-018-14-RWMAG</c><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Magazin</n></e>
        <e><c>25/018-018-16-RW-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Semesterapparate</n><map url=""/></e>
        <e><c>25/018-020-RWFAK</c><ind>s Praesenzbestand</ind><campus>cm</campus><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Lehrstühle</n></e>
        <e><c>25/019-019-10-GHFREI</c><campus>cg</campus><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/019-019-12-GHLBS</c><campus>cg</campus><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lehrbuchsammlung</n><map linktype="mapongo"/></e>
        <e><c>25/019-019-14-GHLS</c><campus>cg</campus><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lesesaal</n><map linktype="mapongo"/></e>
        <e><c>25/019-019-16-GHMAG</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Magazin</n></e>
        <e><c>25/019-019-18-GHSEP</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Separiert</n></e>
        <e><c>25/019-019-20-GHFAK</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Handapparate</n></e>
        <e><c>25/019-019-22-GHZEB</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Zur Erwerbung bestellt</n></e>
        <e><c>25/019-019-24-GH-SEMAPP</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Semesterapparate</n><map url="https://ub-mainz.mapongo.de/viewer?p=1&amp;b=7&amp;f=20&amp;c=23620&amp;l=19809,19815,19816"/></e>
        <e><c>25/066-066-10-RWETH</c><campus>cm</campus><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften / Ethnologie und Afrikastudien</n><map linktype="mapongo"/></e>
        <e><c>25/066-066-12-RWAMA</c><n xml:lang="de">Zentralbibliothek, AMA - African Music Archives</n></e>
        <e><c>25/080-080-RWTURK</c><campus>cm</campus><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften / Turkologie</n><map linktype="mapongo"/></e>
        <e><c>25/091-091-10-PHMUW</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Musikwissenschaft, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/091-091-12-PHMUWMAG</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Musikwissenschaft, Magazin</n></e>
        <e><c>25/112-112-10-PHHFMFREI</c><campus>cm</campus><n xml:lang="de">BB Philosophicum, Hochschule für Musik, Freihand</n><map linktype="mapongo"/></e>
        <e><c>25/112-112-12-PHHFMMAG</c><n xml:lang="de">BB Philosophicum, Hochschule für Musik, Magazin</n></e>
        <e><c>25/999-009-FBMPI</c><ind>s Praesenzbestand</ind><n xml:lang="de">Max-Planck-Institut für Polymerforschung, Bibliothek</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102599637</url></e>
        <e><c>25/999-034-FBGTEM</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Geschichte, Theorie und Ethik der Medizin</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102599866</url></e>
        <e><c>25/999-094-FBIGL</c><ind>s Praesenzbestand</ind><n xml:lang="de">Institut für Geschichtliche Landeskunde Rheinland-Pfalz e.V., Bibliothek</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=460818961</url></e>
        <e><c>25/999-069-FBPSY</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Psychologisches Institut</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=10260018X</url></e>
        <e><c>25/999-082-FBÄGYPT</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Altertumswissenschaften - Ägyptologie und Altorientalistik</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102600317</url></e>
        <e><c>25/999-085-FBAVFGA</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Altertumswissenschaften - Vor- und Frühgeschichtliche Archäologie</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102600341</url></e>
        <e><c>25/999-111-FBKUNST</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Kunsthochschule</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102600600</url></e>
        <e><c>25/999-124-FBGESANG</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Gesangbucharchiv</n></e>
    </xsl:variable>

    <xsl:template name="selectlanguage">
        <xsl:param name="fields"/>
        <xsl:choose>
            <xsl:when test="$fields[@xml:lang=$language]"><xsl:value-of select="$fields[@xml:lang=$language]"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$fields[1]"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        <xsl:for-each select="holdings/holding[(holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed') and not(xs:boolean(discoverySuppress))]"> <!-- für elektronische Bestände -->
            <!-- evtl. sortieren <xsl:sort select="..."/> -->
            <xsl:apply-templates select="./*|./*/*">
                <xsl:sort select="index-of(('hrid'),name())" order="descending"/>
            </xsl:apply-templates>
            <!-- Unterscheidung nötig für E-Ressourcen in Bestellung --> 
            <xsl:choose>
                <xsl:when test="items/item"> <!-- TBD: wird gelöscht, wenn nicht mehr "bestellt"? -->
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag">aus_ind</xsl:with-param>
                        <xsl:with-param name="value" select="'a bestellt'"/>
                    </xsl:call-template>
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag">aus_status</xsl:with-param>
                        <xsl:with-param name="value" select="'gesperrt'"/>
                    </xsl:call-template> 
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag">aus_ind</xsl:with-param>
                        <xsl:with-param name="value" select="'x online'"/>
                    </xsl:call-template>
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag">aus_status</xsl:with-param>
                        <xsl:with-param name="value" select="'frei'"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:for-each select="holdings/holding[(holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed') and not(xs:boolean(discoverySuppress))]"> <!-- für nicht elektronische Bestände -->
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
                    <xsl:if test="../../pieces/piece[not(xs:boolean(discoverySuppress)) and xs:boolean(displayOnHolding)]"> <!-- mindestens ein Heft -->
                        <xsl:call-template name="DAIA">
                            <xsl:with-param name="tag">aus_text</xsl:with-param>
                            <xsl:with-param name="value">Aktuelle Hefte:</xsl:with-param>
                        </xsl:call-template> 
                    </xsl:if>
                    <xsl:for-each select="../../pieces/piece[not(xs:boolean(discoverySuppress)) and xs:boolean(displayOnHolding)]"> <!-- Hefteingänge --> <!-- TBD die letzen drei -->
                        <xsl:sort select="caption"/>
                        <xsl:call-template name="DAIA">
                            <xsl:with-param name="tag">aus_text</xsl:with-param>
                            <xsl:with-param name="value" select="enumeration"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:if>
                <xsl:variable name="map" select="$bbtabelle/e[c=current()/effectiveLocation/discoveryDisplayName]/map"/>
                <xsl:choose>
                    <xsl:when test="$map/@url"><xsl:call-template name="mapurl"><xsl:with-param name="url" select="$map/@url"></xsl:with-param></xsl:call-template></xsl:when>
                    <xsl:when test="$map/@linktype='mapongo'"><xsl:call-template name="mapongo"/></xsl:when>
                    <xsl:when test="$map/@linktype='bibmap'"><xsl:call-template name="bibmap"/></xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
        
    <xsl:template match="hrid"> <!-- wird sowohl aus dem Holding als auch aus dem Item genutzt -->
         <xsl:call-template name="DAIA">
             <xsl:with-param name="tag">epn</xsl:with-param>
             <xsl:with-param name="value" select="concat(ancestor::holding/hrid,'-',.)"/>
         </xsl:call-template>
    </xsl:template>

    <xsl:template match="error">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">error</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="effectiveLocation/discoveryDisplayName"> <!-- Standortangabe als Code -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_num</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_name</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:call-template name="selectlanguage"><xsl:with-param name="fields" select="$bbtabelle/e[c=current()]/n"/></xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_link</xsl:with-param>
            <xsl:with-param name="value" select="($bbtabelle/e[c=current()]/url,$locationurl)[1]"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="notes[holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note"> <!-- Standorthinweis (aus 8201) -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="notes[not(holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1') and staffOnly='false']/note">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_text</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
 
    <xsl:template match="holdingsStatements/statement"> <!-- max. 3 holdingsstatements mit je max. 1 statement-->
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag"><xsl:text>zeit_bestand0</xsl:text><xsl:number count="holdingsStatements"/></xsl:with-param>
            </xsl:call-template>
    </xsl:template>

        
    <xsl:template match="holdingsStatements/note"> <!-- max. 1 holdingsstatement mit max. 1 note -->   
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag"><xsl:text>aus_text</xsl:text></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="enumeration|chronology">
        <xsl:variable name="pos"><xsl:number count="enumeration|chronology"/></xsl:variable>
        <xsl:if test="$pos=1">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">zeit_bestand01</xsl:with-param>
            </xsl:call-template>
        </xsl:if>       
    </xsl:template>

    <!-- TBD volume, displaySummary -->

    <xsl:template match="status[name(..)='item']"> <!-- Trigger für Status (als immer eindeutig vorhanden vorausgesetzt) für Status und Ausleihindikator - emuliert LBS -->
        <xsl:variable select="substring(($bbtabelle/e[c=current()/../effectiveLocation/discoveryDisplayName]/ind,../permanentLoanType/name)[1],1,1)" name="ind"/> <!-- + temp loan type ? -->
        <xsl:variable name="result">
            <xsl:variable name="emulator">
                <status name='Aged to lost'/>
                <status name='Available'>                    <b>UF</b><c>UF</c><d>UF</d><e>EM</e><i>IF</i><s>SX</s><u>UF</u> </status> <!-- b,c,d ist in Mainz ausleihbar -->
                <status name='Awaiting delivery'/> <!-- wird in Mainz nicht benutzt -->
                <status name='Awaiting pickup'>              <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Checked out'>                  <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Claimed returned'/> 
                <status name='Declared lost'/>   
                <status name='In process'>                   <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='In process - not requestable'/>
                <status name='Intellectual item'>            <b>UI</b><c>UI</c><d>UI</d><e>EM</e><i>II</i><s>SX</s><u>UI</u> </status>
                <status name='In transit'>                   <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Long missing'>                 <b>EM</b><c>EM</c><d>EM</d><e>EM</e><i>EM</i><s>EM</s><u>EM</u> </status>
                <status name='Lost and paid'/>    
                <status name='Missing'>                      <b>EM</b><c>EM</c><d>EM</d><e>EM</e><i>EM</i><s>EM</s><u>EM</u> </status>
                <status name='On order'>                     <b>XO</b><c>XO</c><d>XO</d><e>XO</e><i>XO</i><s>XO</s><u>XO</u> </status>
                <status name='Order closed'/> <!-- Status kann in Hebis und GBV nicht erreicht werden -->                  
                <status name='Paged'>                        <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Restricted'/>
                <status name='Unavailable'/>
                <status name='Unknown'/>
                <status name='Withdrawn'/>
            </xsl:variable>
            <xsl:variable name="campusubmainz">
                <hinweis-u campus="cg"><t2 xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Germersheim: ohne Bestellung am Reschal holen&lt;/font&gt;&lt;/b&gt;</t2><t3 xml:lang="de">Mainz: bestellen</t3></hinweis-u> <!-- Z.B. Englisch: <t xml:lang="en">Germersheim: ...</t> -->
                <hinweis-u campus="cm"><t2 xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Mainz: ohne Bestellung am Regal holen&lt;/font&gt;&lt;/b&gt;</t2><t3 xml:lang="de">Germersheim: bestellen</t3></hinweis-u>
                <hinweis-u campus="cz"><t2 xml:lang="de">Germersheim: bestellen</t2><t3 xml:lang="de">Universitätsmedizin: bestellen</t3><t4 xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Alle anderen: selbst am Regal holen&lt;/font&gt;&lt;/b&gt;</t4></hinweis-u>
                <hinweis-s campus="cg"><t2 xml:lang="de">Aufsatzkopien/Kurzausleihe für Campus Mainz möglich, bitte wenden Sie sich an die Information</t2></hinweis-s>
                <hinweis-s campus="cm"><t2 xml:lang="de">Aufsatzkopien/Kurzausleihe für Campus Germersheim möglich, bitte wenden Sie sich an die Information</t2></hinweis-s>
                <hinweis-s campus="cz"><t2 xml:lang="de">Aufsatzkopien/Kurzausleihe für Campus Germersheim möglich, bitte wenden Sie sich an die Information</t2></hinweis-s>
            </xsl:variable>
            <!-- Liste der zu unterscheidenden Fälle im Discovery-System
                 Code aus zwei Großbuchstaben: Zuordnungscode für diesen Fall
                 i : Ausleihindikator, der weitergereicht wird
                 s : Status, der weitergereicht wird
                 t1, t2, t3, t4 : Informationstext zu diesem Fall (Bei Fehlen des Sprachtextes wird der Text der ersten vorhandenen Sprache verwendet.)                 
                 h : Link, wie er hinter dem Bestellbutton hinterlegt werden soll -->
            <xsl:variable name="cases">
                <UF><i>u ausleihbar</i><s>verfuegbar</s><xsl:copy-of select="$campusubmainz/hinweis-u[@campus=$bbtabelle/e[c=current()/../effectiveLocation/discoveryDisplayName]/campus]/*"/><h>https://paia.link</h></UF> <!-- bestellbar -->
                <IF><i>i Lesesaal</i><s>verfuegbar</s><h>https://paia.link</h><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1></IF> <!-- nur für den Lesesaal bestellbar -->
                <SX><i>s Praesenzbestand</i><t1 xml:lang="de">nicht ausleihbar</t1><t1 xml:lang="en">not available for loan</t1>
                    <xsl:copy-of select="$campusubmainz/hinweis-s[@campus=$bbtabelle/e[c=current()/../effectiveLocation/discoveryDisplayName]/campus]/*"/></SX> <!-- Päsenzbestand -->
                <EM><i>e vermisst</i><t1 xml:lang="de">vermisst</t1><t1 xml:lang="en">missing</t1><t2 xml:lang="de">nicht ausleihbar</t2><t2 xml:lang="en">not available for loan</t2></EM> <!-- vermisst -->
                <UV><i>u ausleihbar</i><s>vormerkbar</s><h>https://paia.link</h><d><xsl:value-of select="xs:dateTime((current()/../status/date,current-dateTime())[1])+xs:dayTimeDuration('P28D')"/></d></UV> <!-- vormerkbar -->
                <IV><i>i Lesesaal</i><s>vormerkbar</s><h>https://paia.link</h><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1></IV> <!-- nur für den Lesesaal vormerkbar -->
                <CN><i>c Lehrbuchsammlung</i><s>nicht vormerkbar</s></CN> <!-- Präsenzbestand -->
                <XO><i>a</i><s>gesperrt</s></XO> <!--  -->
                <UI><i>u ausleihbar</i><xsl:copy-of select="$campusubmainz/hinweis-u[@campus=$bbtabelle/e[c=current()/../effectiveLocation/discoveryDisplayName]/campus]/*"/>
                    <h>https://libserv.ub.uni-mainz.de/request?hrid=<xsl:value-of select="../hrid"/></h></UI> <!-- Intellectual Item, lokaler link nur zum Testen -->
                <II><i>i Lesesaal</i><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1><h>http://localhost:5000/?hrid=<xsl:value-of select="../hrid"/></h></II>
                <XX><i>g nicht_ausleihbar</i></XX> <!-- XX=Default: Nicht verfügbar -->
            </xsl:variable>
            <xsl:copy-of select="$cases/*[name()=($emulator/status[@name=current()/name]/*[name()=$ind],'XX')[1]]/*"/>
        </xsl:variable>
        <xsl:if test="$result/s">
            <xsl:choose>
                <xsl:when test="../copyNumber">  <!-- d.h. Mehrfachexemplar -->
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag"><xsl:text>aus_status</xsl:text></xsl:with-param>
                        <xsl:with-param name="value" select="'bandliste'"/>
                    </xsl:call-template>
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag"><xsl:text>aus_bandstatus</xsl:text></xsl:with-param>
                        <xsl:with-param name="value" select="$result/s"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="DAIA">
                        <xsl:with-param name="tag"><xsl:text>aus_status</xsl:text></xsl:with-param>
                        <xsl:with-param name="value" select="$result/s"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="$result/i">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_ind</xsl:with-param>
                <xsl:with-param name="value" select="$result/i"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:for-each select="$result/t1[1]|$result/t2[1]|$result/t3[1]|$result/t4[1]">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_text</xsl:with-param>
                <xsl:with-param name="value">
                    <xsl:call-template name="selectlanguage"><xsl:with-param name="fields" select="../*[name()=name(current())]"/></xsl:call-template>
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
               <xsl:with-param name="value" select="format-dateTime($result/d,'[D01]-[M01]-[Y0001]')"/>
           </xsl:call-template>  
        </xsl:if>
    </xsl:template>

    <xsl:template match="loan/dueDate">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_datum</xsl:with-param>
            <xsl:with-param name="value" select="format-dateTime(.,'[D01]-[M01]-[Y0001]')"/>
        </xsl:call-template>        
    </xsl:template>

    <xsl:template match="electronicAccess/uri">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">online_link</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
     <xsl:template match="effectiveCallNumberComponents">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">sig</xsl:with-param>
            <xsl:with-param name="value" select="string-join((prefix,callNumber),' ')"/>
        </xsl:call-template>
    </xsl:template>
 
    <xsl:template name="mapongo"> <!-- item -->
        <xsl:variable name="locationtext"> <!-- Mapongo-Link -->
            <t xml:lang="de">Standort zeigen</t>
            <t xml:lang="en">show location</t>
        </xsl:variable>
        <xsl:variable name="mapongopar">
            <xsl:text>https://ub-mainz.mapongo.de/viewer?p=1&amp;s=</xsl:text>
            <xsl:value-of select="encode-for-uri(string-join((effectiveCallNumberComponents/prefix,effectiveCallNumberComponents/callNumber),' '))"/>
            <xsl:if test="../../notes[holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note">
                <xsl:text>&amp;c1=</xsl:text> <!-- c1: "8201" -->
                <xsl:value-of select="encode-for-uri(../../notes[holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note)"/>
            </xsl:if>
            <xsl:text>&amp;c2=</xsl:text> <!-- c2:location -->
            <xsl:value-of select="encode-for-uri(effectiveLocation/discoveryDisplayName)"/>
        </xsl:variable>
        <xsl:call-template name="mapurl"><xsl:with-param name="url" select="$mapongopar"></xsl:with-param></xsl:call-template>
        <!-- QR-Code
                <xsl:text>&lt;img width=&quot;130&quot; height=&quot;130&quot; src=&quot;https://ub-mainz.mapongo.de/static_images/projects/1/search_qrcode.png?</xsl:text>
                <xsl:value-of select="$mapongopar"/>
                <xsl:text>&quot;&gt;</xsl:text> -->
    </xsl:template>
    
    <xsl:template name="mapurl"> <!-- item -->
        <xsl:param name="url"/>
        <xsl:variable name="locationtext"> <!-- Standort-Link -->
            <t xml:lang="de">Standort zeigen</t>
            <t xml:lang="en">show location</t>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:text>&lt;a target=&quot;_blank&quot; href=&quot;</xsl:text>
                <xsl:value-of select="$url"/>
                <xsl:text>&quot;&gt;</xsl:text>
                <xsl:call-template name="selectlanguage">
                    <xsl:with-param name="fields" select="$locationtext/t"/>
                </xsl:call-template>
                <xsl:text>&lt;/a&gt;</xsl:text>
            </xsl:with-param>
        </xsl:call-template>   
    </xsl:template>
 
    <xsl:template name="bibmap"> <!-- item -->
    <!-- TBD -->    
    </xsl:template>
 
    <xsl:template match="*"/>

    <xsl:template name="DAIA"> <!-- Template für alle DAIA-Tags, Default-Node für den Wert ist "." -->
        <xsl:param name="tag"/>
        <xsl:param name="value"/>
        <xsl:text>&#10;DAIAinfo </xsl:text>
        <xsl:value-of select="$tag"/>
        <xsl:text> </xsl:text>
        <xsl:choose>
            <xsl:when test="$value"><xsl:value-of select="$value"/></xsl:when>
            <xsl:otherwise> <xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose>
        <xsl:text> ofniAIAD</xsl:text>
    </xsl:template>
</xsl:stylesheet>
