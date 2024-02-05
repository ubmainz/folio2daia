<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    <!-- Sprache, default ist Deutsch -->
    <xsl:param name="language" select="(//lang,'de')[1]"/>
    <!-- Default Standort-URL -->
    <xsl:param name="locationurl" select="'https://www.ub.uni-mainz.de/de/standorte'"/>
    <!-- Tabelle "bbtabelle" mit allen Infomationen zu den Standorten:
         c : [pflicht] Standort-Code wie er in effectiveLocation/discoveryDisplayName übergeben wird, gleichzeitig Sortierkriterium
         n : [pflicht] Name des Standorts wir er ausgegeben werden soll, ggf. sprachabhängig <n xml:lang="de">...</n><n xml:lang="en">...</n>
             (Bei Fehlen des Sprachtextes wird der Text der ersten Sprache verwendet.)
         ind : [optional] Ausleihindikator, überschreibt für diesen Standort den Wert, der aus FOLIO kommt
         url : [optional] URL für den Nutzer mit Infomationen für den Nutzer (z.B. Normdatensatz), default siehe oben
         campus : [optional] Campus Germersheim ("cg") oder Campus Mainz ("cm") für campusübergreifende Ausleihe UB Mainz -->
    <xsl:variable name="bbtabelle">
        <e>
            <c>ILN204/CG/UB/Freihand1OG</c>
            <n xml:lang="de">UB Freihand, 1. OG</n>
            <n xml:lang="en">UB Open-shelf collection, 1st floor.</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>
        </e>
        <e>
            <c>ILN204/CG/UB/Freihand2OG</c>
            <n xml:lang="de">UB Freihand, 1. OG</n>
            <n xml:lang="en">UB Open-shelf collection, 1st floor.</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagAltbau</c>
            <campus>Magazin</campus>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <n xml:lang="en">University Library (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>
            
            <sto_n xml:lang="de">Magazin</sto_n>
            <!--<sto_n xml:lang="en">Closed Stacks</sto_n>-->
            <h>https://opac.uni-giessen.de/LBS_WEB/volumes/show.htm?USR=7701&amp;BES=1&amp;EPN={HRID}&amp;LOGIN=ANONYMOUS</h>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMag3</c>
            <campus>Magazin</campus>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <n xml:lang="en">University Library (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>
            
            <sto_n xml:lang="de">Magazin</sto_n>
            <!--<sto_n xml:lang="en">Closed Stacks</sto_n>-->
            <h>https://opac.uni-giessen.de/LBS_WEB/volumes/show.htm?USR=7701&amp;BES=1&amp;EPN={HRID}&amp;LOGIN=ANONYMOUS</h>
        </e>
        <e>
            <c>ILN204/CG/UB/UBMagKeller</c>
            <campus>Magazin</campus>
            <n xml:lang="de">Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</n>
            <n xml:lang="en">University Library (UB), Otto-Behaghel-Str. 8</n>
            <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>
            
            <sto_n xml:lang="de">Magazin</sto_n>
            <!--<sto_n xml:lang="en">Closed Stacks</sto_n>-->
            <h>https://opac.uni-giessen.de/LBS_WEB/volumes/show.htm?USR=7701&amp;BES=1&amp;EPN={HRID}&amp;LOGIN=ANONYMOUS</h>
        </e>
        <e>
            <c>ILN204/CG/UB/UBSemapp</c>
            <campus>Semesterapparate</campus>
            <n xml:lang="de">Semesterapparate UB</n>
            <n xml:lang="en">UB Course Reserves</n>
            <ind>i</ind>
            <url>https://www.uni-giessen.de/ub/de/forlehr/litbereit/semesterapparate/copy_of_semesterapparate</url>
            
            <h>https://lbs-services.hrz.uni-giessen.de/services/public/semapp/?db=1&amp;epn={HRID}</h>
        </e>
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
        
    <xsl:template match="effectiveLocation/code">
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
 
    <xsl:template match="yearCaption">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">zeit_bestand01</xsl:with-param>
        </xsl:call-template>        
    </xsl:template>

    <xsl:template match="status/name"> <!-- Trigger für Status (als immer eindeutig vorhanden vorausgesetzt) für Status und Ausleihindikator - emuliert LBS -->
        <!-- MF: Hier war für Gießen eine Änderung in der substring-Funktion notwendig, da 
                 der Ausleihindikator bei uns in permanentLoanType/name an der dritten Stelle steht,
                 also z.B. "0 u ausleihbar" -->
        <xsl:variable select="( $bbtabelle/e[c=current()/../../effectiveLocation/code]/ind,
                                substring(../../permanentLoanType/name, 3, 1)
                                )[1]" name="ind"/> <!-- + temp loan type -->
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
                <hinweis-u campus="cg"><t2 xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Germersheim: ohne Bestellung am Regal holen&lt;/font&gt;&lt;/b&gt;</t2><t3 xml:lang="de">Mainz: bestellen</t3></hinweis-u> <!-- Z.B. Englisch: <t xml:lang="en">Germersheim: ...</t> -->
                <hinweis-u campus="cm"><t2 xml:lang="de">&lt;b&gt;&lt;font color="red"&gt;Mainz: ohne Bestellung am Regal holen&lt;/font&gt;&lt;/b&gt;</t2><t3 xml:lang="de">Germersheim: bestellen</t3></hinweis-u>
                <hinweis-s campus="cg"><t2 xml:lang="de">Aufsatzkopien/Kurzausleihe für Campus Mainz möglich, bitte wenden Sie sich an die Information</t2></hinweis-s>
                <hinweis-s campus="cm"><t2 xml:lang="de">Aufsatzkopien/Kurzausleihe für Campus Germersheim möglich, bitte wenden Sie sich an die Information</t2></hinweis-s>
            </xsl:variable>
            <xsl:variable name="campusubgiessen">
                <hinweis-u campus="Magazin"><h>https://magazin.link</h><t1 xml:lang="de">Magazinbestellung</t1></hinweis-u>
            </xsl:variable>
            <!-- Liste der zu unterscheidenden Fälle im Discovery-System
                 Code aus zwei Großbuchstaben: Zuordnungscode für diesen Fall
                 i : Ausleihindikator, der weitergereicht wird
                 s : Status, der weitergereicht wird
                 t1, t2, t3 : Informationstext zu diesem Fall (Bei Fehlen des Sprachtextes wird der Text der ersten vorhandenen Sprache verwendet.)                 
                 h : Link, wie er hinter dem Bestellbutton hinterlegt werden soll -->
            <xsl:variable name="cases">
                <UF><i>u ausleihbar</i><s>verfuegbar</s><xsl:copy-of select="$campusubgiessen/hinweis-u[@campus=$bbtabelle/e[c=current()/../../effectiveLocation/code]/campus]/*"/></UF> <!-- bestellbar -->
                <IF><i>i Lesesaal</i><s>verfuegbar</s><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1></IF> <!-- nur für den Lesesaal bestellbar -->
                <SX><i>s Praesenzbestand</i><t1 xml:lang="de">nicht ausleihbar</t1><t1 xml:lang="en">not available for loan</t1>
                    <xsl:copy-of select="$campusubmainz/hinweis-s[@campus=$bbtabelle/e[c=current()/../../effectiveLocation/discoveryDisplayName]/campus]/*"/></SX> <!-- Päsenzbestand -->
                <EM><i>e vermisst</i><t1 xml:lang="de">vermisst</t1><t1 xml:lang="en">missing</t1><t2 xml:lang="de">nicht ausleihbar</t2><t2 xml:lang="en">not available for loan</t2></EM> <!-- vermisst -->
                <UV><i>u ausleihbar</i><s>vormerkbar</s></UV> <!-- vormerkbar -->
                <IV><i>i Lesesaal</i><s>vormerkbar</s><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1></IV> <!-- nur für den Lesesaal vormerkbar -->
                <CN><i>c</i><s>nicht vormerkbar</s></CN> <!-- Präsenzbestand -->
                <XO><i>a</i><s>gesperrt</s></XO> <!--  -->
                <UI><i>u ausleihbar</i><s>verfuegbar</s><xsl:copy-of select="$campusubmainz/hinweis-u[@campus=$bbtabelle/e[c=current()/../../effectiveLocation/discoveryDisplayName]/campus]/*"/>
                    <h>localhost:5000/?hrid=<xsl:value-of select="../../hrid"/></h></UI> <!-- Intellectual Item, lokaler link nur zum Testen -->
                <II><i>i Lesesaal</i><s>verfuegbar</s><t1 xml:lang="de">nur für den Lesesaal</t1><t1 xml:lang="en">reading room only</t1><h>localhost:5000/?hrid=<xsl:value-of select="../../hrid"/></h></II>
                <XX><i>g nicht_ausleihbar</i></XX> <!-- XX=Default: Nicht verfügbar -->
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
        <xsl:for-each select="$result/t1[1]|$result/t2[1]|$result/t3[1]">
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
         <xsl:variable name="locationtext"> <!-- Mapongo-Link -->
             <t xml:lang="de">Standort in der Bibliothek zeigen</t>
             <t xml:lang="en">show location</t>
         </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">sig</xsl:with-param>
            <xsl:with-param name="value" select="string-join((prefix,callNumber),' ')"/>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
             <xsl:with-param name="tag">standort</xsl:with-param>
             <xsl:with-param name="value">
                 <xsl:text>&lt;a target=&quot;_blank&quot; href=&quot;http://bibmap.ub.uni-giessen.de/bm/BIBMAP_Server?signatur=</xsl:text>
                 <xsl:value-of select="encode-for-uri(callNumber)"/>
                 <xsl:text>&quot;&gt;</xsl:text>
                 <xsl:call-template name="selectlanguage">
                     <xsl:with-param name="fields" select="$locationtext/t"/>
                 </xsl:call-template>
             </xsl:with-param>
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
