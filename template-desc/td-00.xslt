<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:td="urn:ietf:rfc:9999">
    <xsl:template match="td:td">
        <html>
            <head>
                <title>
                    <xsl:value-of select="@hreft"/>
                </title>
                <style type="text/css">
                    ul { margin : 0 }
                    .msg { color : #C0C0C0 }
                </style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="@hreft"/>
                </h1>
                <table rules="all" border="1" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Variable</th>
                            <th>Concept</th>
                            <th>Value Range</th>
                            <th>Description(s)</th>
                            <th>Annotation(s)</th>
                        </tr>
                    </thead>
                    <xsl:for-each select="td:variable">
                        <xsl:sort select="@name"/>
                        <tr>
                            <td>
                                <xsl:value-of select="@name"/>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="@concept-uri">
                                        <xsl:text>URI: </xsl:text>
                                        <code>
                                            <xsl:value-of select="@concept-uri"/>
                                        </code>
                                    </xsl:when>
                                    <xsl:when test="@concept-qname">
                                        <xsl:text>QName: </xsl:text>
                                        <code>
                                            <xsl:value-of select="@concept-qname"/>
                                        </code>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span class="msg">n/a</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="td:restriction">
                                        <div>
                                            <xsl:text>Base: </xsl:text>
                                            <code>
                                                <xsl:choose>
                                                    <xsl:when test="contains(td:restriction/@base, ':')">
                                                        <xsl:value-of select="td:restriction/@base"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <a href="http://www.w3.org/TR/xmlschema-2/#{td:restriction/@base}">
                                                            <xsl:value-of select="concat('xs:', td:restriction/@base)"/>
                                                        </a>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </code>
                                        </div>
                                        <xsl:if test="td:restriction/td:*">
                                            <ul>
                                                <xsl:for-each select="td:restriction/td:*">
                                                    <xsl:sort select="local-name()"/>
                                                    <li>
                                                        <code>
                                                            <a href="http://www.w3.org/TR/xmlschema-2/#rf-{local-name()}">
                                                                <xsl:value-of select="concat('xs:',local-name())"/>
                                                            </a>
                                                            <xsl:text>="</xsl:text>
                                                            <xsl:value-of select="@value"/>
                                                            <xsl:text>"</xsl:text>
                                                        </code>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span class="msg">n/a</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="td:documentation">
                                        <ul>
                                            <xsl:for-each select="td:documentation">
                                                <li>
                                                    <xsl:copy-of select="node()"/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span class="msg">n/a</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="td:appinfo">
                                        <ul>
                                            <xsl:for-each select="td:appinfo">
                                                <li>
                                                    <xsl:text>Source: </xsl:text>
                                                    <xsl:value-of select="@source"/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span class="msg">n/a</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>