<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        
        <xsl:for-each select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']">
            <xsl:sort select="holdingsTypeId" order="ascending" lang="de"/> <!-- Sortierkriterium muss noch festgelegt werden -->
            <xsl:apply-templates select="//*"/> 
        </xsl:for-each>
        <xsl:for-each select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']">
            <xsl:sort select="effectiveLocation/discoveryDisplayName" order="ascending" lang="de"/>
            <xsl:apply-templates select="items/item//*"/>
        </xsl:for-each>
        
    </xsl:template>
        
     <xsl:template match="hrid">
         <xsl:call-template name="DAIA">
             <xsl:with-param name="tag">epn</xsl:with-param>
         </xsl:call-template>
    </xsl:template>

    <xsl:template match="error">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">error</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="permanentLoanType/name"> <!-- noch ohne Logik -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_ind</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="effectiveLocation/discoveryDisplayName">
        <xsl:variable name="tabelle">
            <e><c>25/000-000-10-ZBFREI</c><n>Zentralbibliothek, Bücherturm</n></e>
            <e><c>25/000-000-12-ZBLBS</c><n>Zentralbibliothek, Lehrbuchsammlung</n></e>
            <e><c>25/000-000-14-ZBLS</c><n>Zentralbibliothek,Lesesaal</n></e>
            <e><c>25/000-000-16-ZBMAG</c><n>Zentralbibliothek, Magazin</n></e>
            <e><c>25/000-000-18-ZBRARA</c><n>Zentralbibliothek, Rara</n></e>
            <e><c>25/000-000-20-ZBSEM</c><n>Zentralbibliothek, Semesterapparate</n></e>
            <e><c>25/000-000-22-ZBZEB</c><n>Zentralbibliothek, Zur Erwerbung bestellt</n></e>
            <e><c>25/002-002-10-GFGPÄD</c><n>BB Georg Forster-Gebäude, Erziehungswissenschaft</n></e>
            <e><c>25/002-002-12-GFGFILM</c><n>BB Georg Forster-Gebäude, Filmwissenschaft</n></e>
            <e><c>25/002-002-14-GFGJOUR</c><n>BB Georg Forster-Gebäude, Journalistik</n></e>
            <e><c>25/002-002-16-GFGPOL</c><n>BB Georg Forster-Gebäude, Politikwissenschaft</n></e>
            <e><c>25/002-002-18-GFGPSYCH</c><n>BB Georg Forster-Gebäude, Psychologie</n></e>
            <e><c>25/002-002-20-GFGPUB</c><n>BB Georg Forster-Gebäude, Publizistik</n></e>
            <e><c>25/002-002-22-GFGSOZ</c><n>BB Georg Forster-Gebäude, Soziologie</n></e>
            <e><c>25/002-002-24-GFGSEM</c><n>BB Georg Forster-Gebäude, Semesterapparate</n></e>
            <e><c>25/002-002-26-GFGZEB</c><n>BB Georg Forster-Gebäude, Zur Erwerbung bestellt</n></e>
            <e><c>25/002-079-GFGKUN</c><n>BB Georg Forster-Gebäude, Kunstgeschichte</n></e>
            <e><c>25/002-110-GFGGEO</c><n>BB Georg Forster-Gebäude, Geographie und Geowissenschaften</n></e>
            <e><c>25/002-113-GFGSPO</c><n>BB Georg Forster-Gebäude, Sportwissenschaften</n></e>
            <e><c>25/002-126-GFGUSA</c><n>BB Georg Forster-Gebäude, USA-Bibliothek</n></e>
            <e><c>25/004-004-PHRVK</c><n>BB Philosophicum, RVK-Aufstellung</n></e>
            <e><c>25/004-058-PHPHI</c><n>BB Philosophicum, Philosophie</n></e>
            <e><c>25/004-070-PHGER</c><n>BB Philosophicum, Germanistik I / Kulturanthropologie und Germanistik II</n></e>
            <e><c>25/004-071-PHAVL</c><n>BB Philosophicum, Allgemeine und Vergleichende Literaturwissenschaft</n></e>
            <e><c>25/004-072-PHANG</c><n>BB Philosophicum, Anglistik/Amerikanistik</n></e>
            <e><c>25/004-073-PHAVS</c><n>BB Philosophicum, Allgemeine und Vergleichende Spachwissenschaft</n></e>
            <e><c>25/004-074-PHROM</c><n>BB Philosophicum, Romanistik</n></e>
            <e><c>25/004-075-PHSLAV</c><n>BB Philosophicum, Slavistik</n></e>
            <e><c>25/004-076-PHPOL</c><n>BB Philosophicum, Polonicum</n></e>
            <e><c>25/004-077-PHKLP</c><n>BB Philosophicum, Klassische Philologie</n></e>
            <e><c>25/004-078-PHKLA</c><n>BB Philosophicum, Klassische Archäologie</n></e>
            <e><c>25/004-083-PHKLW</c><n>BB Philosophicum, Historische Kulturwissenschaften</n></e>
            <e><c>25/004-086-PHALG</c><n>BB Philosophicum, Alte Geschichte</n></e>
            <e><c>25/004-087-PHBYZ</c><n>BB Philosophicum, Byzantinistik</n></e>
            <e><c>25/004-088-PHMNG</c><n>BB Philosophicum, Mittlere und neuere Geschichte</n></e>
            <e><c>25/004-090-PHBUW</c><n>BB Philosophicum, Buchwissenschaft</n></e>
            <e><c>25/004-092-PHOEG</c><n>BB Philosophicum, Osteuropäische Geschichte</n></e>
            <e><c>25/004-120-PHTHW</c><n>BB Philosophicum, Theaterwissenschaft / Medienkulturwissenschaft / Alltagsmedien</n></e>
            <e><c>25/004-127-PHMAG</c><n>BB Philosophicum, Magazin</n></e>
            <e><c>25/005-005-10-UMFH</c><n>BB Universitätsmedizin, Freihand</n></e>
            <e><c>25/005-005-12-UMLBS</c><n>BB Universitätsmedizin, Lehrbuchsammlung</n></e>
            <e><c>25/005-005-14-UMLS</c><n>BB Universitätsmedizin, Lesesaal</n></e>
            <e><c>25/005-035-UMRMED</c><n>BB Universitätsmedizin, Institut für Rechtsmedizin</n></e>
            <e><c>25/005-043-UMPSY</c><n>BB Universitätsmedizin, Klinik für Psychiatrie und Psychotherapie</n></e>
            <e><c>25/005-054-UMZMK</c><n>BB Universitätsmedizin, Zahnklinik</n></e>
            <e><c>25/006-006-10-MINT</c><n>BB Mathematik, Informatik, Naturwissenschaften und Technik, Freihand</n></e>
            <e><c>25/006-006-12-MINTLBS</c><n>BB Mathematik, Informatik, Naturwissenschaften und Technik, Lehrbuchsammlung</n></e>
            <e><c>25/006-006-14-MINTFAK</c><n>BB Mathematik, Informatik, Naturwissenschaften und Technik, Handapparate</n></e>
            <e><c>25/016-016-10-TH</c><n>BB Theologie, Freihand</n></e>
            <e><c>25/016-016-12-THLBS</c><n>BB Theologie, Lehrbuchsammlung</n></e>
            <e><c>25/016-016-14-THRARA</c><n>BB Theologie, Magazin</n></e>
            <e><c>25/016-016-16-THPSYCH</c><n>BB Theologie, Handapparat Psychologie</n></e>
            <e><c>25/016-016-18-THFAK</c><n>BB Theologie, Handapparate Fachbereich</n></e>
            <e><c>25/018-018-10-RW</c><n>BB Rechts- und Wirtschaftswissenschaften, Freihand</n></e>
            <e><c>25/018-018-12-RWLBS</c><n>BB Rechts- und Wirtschaftswissenschaften, Lernzentrum</n></e>
            <e><c>25/018-018-14-RWMAG</c><n>BB Rechts- und Wirtschaftswissenschaften, Magazin</n></e>
            <e><c>25/018-020-RWFAK</c><n>BB Rechts- und Wirtschaftswissenschaften, Lehrstühle</n></e>
            <e><c>25/019-019-10-GHFREI</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Freihand</n></e>
            <e><c>25/019-019-12-GHLBS</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lehrbuchsammlung</n></e>
            <e><c>25/019-019-14-GHLS</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Lesesaal</n></e>
            <e><c>25/019-019-16-GHMAG</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Magazin</n></e>
            <e><c>25/019-019-18-GHSEP</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Separiert</n></e>
            <e><c>25/019-019-20-GHFAK</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Handapparate</n></e>
            <e><c>25/019-019-22-GHZEB</c><n>BB Translations-, Sprach- und Kulturwissenschaft, Campus Germersheim, Zur Erwerbung bestellt</n></e>
            <e><c>25/066-066-10-RWETH</c><n>BB Rechts- und Wirtschaftswissenschaften / Ethnologie und Afrikastudien</n></e>
            <e><c>25/066-066-12-RWAMA</c><n>Zentralbibliothek, AMA - African Music Archives</n></e>
            <e><c>25/080-080-RWTURK</c><n>BB Rechts- und Wirtschaftswissenschaften / Turkologie</n></e>
            <e><c>25/091-091-PHMUW</c><n>BB Philosophicum, Musikwissenschaft</n></e>
            <e><c>25/112-112-10-PHHFMFREI</c><n>BB Philosophicum, Hochschule für Musik, Freihand</n></e>
            <e><c>25/112-112-12-PHHFMMAG</c><n>BB BB Philosophicum, Hochschule für Musik, Magazin</n></e>
            <e><c>25/999-009-FBMPI</c><n>Max-Planck-Institut für Polymerforschung, Bibliothek</n></e>
            <e><c>25/999-034-FBGTEM</c><n>Universität Mainz, Institut für Geschichte, Theorie und Ethik der Medizin</n></e>
            <e><c>25/999-094-FBIGL</c><n>Institut für Geschichtliche Landeskunde Rheinland-Pfalz e.V., Bibliothek</n></e>
            <e><c>25/999-069-FBPSY</c><n>Universität Mainz, Psychologisches Institut</n></e>
            <e><c>25/999-082-FBÄGYPT</c><n>Universität Mainz, Institut für Altertumswissenschaften - Ägyptologie und Altorientalistik</n></e>
            <e><c>25/25/999-085-FBAVFGA</c><n>Universität Mainz, Institut für Altertumswissenschaften - Vor- und Frühgeschichtliche Archäologie</n></e>
            <e><c>25/999-111-FBKUNST</c><n>Universität Mainz, Kunsthochschule</n></e>
            <e><c>25/999-124-FBGESANG</c><n>Universität Mainz, Gesangbucharchiv</n></e>
        </xsl:variable>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_num</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">abt_name</xsl:with-param>
            <xsl:with-param name="value" select="$tabelle/e[c=current()]/n"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="status/name"> <!-- noch sehr schlicht -->
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_status</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:choose>
                    <xsl:when test=".='Checked out'">
                        <xsl:text>vormerkbar</xsl:text>
                    </xsl:when>
                    <xsl:when test=".='Available'">
                        <xsl:text>verfuegbar</xsl:text>
                    </xsl:when>
                    <xsl:when test=".='Intellectual item'"> <!-- c-Sätze (location=dummy) ? -->
                        <xsl:text>frei_best</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
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
    
    <xsl:template match="notes[staffOnly='false']/note">
        <xsl:call-template name="DAIA">
            <xsl:with-param name="tag">aus_text</xsl:with-param>
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
