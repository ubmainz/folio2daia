<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    
    <xsl:template match="//instanceData">
        
        <xsl:apply-templates select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']/*"/>
        <xsl:apply-templates select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']/items/item/*"></xsl:apply-templates>
        
    </xsl:template>
        
     <xsl:template match="hrid">
         <xsl:call-template name="DAIA">
             <xsl:with-param name="tag">epn</xsl:with-param>
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
            <xsl:with-param name="value"><xsl:value-of select="prefix"/><xsl:value-of select="callNumber"/></xsl:with-param>
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