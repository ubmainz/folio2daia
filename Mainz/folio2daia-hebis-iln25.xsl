<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    <!-- language, defaults to de -->
    <xsl:param name="lang" select="(//lang,'de')[1]"/>
    <!-- default location url -->
    <xsl:param name="locationurl" select="'https://www.ub.uni-mainz.de/de/standorte'"/>
    <xsl:variable name="tabelle"> <!-- Sprachvarianten, z.B. <de>...</de><en>...</en> -->
        <e><c>25/000-000-10-ZBFREI</c><de>Zentralbibliothek, Bücherturm</de><en>Central Library, Book Tower</en></e>  
        <e><c>25/000-000-12-ZBLBS</c><de>Zentralbibliothek, Lehrbuchsammlung</de></e>
        <e><c>25/000-000-14-ZBLS</c><de>Zentralbibliothek,Lesesaal</de></e>
        <e><c>25/000-000-16-ZBMAG</c><de>Zentralbibliothek, Magazin</de></e>
        <e><c>25/000-000-18-ZBRARA</c><de>Zentralbibliothek, Rara</de></e>
        <e><c>25/000-000-20-ZBSEM</c><ind>s Praesenzbestand</ind><de>Zentralbibliothek, Semesterapparate</de></e>
        <e><c>25/000-000-22-ZBZEB</c><de>Zentralbibliothek, Zur Erwerbung bestellt</de></e>
        <e><c>25/002-002-10-GFGPÄD</c><de>BB Georg Forster-Gebäude, Erziehungswissenschaft</de></e>
        <e><c>25/002-002-12-GFGFILM</c><de>BB Georg Forster-Gebäude, Filmwissenschaft</de></e>
        <e><c>25/002-002-14-GFGJOUR</c><de>BB Georg Forster-Gebäude, Journalistik</de></e>
        <e><c>25/002-002-16-GFGPOL</c><de>BB Georg Forster-Gebäude, Politikwissenschaft</de></e>
        <e><c>25/002-002-18-GFGPSYCH</c><de>BB Georg Forster-Gebäude, Psychologie</de></e>
        <e><c>25/002-002-20-GFGPUB</c><de>BB Georg Forster-Gebäude, Publizistik</de></e>
        <e><c>25/002-002-22-GFGSOZ</c><de>BB Georg Forster-Gebäude, Soziologie</de></e>
        <e><c>25/002-002-24-GFGSEM</c><ind>s Praesenzbestand</ind><de>BB Georg Forster-Gebäude, Semesterapparate</de></e>
        <e><c>25/002-002-26-GFGZEB</c><de>BB Georg Forster-Gebäude, Zur Erwerbung bestellt</de></e>
        <e><c>25/002-079-GFGKUN</c><de>BB Georg Forster-Gebäude, Kunstgeschichte</de></e>
        <e><c>25/002-110-GFGGEO</c><de>BB Georg Forster-Gebäude, Geographie und Geowissenschaften</de></e>
        <e><c>25/002-113-GFGSPO</c><de>BB Georg Forster-Gebäude, Sportwissenschaften</de></e>
        <e><c>25/002-126-GFGUSA</c><de>BB Georg Forster-Gebäude, USA-Bibliothek</de></e>
        <e><c>25/004-004-PHRVK</c><de>BB Philosophicum, RVK-Aufstellung</de></e>
        <e><c>25/004-058-PHPHI</c><de>BB Philosophicum, Philosophie</de></e>
        <e><c>25/004-070-PHGER</c><de>BB Philosophicum, Germanistik I / Kulturanthropologie und Germanistik II</de></e>
        <e><c>25/004-071-PHAVL</c><de>BB Philosophicum, Allgemeine und Vergleichende Literaturwissenschaft</de></e>
        <e><c>25/004-072-PHANG</c><de>BB Philosophicum, Anglistik/Amerikanistik</de></e>
        <e><c>25/004-073-PHAVS</c><de>BB Philosophicum, Allgemeine und Vergleichende Spachwissenschaft</de></e>
        <e><c>25/004-074-PHROM</c><de>BB Philosophicum, Romanistik</de></e>
        <e><c>25/004-075-PHSLAV</c><de>BB Philosophicum, Slavistik</de></e>
        <e><c>25/004-076-PHPOL</c><de>BB Philosophicum, Polonicum</de></e>
        <e><c>25/004-077-PHKLP</c><de>BB Philosophicum, Klassische Philologie</de></e>
        <e><c>25/004-078-PHKLA</c><de>BB Philosophicum, Klassische Archäologie</de></e>
        <e><c>25/004-083-PHKLW</c><de>BB Philosophicum, Historische Kulturwissenschaften</de></e>
        <e><c>25/004-086-PHALG</c><de>BB Philosophicum, Alte Geschichte</de></e>
        <e><c>25/004-087-PHBYZ</c><de>BB Philosophicum, Byzantinistik</de></e>
        <e><c>25/004-088-PHMNG</c><de>BB Philosophicum, Mittlere und neuere Geschichte</de></e>
        <e><c>25/004-090-PHBUW</c><de>BB Philosophicum, Buchwissenschaft</de></e>
        <e><c>25/004-092-PHOEG</c><de>BB Philosophicum, Osteuropäische Geschichte</de></e>
        <e><c>25/004-120-PHTHW</c><de>BB Philosophicum, Theaterwissenschaft / Medienkulturwissenschaft / Alltagsmedien</de></e>
        <e><c>25/004-127-PHMAG</c><de>BB Philosophicum, Magazin</de></e>
        <e><c>25/005-005-10-UMFH</c><de>BB Universitätsmedizin, Freihand</de></e>
        <e><c>25/005-005-12-UMLBS</c><de>BB Universitätsmedizin, Lehrbuchsammlung</de></e>
        <e><c>25/005-005-14-UMLS</c><de>BB Universitätsmedizin, Lesesaal</de></e>
        <e><c>25/005-035-UMRMED</c><de>BB Universitätsmedizin, Institut für Rechtsmedizin</de></e>
        <e><c>25/005-043-UMPSY</c><de>BB Universitätsmedizin, Klinik für Psychiatrie und Psychotherapie</de></e>
        <e><c>25/005-054-UMZMK</c><de>BB Universitätsmedizin, Zahnklinik</de></e>
        <e><c>25/006-006-10-MINT</c><de>BB Mathematik, Informatik, Naturwissenschaften und Technik, Freihand</de></e>
        <e><c>25/006-006-12-MINTLBS</c><de>BB Mathematik, Informatik, Naturwissenschaften und Technik, Lehrbuchsammlung</de></e>
        <e><c>25/006-006-14-MINTFAK</c><de>BB Mathematik, Informatik, Naturwissenschaften und Technik, Handapparate</de></e>
        <e><c>25/016-016-10-TH</c><de>BB Theologie, Freihand</de></e>
        <e><c>25/016-016-12-THLBS</c><de>BB Theologie, Lehrbuchsammlung</de></e>
        <e><c>25/016-016-14-THRARA</c><de>BB Theologie, Magazin</de></e>
        <e><c>25/016-016-16-THPSYCH</c><de>BB Theologie, Handapparat Psychologie</de></e>
        <e><c>25/016-016-18-THFAK</c><de>BB Theologie, Handapparate Fachbereich</de></e>
        <e><c>25/018-018-10-RW</c><ind>s Praesenzbestand</ind><de>BB Rechts- und Wirtschaftswissenschaften, Freihand</de></e>
        <e><c>25/018-018-12-RWLBS</c><de>BB Rechts- und Wirtschaftswissenschaften, Lernzentrum</de></e>
        <e><c>25/018-018-14-RWMAG</c><de>BB Rechts- und Wirtschaftswissenschaften, Magazin</de></e>
        <e><c>25/018-020-RWFAK</c><ind>s Praesenzbestand</ind><de>BB Rechts- und Wirtschaftswissenschaften, Lehrstühle</de></e>
        <e><c>25/019-019-10-GHFREI</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Freihand</de></e>
        <e><c>25/019-019-12-GHLBS</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lehrbuchsammlung</de></e>
        <e><c>25/019-019-14-GHLS</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lesesaal</de></e>
        <e><c>25/019-019-16-GHMAG</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Magazin</de></e>
        <e><c>25/019-019-18-GHSEP</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Separiert</de></e>
        <e><c>25/019-019-20-GHFAK</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Handapparate</de></e>
        <e><c>25/019-019-22-GHZEB</c><de>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Zur Erwerbung bestellt</de></e>
        <e><c>25/066-066-10-RWETH</c><de>BB Rechts- und Wirtschaftswissenschaften / Ethnologie und Afrikastudien</de></e>
        <e><c>25/066-066-12-RWAMA</c><de>Zentralbibliothek, AMA - African Music Archives</de></e>
        <e><c>25/080-080-RWTURK</c><de>BB Rechts- und Wirtschaftswissenschaften / Turkologie</de></e>
        <e><c>25/091-091-PHMUW</c><de>BB Philosophicum, Musikwissenschaft</de></e>
        <e><c>25/112-112-10-PHHFMFREI</c><de>BB Philosophicum, Hochschule für Musik, Freihand</de></e>
        <e><c>25/112-112-12-PHHFMMAG</c><de>BB BB Philosophicum, Hochschule für Musik, Magazin</de></e>
        <e><c>25/999-009-FBMPI</c><ind>s Praesenzbestand</ind><de>Max-Planck-Institut für Polymerforschung, Bibliothek</de></e>
        <e><c>25/999-034-FBGTEM</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Institut für Geschichte, Theorie und Ethik der Medizin</de></e>
        <e><c>25/999-094-FBIGL</c><ind>s Praesenzbestand</ind><de>Institut für Geschichtliche Landeskunde Rheinland-Pfalz e.V., Bibliothek</de></e>
        <e><c>25/999-069-FBPSY</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Psychologisches Institut</de></e>
        <e><c>25/999-082-FBÄGYPT</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Institut für Altertumswissenschaften - Ägyptologie und Altorientalistik</de></e>
        <e><c>25/25/999-085-FBAVFGA</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Institut für Altertumswissenschaften - Vor- und Frühgeschichtliche Archäologie</de></e>
        <e><c>25/999-111-FBKUNST</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Kunsthochschule</de><url>http://cbsopac.rz.uni-frankfurt.de/DB=2.1/SET=2/TTL=1/PPNSET?PPN=102600600</url></e>
        <e><c>25/999-124-FBGESANG</c><ind>s Praesenzbestand</ind><de>Universität Mainz, Gesangbucharchiv</de></e>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        
        <xsl:for-each select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']">
            <!-- evtl. sortieren <xsl:sort select="..." order="ascending" lang="de"/> -->
            <xsl:apply-templates select=".//*"/> 
        </xsl:for-each>
        <xsl:for-each select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']">
            <xsl:sort select="effectiveLocation/discoveryDisplayName" order="ascending" lang="de"/>
            <xsl:for-each select="items/item">
                <xsl:sort select="chronology" order="descending"/>
                <xsl:sort select="hrid" order="ascending"/>
                <xsl:apply-templates select=".//*"/>
                <xsl:apply-templates select="../../notes/note"/>
            </xsl:for-each>
        </xsl:for-each>
        
    </xsl:template>
        
     <xsl:template match="hrid">
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
    
    <xsl:template match="effectiveLocation/discoveryDisplayName">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_num</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_name</xsl:with-param>
            <xsl:with-param name="value" select="$tabelle/e[c=current()]/*[name()=$lang]"/>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_link</xsl:with-param>
            <xsl:with-param name="value" select="($tabelle/e[c=current()]/url,$locationurl)[1]"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="notes[holdingsNoteTypeId='013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note">
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
 
    <xsl:template match="status/name">
        <xsl:variable select="substring(($tabelle/e[c=current()/../../effectiveLocation/discoveryDisplayName]/ind,../../permanentLoanType/name)[1],1,1)" name="ind"/> <!-- + temp loan type -->
        <xsl:variable name="result">
            <xsl:variable name="emulator">
                <status name='Available'>                    <b>UF</b><c>UF</c><d>UF</d><e>EM</e><i>IF</i><s>SX</s><u>UF</u> </status> <!-- b,c,d ist in Mainz ausleihbar -->
                <status name='Awaiting pickup'>              <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Checked out'>                  <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Claimed returned'/> 
                <status name='Declared lost'/>   
                <status name='In process'>                   <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='In process - not requestable'> <b>UV</b><c>UV</c><d>UV</d><e>EM</e><i>IV</i><s>CN</s><u>UV</u> </status>
                <status name='Intellectual item'>            <b>IL</b><c>IL</c><d>IL</d><e>IL</e><i>IL</i><s>IL</s><u>IL</u> </status> <!-- bei ZS: Link zur Bestellung -->
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
            <xsl:variable name="cases">
                <UF><i>u</i><s>verfuegbar</s></UF> <!--  -->
                <IF><i>i</i><s>verfuegbar</s></IF> <!--  -->
                <SX><i>s</i></SX>
                <EM><i>e</i><t>vermisst</t></EM><!-- tbd Sprachsteuerung -->
                <UV><i>u</i><s>vormerkbar</s></UV> <!--  -->
                <IV><i>i</i><s>vormerkbar</s><t>nur für den Lesesaal</t></IV> <!--  -->
                <CN><i>c</i><s>nicht vormerkbar</s></CN> <!--  -->
                <XO><i>a</i><s>gesperrt</s></XO> <!--  -->
                
                <IL><i> </i></IL> <!-- Intelectual Item -->
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
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_ind</xsl:with-param>
            <xsl:with-param name="value" select="$result/i"/>
        </xsl:call-template>
        <xsl:if test="$result/t">
            <xsl:call-template name="DAIA">
                <xsl:with-param name="tag">aus_text</xsl:with-param>
                <xsl:with-param name="value" select="$result/t"/>
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

    <xsl:template name="DAIA">
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
