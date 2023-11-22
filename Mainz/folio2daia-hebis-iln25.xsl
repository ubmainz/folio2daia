<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="text"/>
    
    <xsl:template match="//instanceData">
        
        <xsl:apply-templates select="holdings/holding[holdingsTypeId='996f93e2-5b5e-4cf2-9168-33ced1f95eed']/*"/>
        <xsl:apply-templates select="holdings/holding[holdingsTypeId!='996f93e2-5b5e-4cf2-9168-33ced1f95eed']/items/item/*"></xsl:apply-templates>
        
    </xsl:template>
        
     <xsl:template match="hrid">
        <xsl:text>&#10;DAIAinfo </xsl:text>
        <xsl:text>epn </xsl:text>
        <xsl:value-of select="."/>
        <xsl:text> ofniAIAD</xsl:text>
    </xsl:template>
     
    <xsl:template match="electronicAccess/uri">
        <xsl:text>&#10;DAIAinfo </xsl:text>
        <xsl:text>online_link </xsl:text>
        <xsl:value-of select="."/>
        <xsl:text> ofniAIAD</xsl:text>  
    </xsl:template>
    
    <xsl:template match="effectiveCallNumberComponents">
        <xsl:text>&#10;DAIAinfo </xsl:text>
        <xsl:text>sig </xsl:text>
        <xsl:value-of select="prefix"/><xsl:value-of select="callNumber"/>
        <xsl:text> ofniAIAD</xsl:text>
    </xsl:template>
    
    <xsl:template match="*"/>


</xsl:stylesheet>