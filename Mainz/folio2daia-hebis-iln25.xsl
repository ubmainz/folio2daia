<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    <!-- Sprache, default ist Deutsch -->
    <xsl:param name="lang" select="(//lang,'de')[1]"/>
    <!-- Default Standort-URL -->
    <xsl:param name="locationurl" select="'https://www.ub.uni-mainz.de/de/standorte'"/>
    <!-- Tabelle "bbtabelle" mit allen Infomationen zu den Standorten:
         c : [pflicht] Standort-Code wie er in effectiveLocation/discoveryDisplayName übergeben wird, gleichzeitig Sortierkriterium
         n : [pflicht] Name des Standorts wir er ausgegeben werden soll, ggf. sprachabhängig <n xml:lang="de">...</n><n xml:lang="en">...</n>
         ind : [optional] Ausleihindikator, überschreibt für diesen Standort den Wert, der aus FOLIO kommt
         url : [optional] URL für den Nutzer mit Infomationen für den Nutzer (z.B. Normdatensatz), default siehe oben
         campus : [optional] Campus Germersheim ("cg") oder Campus Mainz ("cm") für campusübergreifende Ausleihe UB Mainz -->
    <xsl:variable name="bbtabelle">
        <e><c>25/000-000-10-ZBFREI</c><n xml:lang="de">Zentralbibliothek, Bücherturm</n><n xml:lang="en">Central Library, Book Tower</n></e>  
        <e><c>25/000-000-12-ZBLBS</c><n xml:lang="de">Zentralbibliothek, Lehrbuchsammlung</n></e>
        <e><c>25/000-000-14-ZBLS</c><n xml:lang="de">Zentralbibliothek,Lesesaal</n></e>
        <e><c>25/000-000-16-ZBMAG</c><n xml:lang="de">Zentralbibliothek, Magazin</n></e>
        <e><c>25/000-000-18-ZBRARA</c><n xml:lang="de">Zentralbibliothek, Rara</n></e>
        <e><c>25/000-000-20-ZBSEM</c><ind>s Praesenzbestand</ind><n xml:lang="de">Zentralbibliothek, Semesterapparate</n></e>
        <e><c>25/000-000-22-ZBZEB</c><n xml:lang="de">Zentralbibliothek, Zur Erwerbung bestellt</n></e>
        <e><c>25/002-002-10-GFGPÄD</c><n xml:lang="de">BB Georg Forster-Gebäude, Erziehungswissenschaft</n></e>
        <e><c>25/002-002-12-GFGFILM</c><n xml:lang="de">BB Georg Forster-Gebäude, Filmwissenschaft</n></e>
        <e><c>25/002-002-14-GFGJOUR</c><n xml:lang="de">BB Georg Forster-Gebäude, Journalistik</n></e>
        <e><c>25/002-002-16-GFGPOL</c><n xml:lang="de">BB Georg Forster-Gebäude, Politikwissenschaft</n></e>
        <e><c>25/002-002-18-GFGPSYCH</c><n xml:lang="de">BB Georg Forster-Gebäude, Psychologie</n></e>
        <e><c>25/002-002-20-GFGPUB</c><n xml:lang="de">BB Georg Forster-Gebäude, Publizistik</n></e>
        <e><c>25/002-002-22-GFGSOZ</c><n xml:lang="de">BB Georg Forster-Gebäude, Soziologie</n></e>
        <e><c>25/002-002-24-GFGSEM</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Georg Forster-Gebäude, Semesterapparate</n></e>
        <e><c>25/002-002-26-GFGZEB</c><n xml:lang="de">BB Georg Forster-Gebäude, Zur Erwerbung bestellt</n></e>
        <e><c>25/002-079-GFGKUN</c><n xml:lang="de">BB Georg Forster-Gebäude, Kunstgeschichte</n></e>
        <e><c>25/002-110-GFGGEO</c><n xml:lang="de">BB Georg Forster-Gebäude, Geographie und Geowissenschaften</n></e>
        <e><c>25/002-113-GFGSPO</c><n xml:lang="de">BB Georg Forster-Gebäude, Sportwissenschaften</n></e>
        <e><c>25/002-126-GFGUSA</c><n xml:lang="de">BB Georg Forster-Gebäude, USA-Bibliothek</n></e>
        <e><c>25/004-004-PHRVK</c><n xml:lang="de">BB Philosophicum, RVK-Aufstellung</n></e>
        <e><c>25/004-058-PHPHI</c><n xml:lang="de">BB Philosophicum, Philosophie</n></e>
        <e><c>25/004-070-PHGER</c><n xml:lang="de">BB Philosophicum, Germanistik I / Kulturanthropologie und Germanistik II</n></e>
        <e><c>25/004-071-PHAVL</c><n xml:lang="de">BB Philosophicum, Allgemeine und Vergleichende Literaturwissenschaft</n></e>
        <e><c>25/004-072-PHANG</c><n xml:lang="de">BB Philosophicum, Anglistik/Amerikanistik</n></e>
        <e><c>25/004-073-PHAVS</c><n xml:lang="de">BB Philosophicum, Allgemeine und Vergleichende Spachwissenschaft</n></e>
        <e><c>25/004-074-PHROM</c><n xml:lang="de">BB Philosophicum, Romanistik</n></e>
        <e><c>25/004-075-PHSLAV</c><n xml:lang="de">BB Philosophicum, Slavistik</n></e>
        <e><c>25/004-076-PHPOL</c><n xml:lang="de">BB Philosophicum, Polonicum</n></e>
        <e><c>25/004-077-PHKLP</c><n xml:lang="de">BB Philosophicum, Klassische Philologie</n></e>
        <e><c>25/004-078-PHKLA</c><n xml:lang="de">BB Philosophicum, Klassische Archäologie</n></e>
        <e><c>25/004-083-PHKLW</c><n xml:lang="de">BB Philosophicum, Historische Kulturwissenschaften</n></e>
        <e><c>25/004-086-PHALG</c><n xml:lang="de">BB Philosophicum, Alte Geschichte</n></e>
        <e><c>25/004-087-PHBYZ</c><n xml:lang="de">BB Philosophicum, Byzantinistik</n></e>
        <e><c>25/004-088-PHMNG</c><n xml:lang="de">BB Philosophicum, Mittlere und neuere Geschichte</n></e>
        <e><c>25/004-090-PHBUW</c><n xml:lang="de">BB Philosophicum, Buchwissenschaft</n></e>
        <e><c>25/004-092-PHOEG</c><n xml:lang="de">BB Philosophicum, Osteuropäische Geschichte</n></e>
        <e><c>25/004-120-PHTHW</c><n xml:lang="de">BB Philosophicum, Theaterwissenschaft / Medienkulturwissenschaft / Alltagsmedien</n></e>
        <e><c>25/004-127-PHMAG</c><n xml:lang="de">BB Philosophicum, Magazin</n></e>
        <e><c>25/005-005-10-UMFH</c><n xml:lang="de">BB Universitätsmedizin, Freihand</n></e>
        <e><c>25/005-005-12-UMLBS</c><n xml:lang="de">BB Universitätsmedizin, Lehrbuchsammlung</n></e>
        <e><c>25/005-005-14-UMLS</c><n xml:lang="de">BB Universitätsmedizin, Lesesaal</n></e>
        <e><c>25/005-035-UMRMED</c><n xml:lang="de">BB Universitätsmedizin, Institut für Rechtsmedizin</n></e>
        <e><c>25/005-043-UMPSY</c><n xml:lang="de">BB Universitätsmedizin, Klinik für Psychiatrie und Psychotherapie</n></e>
        <e><c>25/005-054-UMZMK</c><n xml:lang="de">BB Universitätsmedizin, Zahnklinik</n></e>
        <e><c>25/006-006-10-MINT</c><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Freihand</n></e>
        <e><c>25/006-006-12-MINTLBS</c><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Lehrbuchsammlung</n></e>
        <e><c>25/006-006-14-MINTFAK</c><n xml:lang="de">BB Mathematik, Informatik, Naturwissenschaften und Technik, Handapparate</n></e>
        <e><c>25/016-016-10-TH</c><n xml:lang="de">BB Theologie, Freihand</n></e>
        <e><c>25/016-016-12-THLBS</c><n xml:lang="de">BB Theologie, Lehrbuchsammlung</n></e>
        <e><c>25/016-016-14-THRARA</c><n xml:lang="de">BB Theologie, Magazin</n></e>
        <e><c>25/016-016-16-THPSYCH</c><n xml:lang="de">BB Theologie, Handapparat Psychologie</n></e>
        <e><c>25/016-016-18-THFAK</c><n xml:lang="de">BB Theologie, Handapparate Fachbereich</n></e>
        <e><c>25/018-018-10-RW</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Freihand</n></e>
        <e><c>25/018-018-12-RWLBS</c><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Lernzentrum</n></e>
        <e><c>25/018-018-14-RWMAG</c><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Magazin</n></e>
        <e><c>25/018-020-RWFAK</c><ind>s Praesenzbestand</ind><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften, Lehrstühle</n></e>
        <e><c>25/019-019-10-GHFREI</c><campus>cg</campus><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Freihand</n></e>
        <e><c>25/019-019-12-GHLBS</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lehrbuchsammlung</n></e>
        <e><c>25/019-019-14-GHLS</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lesesaal</n></e>
        <e><c>25/019-019-16-GHMAG</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Magazin</n></e>
        <e><c>25/019-019-18-GHSEP</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Separiert</n></e>
        <e><c>25/019-019-20-GHFAK</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Handapparate</n></e>
        <e><c>25/019-019-22-GHZEB</c><n xml:lang="de">BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Zur Erwerbung bestellt</n></e>
        <e><c>25/066-066-10-RWETH</c><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften / Ethnologie und Afrikastudien</n></e>
        <e><c>25/066-066-12-RWAMA</c><n xml:lang="de">Zentralbibliothek, AMA - African Music Archives</n></e>
        <e><c>25/080-080-RWTURK</c><n xml:lang="de">BB Rechts- und Wirtschaftswissenschaften / Turkologie</n></e>
        <e><c>25/091-091-PHMUW</c><n xml:lang="de">BB Philosophicum, Musikwissenschaft</n></e>
        <e><c>25/112-112-10-PHHFMFREI</c><n xml:lang="de">BB Philosophicum, Hochschule für Musik, Freihand</n></e>
        <e><c>25/112-112-12-PHHFMMAG</c><n xml:lang="de">BB BB Philosophicum, Hochschule für Musik, Magazin</n></e>
        <e><c>25/999-009-FBMPI</c><ind>s Praesenzbestand</ind><n xml:lang="de">Max-Planck-Institut für Polymerforschung, Bibliothek</n></e>
        <e><c>25/999-034-FBGTEM</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Geschichte, Theorie und Ethik der Medizin</n></e>
        <e><c>25/999-094-FBIGL</c><ind>s Praesenzbestand</ind><n xml:lang="de">Institut für Geschichtliche Landeskunde Rheinland-Pfalz e.V., Bibliothek</n></e>
        <e><c>25/999-069-FBPSY</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Psychologisches Institut</n></e>
        <e><c>25/999-082-FBÄGYPT</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Altertumswissenschaften - Ägyptologie und Altorientalistik</n></e>
        <e><c>25/25/999-085-FBAVFGA</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Institut für Altertumswissenschaften - Vor- und Frühgeschichtliche Archäologie</n></e>
        <e><c>25/999-111-FBKUNST</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Kunsthochschule</n><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102600600</url></e>
        <e><c>25/999-124-FBGESANG</c><ind>s Praesenzbestand</ind><n xml:lang="de">Universität Mainz, Gesangbucharchiv</n></e>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        
        <xsl:for-each select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']"> <!-- für elektronische Bestände -->
            <!-- evtl. sortieren <xsl:sort select="..." order="ascending" lang="de"/> -->
            <xsl:apply-templates select=".//*"/> 
        </xsl:for-each>
        <xsl:for-each select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']"> <!-- für nicht elektronische Bestände -->
            <xsl:sort select="effectiveLocation/discoveryDisplayName" order="ascending" lang="de"/>
            <xsl:for-each select="items/item">
                <xsl:sort select="chronology" order="descending"/>
                <xsl:sort select="hrid" order="ascending"/>
                <xsl:apply-templates select="./*|./*/*"/>
                <xsl:apply-templates select="../../notes/note"/>
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
            <xsl:with-param name="value" select="$bbtabelle/e[c=current()]/n[@xml:lang=$lang]"/>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_link</xsl:with-param>
            <xsl:with-param name="value" select="($bbtabelle/e[c=current()]/url,$locationurl)[1]"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="notes[holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note"> <!-- Standorthinweis (aus 8201) -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">standort</xsl:with-param>
            <xsl:with-param name="value"><xsl:text>&lt;b&gt;Standort: &lt;/b&gt;</xsl:text><xsl:value-of select="."/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="notes[not(holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1') and staffOnly='false']/note">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_text</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
 
    <xsl:template match="status/name"> <!-- Trigger für Status (als immer eindeutig vorhanden vorausgesetzt) für Status und Ausleihindikator - emuliert LBS -->
        <xsl:variable select="substring(($bbtabelle/e[c=current()/../../effectiveLocation/discoveryDisplayName]/ind,../../permanentLoanType/name)[1],1,1)" name="ind"/> <!-- + temp loan type -->
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
                <status name='In process - not requestable'> <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Intellectual item'>            <b>IL</b><c>IL</c><d>IL</d><e>IL</e><i>IL</i><s>IL</s><u>IL</u> </status>
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
                <hinweis campus="cg"><t xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Germersheim: ohne Bestellung am Regal holen&lt;/font&gt;&lt;/b&gt;&lt;br&gt;Mainz: bestellen</t><t xml:lang="en">Germersheim: ...</t></hinweis>
                <hinweis campus="cm"><t xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Mainz: ohne Bestellung am Regal holen&lt;/font&gt;&lt;/b&gt;&lt;br&gt;Germersheim: bestellen</t><t xml:lang="en">Mainz: ...</t></hinweis>
            </xsl:variable>
            <xsl:variable name="cases">
                <UF><i>u</i><s>verfuegbar</s><xsl:copy-of select="$campusubmainz/hinweis[@campus=$bbtabelle/e[c=current()/../../effectiveLocation/discoveryDisplayName]/campus]/*"/></UF> <!-- bestellbar -->
                <IF><i>i</i><s>verfuegbar</s><t xml:lang="de">nur für den Lesesaal</t><t xml:lang="en">reading room only</t></IF> <!-- nur für den Lesesaal bestellbar -->
                <SX><i>s</i><t xml:lang="de">nicht ausleihbar</t><t xml:lang="en">not available for loan</t></SX> <!-- Päsenzbestand -->
                <EM><i>e</i><t xml:lang="de">vermisst</t><t xml:lang="en">missing</t></EM> <!-- vermisst -->
                <UV><i>u</i><s>vormerkbar</s></UV> <!-- vormerkbar -->
                <IV><i>i</i><s>vormerkbar</s><t xml:lang="de">nur für den Lesesaal</t><t xml:lang="en">reading room only</t></IV> <!-- nur für den Lesesaal vormerkbar -->
                <CN><i>c</i><s>nicht vormerkbar</s></CN> <!-- Präsenzbestand -->
                <XO><i>a</i><s>gesperrt</s></XO> <!--  -->
                
                <IL><h>https://localhost</h></IL> <!-- Intellectual Item, Link muss noch festgelegt werden -->
                <XX><i>g</i></XX> <!-- XX=Default: Nicht verfügbar -->
            </xsl:variable>
            <xsl:copy-of select="$cases/*[name()=($emulator/status[@name=current()]/*[name()=$ind],'XX')[1]]/*"/>
        </xsl:variable>
        <xsl:if test="$result/s">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_status</xsl:with-param>
                <xsl:with-param name="value" select="$result/s"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$result/i">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_ind</xsl:with-param>
                <xsl:with-param name="value" select="$result/i"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$result/t">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_text</xsl:with-param>
                <xsl:with-param name="value" select="$result/t[@xml:lang=$lang]"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$result/h">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_link</xsl:with-param>
                <xsl:with-param name="value" select="$result/h"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="loan/dueDate">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_datum</xsl:with-param>
            <xsl:with-param name="value" select="substring(loan/dueDate,0,11)"/>
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
