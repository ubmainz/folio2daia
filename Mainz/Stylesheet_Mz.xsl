<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/instanceData">
        <xsl:variable name="lang" select="lang"/>
        <xsl:text>Konvertierungsregeln für MZ (!anpassen)</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:choose>
            <xsl:when test="error and (matches(hrid, '8\d{7}[\dxX]'))">
                <!-- Eine Katalogkarte (Retrodigitalisiert) Erkannt-->
                <xsl:text>&#10;DAIAinfo </xsl:text>
                <xsl:text>epn </xsl:text>
                <xsl:value-of select="hrid"/>
                <xsl:text> ofniAIAD</xsl:text>

                <xsl:text>&#10;DAIAinfo abt_num 960 ofniAIAD </xsl:text>
                <xsl:text>&#10;DAIAinfo abt_name Digitalisierter Zettelkatalog ofniAIAD </xsl:text>
                <xsl:text>&#10;DAIAinfo abt_link http://www.uni-Mainz.de/ub/.... ofniAIAD </xsl:text>
                <xsl:text>&#10;DAIAinfo aus_ind y unbekannt ofniAIAD </xsl:text>
                <xsl:text>&#10;DAIAinfo sig siehe Katalogkarte oben rechts ofniAIAD</xsl:text>
                <xsl:text disable-output-escaping="yes">&#10;DAIAinfo aus_link https://-Link fuer Mainz&amp;BES=1&amp;LOGIN=ANONYMOUS&amp;PPN=</xsl:text><xsl:value-of
                    select="hrid"/><xsl:text> ofniAIAD</xsl:text>
            </xsl:when>
            <xsl:when test="error">
                <!-- Keine Ergebnisse in Folio gefunden -->
                <xsl:text>&#10;DAIAinfo </xsl:text>
                <xsl:text>epn </xsl:text>
                <xsl:value-of select="hrid"/>
                <xsl:text> ofniAIAD</xsl:text>

                <xsl:text>&#10;DAIAinfo </xsl:text>
                <xsl:text>error </xsl:text>
                <xsl:value-of select="normalize-space(error)"/>
                <xsl:text> ofniAIAD</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="kategorie_0500" select="instance/administrativeNotes = 'Oax (Kategorie 0500)'"/>
                <xsl:variable name="kategorie_7135" select="instance/administrativeNotes = 'Oax (Kategorie 7135)'"/>
                <xsl:for-each select="holdings/holding">
                    <!-- '013e0b2c-2259-4ee8-8d15-f463f1aeb0b1' ist die UUID von holdingsNoteType "Standort (8201)" -->
                    <xsl:variable name="kategorie_8201" select="notes[holdingsNoteTypeId = '013e0b2c-2259-4ee8-8d15-f463f1aeb0b1']/note"/>
                    <xsl:variable name="zeit_bestand" select="holdingsStatements/statement"/>
                    <!-- '996f93e2-5b5e-4cf2-9168-33ced1f95eed' ist die UUID von holdingsType "Elektronisch" -->
                    <xsl:if test="holdingsTypeId = '996f93e2-5b5e-4cf2-9168-33ced1f95eed'">
                        <xsl:variable name="hrid" select="hrid"/>
                        <xsl:variable name="BIK" select="effectiveLocation/details/BIK"/>

                        <xsl:if test="$hrid">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>epn </xsl:text>
                            <xsl:value-of select="$hrid"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>
                        <xsl:if test="$BIK">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_num </xsl:text>
                            <xsl:value-of select="$BIK"/>
                            <xsl:text> ofniAIAD</xsl:text>

                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_name </xsl:text>
                            <xsl:choose>
                                <xsl:when test="$BIK = '992'">
                                    <xsl:text>Universitätsbibliothek (UB), Mainz.....</xsl:text>
                                </xsl:when>
                                <xsl:when test="$BIK = '009'">
                                    <xsl:text>Zweigbibliothek im .....</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="effectiveLocation/name"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text> ofniAIAD</xsl:text>

                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_link https://www.uni-mainz ...........?bik=</xsl:text>
                            <xsl:value-of select="encode-for-uri($BIK)"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:if test="$kategorie_0500">
                            <xsl:text>&#10;DAIAinfo aus_ind x online ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:if test="electronicAccess/uri">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>online_link </xsl:text>
                            <xsl:value-of select="electronicAccess/uri"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:for-each
                                select="notes[staffOnly='false' and not(holdingsNoteTypeId='d1d99196-8904-4b2e-9125-9f7bbbf54cc1' and note='0')]">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>aus_text </xsl:text>
                            <xsl:value-of select="note"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:for-each>

                        <!-- "Lizenzindikator" == "0" -->
                        <xsl:if test="notes[holdingsNoteTypeId='d1d99196-8904-4b2e-9125-9f7bbbf54cc1' and note='0']">
                            <xsl:text>&#10;DAIAinfo aus_text Frei zugänglich ofniAIAD</xsl:text>
                            <xsl:text>&#10;DAIAinfo aus_status frei ofniAIAD</xsl:text>
                        </xsl:if>
                        <xsl:text>&#10;</xsl:text>
                    </xsl:if>

                    <xsl:for-each select="items/item">

                        <xsl:variable name="hrid" select="hrid"/>
                        <xsl:variable name="BIK" select="effectiveLocation/details/BIK"/>
                        <xsl:variable name="permanentLoanType" select="permanentLoanType/name"/>
                        <xsl:variable name="callNumber" select="effectiveCallNumberComponents/callNumber"/>
                        <xsl:variable name="aus_status" select="status/name"/>

                        <xsl:variable name="CanAddStandort" select="tokenize($permanentLoanType,' ')[1] != 'a' and
                                                                 tokenize($permanentLoanType,' ')[1] != 'e' and
                                                                 tokenize($permanentLoanType,' ')[1] != 'z' and
                                                                 not($kategorie_0500) and not($kategorie_7135) and
                                                                 $callNumber != '/'"/>

                        <xsl:if test="$hrid">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>epn </xsl:text>
                            <xsl:value-of select="$hrid"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:if test="$BIK">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_num </xsl:text>
                            <xsl:value-of select="$BIK"/>
                            <xsl:text> ofniAIAD</xsl:text>

                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_name </xsl:text>
                            <xsl:choose>
                                <xsl:when test="$BIK = '000'">
                                    <xsl:choose>
                                        <xsl:when test="$lang='en'">
                                            <xsl:text>UB Gi (en)</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                           <xsl:text>Universitätsbibliothek (UB), Otto-Behaghel-Str. 8</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="$BIK = '009'">
                                    <xsl:text>Zweigbibliothek im Philosophikum II (ZP2), Karl-Glöckner-Str. 21</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="effectiveLocation/name"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text> ofniAIAD</xsl:text>

                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>abt_link https://www.uni-MAINZ.de/......./bik?bik=</xsl:text>
                            <xsl:value-of select="encode-for-uri($BIK)"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:if test="$callNumber">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>sig </xsl:text>
                            <xsl:value-of select="$callNumber"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:choose>
                            <xsl:when test="$kategorie_8201 = 'hap10410171'">
                                <xsl:text>&#10;DAIAinfo </xsl:text>
                                <xsl:text>standort </xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;a href="https://www.uni-XXXXXXX.de/ub/rnavi/standorte/ub-db/hap?hap=hap10410171"&gt;Prof. Brinkmann, Inst. f. Evangel. Theologie, Phil. II, Haus H&lt;/a&gt;</xsl:text>
                                <xsl:text> ofniAIAD</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="$CanAddStandort">
                                    <xsl:text>&#10;DAIAinfo </xsl:text>
                                    <xsl:text>standort </xsl:text>
                                    <xsl:text disable-output-escaping="yes">&lt;a href="http://bibmap.ub.uni-MAINZ..../BIBMAP_Server?signatur=</xsl:text>
                                    <xsl:value-of select="encode-for-uri($callNumber)"/>
                                    <xsl:text disable-output-escaping="yes">"/&gt;Standort in der Bibliothek anzeigen</xsl:text>
                                    <xsl:text> ofniAIAD</xsl:text>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>

                        <xsl:if test="$permanentLoanType">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>aus_ind </xsl:text>
                            <xsl:choose>
                                <xsl:when test="$permanentLoanType = '3 s Tagesausleihe'">
                                    <xsl:text>s Praesenzbestand</xsl:text>
                                </xsl:when>
                                <xsl:when test="$permanentLoanType = '5 i Nur für den Lesesaal'">
                                    <xsl:text>i Lesesaal</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring($permanentLoanType, 3)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>
                        <xsl:if test="$zeit_bestand">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>zeit_bestand </xsl:text>
                            <xsl:value-of select="$zeit_bestand"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:if test="$aus_status">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>aus_status </xsl:text>
                            <xsl:choose>
                                <xsl:when test="($permanentLoanType = '3 s Tagesausleihe' and $aus_status='Available') or $kategorie_8201">
                                    <xsl:text>unbekannt</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$aus_status='Checked out' and $lang='de'">
                                            <xsl:text>vormerkbar</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$aus_status='Available' and $lang='de'">
                                            <xsl:text>verfuegbar</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$aus_status='Intellectual item' and $lang='de'">
                                            <xsl:text>frei_best</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat($aus_status,' (', $lang, ')')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>
                        <xsl:if test="$aus_status='Checked out'  or $aus_status = 'On order' or $zeit_bestand">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>aus_link </xsl:text>
                            <xsl:text disable-output-escaping="yes">https://opac.uni-MAINZ ...../show.htm?BES=1&amp;LOGIN=ANONYMOUS&amp;LNG=DU&amp;EPN=</xsl:text>
                            <xsl:value-of select="encode-for-uri(replace($hrid, '\d-[0-9]+', ''))"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>
                        <xsl:if test="$aus_status='Checked out'">
                            <xsl:text>&#10;DAIAinfo </xsl:text>
                            <xsl:text>aus_datum </xsl:text>
                            <xsl:value-of select="substring(loan/dueDate, 0, 11)"/>
                            <xsl:text> ofniAIAD</xsl:text>
                        </xsl:if>

                        <xsl:choose>
                            <xsl:when test="$permanentLoanType = '3 s Tagesausleihe' and $aus_status='Available'">
                                <xsl:text>&#10;DAIAinfo </xsl:text>
                                <xsl:text>aus_text </xsl:text>
                                <xsl:text>Vor Ort benutzbar</xsl:text>
                                <xsl:text> ofniAIAD</xsl:text>
                            </xsl:when>
                            <xsl:when test="$permanentLoanType = '5 i Nur für den Lesesaal'">
                                <xsl:text>&#10;DAIAinfo </xsl:text>
                                <xsl:text>aus_text </xsl:text>
                                <xsl:text>Nur zur Benutzung im Lesesaal</xsl:text>
                                <xsl:text> ofniAIAD</xsl:text>
                            </xsl:when>
                        </xsl:choose>

                        <xsl:text>&#10;</xsl:text>

                    </xsl:for-each>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>


