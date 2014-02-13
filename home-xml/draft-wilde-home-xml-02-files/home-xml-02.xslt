<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xml="http://www.w3.org/XML/1998/namespace" version="1.0" xmlns:home="urn:ietf:rfc:XXXX" exclude-result-prefixes="home">
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
       <xsl:text>Link Relation </xsl:text>
       <code><xsl:value-of select="@rel"/></code>
       <xsl:text>: Link </xsl:text>
       <code>
        <xsl:choose>
         <xsl:when test="home:link">
          <xsl:variable name="link-URI">
           <xsl:call-template name="resolve-URI">
            <xsl:with-param name="URI" select="home:link/@href"/>
           </xsl:call-template>
          </xsl:variable>
          <a href="{$link-URI}" title="URI"><xsl:value-of select="$link-URI"/></a>
         </xsl:when>
         <xsl:otherwise>
          <xsl:variable name="template-URI">
           <xsl:call-template name="resolve-URI">
            <xsl:with-param name="URI" select="home:template/@href-template"/>
           </xsl:call-template>
          </xsl:variable>
          <a href="{$template-URI}" title="URI template"><xsl:value-of select="$template-URI"/></a>
         </xsl:otherwise>
        </xsl:choose>
       </code>
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
 <xsl:template name="resolve-URI">
  <xsl:param name="URI"/>
  <!-- This is not how URI resolution should be done; http://tools.ietf.org/html/rfc3986#section-5 describes the correct process. -->
  <xsl:value-of select="concat(/home:resources/@xml:base, $URI)"/>
 </xsl:template>
</xsl:stylesheet>