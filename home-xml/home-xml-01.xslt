<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:home="urn:ietf:rfc:XXXX" exclude-result-prefixes="home">
    <xsl:output method="html"/>
    <xsl:template match="home:resources">
        <html>
            <head>
                <title>Home Document</title>
            </head>
            <body>
                <h1>Home Document</h1>
                <ul>
                    <xsl:for-each select="home:resource">
                        <li>
                            <span title="Link Relation"><xsl:value-of select="@rel"/></span>
                            <xsl:text>: </xsl:text>
                            <xsl:choose>
                                <xsl:when test="home:link">
                                    <a href="{home:link/@href}" title="URI"><xsl:value-of select="home:link/@href"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a href="{home:template/@href-template}" title="URI template"><xsl:value-of select="home:template/@href-template"/></a>
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>