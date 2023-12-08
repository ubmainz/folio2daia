<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//instanceData"/>
    </xsl:template>

    <xsl:template match="instanceData">
        <xsl:text>&#10;</xsl:text>
        
        <xsl:apply-templates select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']//*"/>
        <xsl:apply-templates select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']/items/item//*"></xsl:apply-templates>
        
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
            <e><c>25/006-006-10-MINT</c><n>BB MINT Freihand</n></e>
            <e><c>25/006-006-12-MINTLBS</c><n>BB MINT Lehrbuchsammlung</n></e>
            <e><c>25/006-006-14-MINTFAK</c><n>BB MINT Handapparate</n></e>
            <e><c>25/004-004-PHRVK</c><n>BB Philosophicum RVK-Aufstellung</n></e>
            <e><c>25/004-127-PHMAG</c><n>BB Philosophicum Magazin</n></e>
            <e><c>25/004-071-PHAVL</c><n>BB Philosophicum AVL</n></e>
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
