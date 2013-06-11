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
                            <dl>
                                <xsl:if test="home:template/home:var">
                                    <dt>Variables: </dt>
                                    <dd>
                                        <ul>
                                            <xsl:for-each select="home:template/home:var">
                                                <xsl:sort select="@name"/>
                                                <li>
                                                    <span title="Variable Name"><xsl:value-of select="@name"/></span>
                                                    <xsl:text>: </xsl:text>
                                                    <span title="Associated URI"><xsl:value-of select="@URI"/></span>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </dd>
                                </xsl:if>
                                <xsl:if test="home:hints">
                                    <dt>Hints: </dt>
                                    <dd>
                                        <ul>
                                            <xsl:for-each select="home:hints/home:*">
                                                <xsl:sort select="local-name()"/>
                                                <li>
                                                    <span title="Hint Name"><xsl:value-of select="local-name()"/></span>
                                                    <xsl:text>: </xsl:text>
                                                    <xsl:choose>
                                                        <xsl:when test="home:i">
                                                            <xsl:for-each select="home:i">
                                                                <xsl:value-of select="."/>
                                                                <xsl:if test="position() != last()">
                                                                    <xsl:text>, </xsl:text>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="."/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </dd>
                                </xsl:if>
                            </dl>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>