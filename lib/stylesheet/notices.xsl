<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

  <xsl:template match="*">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
<html>
  <head>
    <title><xsl:value-of select='summary/title'/></title>
    <link rel='stylesheet' type='text/css' href='{summary/css_url}' media='screen, projection, tv, print'/>
  </head>
  <body>
  
  <header>
    <nav>
      <ul>
        <li>
          <a href="/">home</a>
        </li>
        <li>
          <a href="/notices">notices</a>
        </li>
      </ul>
    </nav>
  </header>
    
  <div>
  <ul>
  <xsl:for-each select="records/entry">
    <li>
     <xsl:copy-of select='desc/span'/>
     <time><xsl:value-of select='time'/></time>
    </li>
  </xsl:for-each>
  </ul>
  </div>

  <aside>
  <ul>
    <li><xsl:value-of select='summary/date'/></li>
    <li>
      <a href="{summary/edit_url}" rel="nofollow">edit</a>
    </li>      
    </ul>
  </aside>  

  <footer>
    <dl id="info">
      <dt>Source:</dt><dd><a href="index.txt">index.txt</a></dd>
      <dt>XML:</dt><dd><a href="formatted.xml">formatted.xml</a></dd>
      <dt>Published:</dt><dd><xsl:value-of select="summary/published"/></dd>
    </dl>
  </footer>  
  
  </body>
</html>
  </xsl:template>
</xsl:stylesheet>