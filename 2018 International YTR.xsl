<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!-- NOTE: THIS IS A TEST STATEMENT _ DO NOT USE . -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:decimal-format decimal-separator="," grouping-separator="&#160;" name="FrenchDecimalFormat"/>
  <xsl:decimal-format decimal-separator="." grouping-separator="," name="USDecimalFormat"/>
  <!--	<xsl:param name="STATUS"/>    Tried to use this to determine if someone is Active or Inactive, but the value was null -->
  <!-- Routines to convert scientific notation - begin -->
  <xsl:template name="Scientific">
    <xsl:param name="Num"/>
    <xsl:param name="DefaultNum" select="0"/>
    <xsl:choose>
      <xsl:when test="$Num != ''">
        <xsl:if test="boolean(number(substring-after($Num,'E')))">
          <xsl:call-template name="Scientific_Helper">
            <xsl:with-param name="m" select="substring-before($Num,'E')"/>
            <xsl:with-param name="e" select="substring-after($Num,'E')"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="not(boolean(number(substring-after($Num,'E'))))">
          <xsl:value-of select="$Num"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$DefaultNum"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="Scientific_Helper">
    <xsl:param name="m"/>
    <xsl:param name="e"/>
    <xsl:choose>
      <xsl:when test="$e = 0 or not(boolean($e))">
        <xsl:value-of select="$m"/>
      </xsl:when>
      <xsl:when test="$e &gt; 0">
        <xsl:call-template name="Scientific_Helper">
          <xsl:with-param name="m" select="$m * 10"/>
          <xsl:with-param name="e" select="$e - 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$e &lt; 0">
        <xsl:call-template name="Scientific_Helper">
          <xsl:with-param name="m" select="$m div 10"/>
          <xsl:with-param name="e" select="$e + 1"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- Routine to convert US standard date numbers mm/dd/yyyy to local form. - begin -->
  <xsl:template name="transformDate">
    <xsl:param name="theDate"/>
    <xsl:param name="target_locale" select="USA"/>
    <xsl:param name="separator" select="'/'"/>
    <xsl:variable name="theMonthValue" select="substring-before($theDate, $separator)"/>
    <xsl:variable name="leftoverMonth" select="substring-after($theDate, $separator)"/>
    <xsl:variable name="theDayValue" select="substring-before($leftoverMonth, $separator)"/>
    <xsl:variable name="theYearValue" select="substring-after($leftoverMonth, $separator)"/>
    <xsl:variable name="monthName">
    
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$target_locale = 'USA'">
        <xsl:value-of select="concat($monthName,' ',$theDayValue,', ', $theYearValue)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($theDayValue, ' ' , $monthName,' ', $theYearValue)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  
  <xsl:template match="/sf-compensation">
    <!-- Standard variable data. -->
    <xsl:param name="tstRatio" select="30"/>
    <xsl:param name="typeString" select="String"/>
    <xsl:param name="typeNumber" select="number"/>
    <xsl:param name="CompComponent" select="Component"/>
    <xsl:param name="CompComponentValue" select="Value"/>
    <xsl:variable name="Pct" select="'##0.#'"/>
    <xsl:variable name="firstName" select="./comp-plan-entry/comp-plan-entry-firstname"/>
    <xsl:variable name="lastName" select="./comp-plan-entry/comp-plan-entry-lastname"/>
    <xsl:variable name="jobTitle" select="./comp-plan-entry/comp-salary/comp-salary-jobTitle"/>
    <xsl:variable name="LOCAL_CURRENCY_CODE" select="./comp-plan-entry/comp-salary/comp-salary-localCurrencyCode"/>
    <xsl:variable name="ATTUID" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='CompATTUID']"/>
    <xsl:variable name="CurrencyCode" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='localCurrencyCode']"/>
    <xsl:variable name="Category1" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category1']"/>
    <xsl:variable name="Categroy1_Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Categroy1_Title']"/>
    <xsl:variable name="Category1Description" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category1Description']"/>
    <xsl:variable name="Category2" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category2']"/>
    <xsl:variable name="Category2_Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category2Title']"/>
    <xsl:variable name="Category2Description" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category2Description']"/>

    <xsl:variable name="Category3" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category3']"/>
    <xsl:variable name="Category3Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category3Title']"/>
    <xsl:variable name="Category3Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category3Description']"/>

    <xsl:variable name="Category4" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category4']"/>
    <xsl:variable name="Category4Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category4Title']"/>
    <xsl:variable name="Category4Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category4Description']"/>

    <xsl:variable name="Category5" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category5']"/>
    <xsl:variable name="Category5Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category5Title']"/>
    <xsl:variable name="Category5Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category5Description']"/>

    <xsl:variable name="Category6" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category6']"/>
    <xsl:variable name="Category6Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category6Title']"/>
    <xsl:variable name="Category6Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category6Description']"/>

    <xsl:variable name="Category7" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category7']"/>
    <xsl:variable name="Category7Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category7Title']"/>
    <xsl:variable name="Category7Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category7Description']"/>

    <xsl:variable name="Category8" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category8']"/>
    <xsl:variable name="Category8Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category8Title']"/>
    <xsl:variable name="Category8Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category8Description']"/>

    <xsl:variable name="Category9" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category9']"/>
    <xsl:variable name="Category9Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category9Title']"/>
    <xsl:variable name="Category9Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category9Description']"/>

    <xsl:variable name="Category10" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category10']"/>
    <xsl:variable name="Category10Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category10Title']"/>
    <xsl:variable name="Category10Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category10Description']"/>

    <xsl:variable name="Category11" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category11']"/>
    <xsl:variable name="Category11Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category11Title']"/>
    <xsl:variable name="Category11Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category11Description']"/>

    <xsl:variable name="Category12" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category12']"/>
    <xsl:variable name="Category12Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category12Title']"/>
    <xsl:variable name="Category12Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category12Description']"/>

    <xsl:variable name="Category13" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category13']"/>
    <xsl:variable name="Category13Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category13Title']"/>
    <xsl:variable name="Category13Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category13Description']"/>

    <xsl:variable name="Category14" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category14']"/>
    <xsl:variable name="Category14Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category14Title']"/>
    <xsl:variable name="Category14Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category14Description']"/>

    <xsl:variable name="Category15" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category15']"/>
    <xsl:variable name="Category15Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category15Title']"/>
    <xsl:variable name="Category15Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category15Description']"/>

    <xsl:variable name="Category16" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category16']"/>
    <xsl:variable name="Category16Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category16Title']"/>
    <xsl:variable name="Category16Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category16Description']"/>

    <xsl:variable name="Category17" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category17']"/>
    <xsl:variable name="Category17Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category17Title']"/>
    <xsl:variable name="Category17Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category17Description']"/>

    <xsl:variable name="Category18" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category18']"/>
    <xsl:variable name="Category18Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category18Title']"/>
    <xsl:variable name="Category18Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category18Description']"/>

    <xsl:variable name="Category19" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category19']"/>
    <xsl:variable name="Category19Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category19Title']"/>
    <xsl:variable name="Category19Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category19Description']"/>

    <xsl:variable name="Category20" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category20']"/>
    <xsl:variable name="Category20Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category20Title']"/>
    <xsl:variable name="Category20Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category20Description']"/>

    <xsl:variable name="Category21" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category21']"/>
    <xsl:variable name="Category21Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category21Title']"/>
    <xsl:variable name="Category21Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category21Description']"/>

    <xsl:variable name="Category22" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category22']"/>
    <xsl:variable name="Category22Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category22Title']"/>
    <xsl:variable name="Category22Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category22Description']"/>

    <xsl:variable name="Category23" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category23']"/>
    <xsl:variable name="Category23Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category23Title']"/>
    <xsl:variable name="Category23Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category23Description']"/>

    <xsl:variable name="Category24" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category24']"/>
    <xsl:variable name="Category24Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category24Title']"/>
    <xsl:variable name="Category24Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category24Description']"/>

    <xsl:variable name="Category25" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category25']"/>
    <xsl:variable name="Category25Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category25Title']"/>
    <xsl:variable name="Category25Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category25Description']"/>

    <xsl:variable name="Category26" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category26']"/>
    <xsl:variable name="Category26Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category26Title']"/>
    <xsl:variable name="Category26Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category26Description']"/>

    <xsl:variable name="Category27" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category27']"/>
    <xsl:variable name="Category27Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category27Title']"/>
    <xsl:variable name="Category27Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category27Description']"/>

    <xsl:variable name="Category28" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category28']"/>
    <xsl:variable name="Category28Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category28Title']"/>
    <xsl:variable name="Category28Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category28Description']"/>

    <xsl:variable name="Category29" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category29']"/>
    <xsl:variable name="Category29Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category29Title']"/>
    <xsl:variable name="Category29Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category29Description']"/>

    <xsl:variable name="Category30" select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category30']"/>
    <xsl:variable name="Category30Title"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category30Title']"/>
    <xsl:variable name="Category30Description"  select="./comp-plan-entry/comp-custom-data/comp-custom-field[@id='Category30Description']"/>

    <xsl:variable name="TotalSum" select ="$Category1 + $Category1"/>
    <xsl:variable name="Cat1Ratio" select ="($Category1 div $TotalSum) * 100"/>
    <xsl:variable name="Cat1RatioPct" select="format-number(Cat1Ratio, $Pct)"/>
    <xsl:variable name="Cat2Ratio" select ="($Category2 div $TotalSum) * 100"/>

    <xsl:variable name="curSymbol">
      <!-- Replace local currency code with currency symbol -->
      <xsl:choose>
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'USD'">&#x0024;</xsl:when>
        <!-- USA, UNITED STATES, United States Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'AED'">&#x062F;&#x002E;&#x0625;</xsl:when>
        <!-- ARE, UNITED ARAB EMIRATES, Arab Emirates Dirham -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'ARS'">&#x0024;</xsl:when>
        <!-- ARG, ARGENTINA, Argentine Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'AUD'">&#x0024;</xsl:when>
        <!-- AUS, AUSTRALIA, Australian Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- AUT, AUSTRIA, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- BEL, BELGIUM, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'BGN'">&#x043B;&#x0432;</xsl:when>
        <!-- BGR, BULGARIA, Bulgarian Lev -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'BRL'">&#x0052;&#x0024;</xsl:when>
        <!-- BRA, BRAZIL, Brazilian Real -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CAD'">&#x0024;</xsl:when>
        <!-- CAN, CANADA, Canadian Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CHF'">&#x0043;&#x0048;&#x0046;</xsl:when>
        <!-- CHE, SWITZERLAND, Swiss Franc -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CLP'">&#x0024;</xsl:when>
        <!-- CHL, CHILE, Chilean Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CNY'">&#x00A5;</xsl:when>
        <!-- CHN, CHINA, Chinese Yuan Renminbi -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'COP'">&#x0024;</xsl:when>
        <!-- COL, COLOMBIA, Colombian Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CRC'">&#x20A1;</xsl:when>
        <!-- CRI, COSTA RICA, Costa Rican Colon -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'ANG'">&#x0192;</xsl:when>
        <!-- CUW, CURACAO, Netherlands Antilles Guilder -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'CZK'">&#x004B;&#x010D;</xsl:when>
        <!-- CZE, CZECH REPUBLIC, Czech Koruna -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- DEU, GERMANY, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'DKK'">&#x006B;&#x0072;</xsl:when>
        <!-- DNK, DENMARK, Danish Krone -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'USD'">&#x0024;</xsl:when>
        <!-- ECU, ECUADOR, United States Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EGP'">&#x00A3;</xsl:when>
        <!-- EGY, EGYPT, Egyptian Pound -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- ESP, SPAIN, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- FIN, FINLAND, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- FRA, FRANCE, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'GBP'">&#x00A3;</xsl:when>
        <!-- GBR, UNITED KINGDOM, British Pound -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- GRC, GREECE, Euro, EUR -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'GTQ'">&#x0051;</xsl:when>
        <!-- GTM, GUATEMALA, Guatemalan Quetzal -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'HKD'">&#x0024;</xsl:when>
        <!-- HKG, HONG KONG, Hong Kong Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'HRK'">&#x006B;&#x006E;</xsl:when>
        <!-- HRV, CROATIA, Croatian Kuna -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'HUF'">&#x0046;&#x0074;</xsl:when>
        <!-- HUN, HUNGARY, Hungarian Forint -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'IDR'">&#x0052;&#x0070;</xsl:when>
        <!-- IDN, INDONESIA, Indonesian Rupiah -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'INR'">&#x20B9;</xsl:when>
        <!-- IND, INDIA, Indian Rupee -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- IRL, IRELAND, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'IQD'">&#x062F;&#x002E;&#x0639;</xsl:when>
        <!-- IRQ, IRAQ, Iraqi Dinar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'ILS'">&#x20AA;</xsl:when>
        <!-- ISR, ISRAEL, Israeli Shekel -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- ITA, ITALY, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'JMD'">&#x004A;&#x0024;</xsl:when>
        <!-- JAM, JAMAICA, Jamaican Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'JPY'">&#x00A5;</xsl:when>
        <!-- JPN, JAPAN, Japanese Yen -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'KRW'">&#x20A9;</xsl:when>
        <!-- KOR, KOREA, South-Korean Won -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- LUX, LUXEMBOURG, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'MXN'">&#x0024;</xsl:when>
        <!-- MEX, MEXICO, Mexican Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'MYR'">&#x0052;&#x004D;</xsl:when>
        <!-- MYS, MALAYSIA, Malaysian Ringgit -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- NLD, NETHERLANDS, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'NOK'">&#x006B;&#x0072;</xsl:when>
        <!-- NOR, NORWAY, Norwegian Kroner -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'NZD'">&#x0024;</xsl:when>
        <!-- NZL, NEW ZEALAND, New Zealand Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'PKR'">&#x20A8;</xsl:when>
        <!-- PAK, PAKISTAN, Pakistan Rupee -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'USD'">&#x0024;</xsl:when>
        <!-- PAN, PANAMA, United States Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'PEN'">&#x0053;&#x002F;&#x002E;</xsl:when>
        <!-- PER, PERU, Peruvian Nuevo Sol -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'PHP'">&#x20B1;</xsl:when>
        <!-- PHL, PHILIPPINES, Philippine Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'PLN'">&#x007A;&#x0142;</xsl:when>
        <!-- POL, POLAND, Polish Zloty -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- PRT, PORTUGAL, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'RON'">&#x006C;&#x0065;&#x0069;</xsl:when>
        <!-- ROU, ROMANIA, Romania New Leu -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'RUB'">&#x20BD;</xsl:when>
        <!-- RUS, RUSSIA, Russian Ruble -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'SGD'">&#x0024;</xsl:when>
        <!-- SGP, SINGAPORE, Singapore Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'SVC'">&#x0024;</xsl:when>
        <!-- SLV, EL SALVADOR, Salvadoran Colon -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'RSD'">&#x0414;&#x0438;&#x043D;&#x002E;</xsl:when>
        <!-- SRB, SERBIA, Serbian Dinar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- SVK, SLOVAKIA, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'EUR'">&#x20AC;</xsl:when>
        <!-- SVN, SLOVENIA, Euro -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'SEK'">&#x006B;&#x0072;</xsl:when>
        <!-- SWE, SWEDEN, Swedish Krona -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'THB'">&#x0E3F;</xsl:when>
        <!-- THA, THAILAND, Thailand Baht -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'TRY'">&#x20BA;</xsl:when>
        <!-- TUR, TURKEY, Turkish Lira -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'TWD'">&#x004E;&#x0054;&#x0024;</xsl:when>
        <!-- TWN, TAIWAN, New Taiwan Dollar -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'UYU'">&#x0024;&#x0055;</xsl:when>
        <!-- URY, URUGUAY, Uruguay Peso -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'VEF'">&#x0042;&#x0073;</xsl:when>
        <!-- VEN, VENEZUELA, Venezuelan Bolivar Fuerte -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'VND'">&#x20AB;</xsl:when>
        <!-- VTN, VIETNAM, Vietnamese Dong -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = 'ZAR'">&#x0052;</xsl:when>
        <!-- ZAF, SOUTH AFRICA, South African Rand -->
        <xsl:when test="$LOCAL_CURRENCY_CODE = ''">### Missing value for Local Currency Code ###</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$LOCAL_CURRENCY_CODE"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="FinalAmount">
      <!-- Total Reward Amount with currency symbol -->
      <xsl:choose>
        <xsl:when test="$Categroy1_Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category1,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category2_Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category2,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category3Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category3,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category4Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category4,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category5Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category5,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category6Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category6,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category7Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category7,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category8Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category8,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category9Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category9,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category10Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category10,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category11Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category11,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category12Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category12,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category13Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category13,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category14Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category14,'###,###'))"/>
        </xsl:when>

        <xsl:when test="$Category15Title = 'TOTAL REWARD VALUE'">
            <xsl:value-of select="concat($curSymbol,format-number($Category15,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category16Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category16,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category17Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category17,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category18Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category18,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category19Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category19,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category20Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category20,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category21Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category21,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category22Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category22,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category23Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category23,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category24Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category24,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category25Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category25,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category26Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category26,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category27Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category27,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category28Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category28,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category29Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category29,'###,###'))"/>
        </xsl:when>
        <xsl:when test="$Category30Title = 'TOTAL REWARD VALUE'">
          <xsl:value-of select="concat($curSymbol,format-number($Category30,'###,###'))"/>
        </xsl:when>
        <xsl:otherwise>
          <b>Error</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="NotUsedCategoryTitle1">
      <!-- Category available but not being used #1 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Categroy1_Title"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2_Title"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Title"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Title"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Title"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Title"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Title"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Title"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Title"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Title"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Title"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Title"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Title"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Title"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Title"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Title"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Title"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Title"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Title"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Title"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Title"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Title"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Title"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Title"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Title"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Title"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Title"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Title"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Title"/>
        </xsl:when>
        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="NotUsedCategoryDescription1">
      <!-- Category available but not being used #1 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Category1Description"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2Description"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Description"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Description"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Description"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Description"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Description"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Description"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Description"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Description"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Description"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Description"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Description"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Description"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Description"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Description"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Description"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Description"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Description"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Description"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Description"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Description"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Description"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Description"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Description"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Description"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Description"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Description"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Description"/>
        </xsl:when>

        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    
      <xsl:variable name="NotUsedCategoryTitle2">
        <!-- Category available but not being used #2 -->
        <xsl:choose>
          <xsl:when test="$Category1 &lt; 0">
            <xsl:value-of select="$Categroy1_Title"/>
          </xsl:when>
          <xsl:when test="$Category2 &lt; 0">
            <xsl:value-of select="$Category2_Title"/>
          </xsl:when>
          <xsl:when test="$Category3 &lt; 0">
            <xsl:value-of select="$Category3Title"/>
          </xsl:when>
          <xsl:when test="$Category4 &lt; 0">
            <xsl:value-of select="$Category4Title"/>
          </xsl:when>
          <xsl:when test="$Category5 &lt; 0">
            <xsl:value-of select="$Category5Title"/>
          </xsl:when>
          <xsl:when test="$Category6 &lt; 0">
            <xsl:value-of select="$Category6Title"/>
          </xsl:when>
          <xsl:when test="$Category7 &lt; 0">
            <xsl:value-of select="$Category7Title"/>
          </xsl:when>
          <xsl:when test="$Category8 &lt; 0">
            <xsl:value-of select="$Category8Title"/>
          </xsl:when>
          <xsl:when test="$Category9 &lt; 0">
            <xsl:value-of select="$Category9Title"/>
          </xsl:when>
          <xsl:when test="$Category10 &lt; 0">
            <xsl:value-of select="$Category10Title"/>
          </xsl:when>
          <xsl:when test="$Category11 &lt; 0">
            <xsl:value-of select="$Category11Title"/>
          </xsl:when>
          <xsl:when test="$Category12 &lt; 0">
            <xsl:value-of select="$Category12Title"/>
          </xsl:when>
          <xsl:when test="$Category13 &lt; 0">
            <xsl:value-of select="$Category13Title"/>
          </xsl:when>
          <xsl:when test="$Category14 &lt; 0">
            <xsl:value-of select="$Category14Title"/>
          </xsl:when>
          <xsl:when test="$Category15 &lt; 0">
            <xsl:value-of select="$Category15Title"/>
          </xsl:when>
          <xsl:when test="$Category16 &lt; 0">
            <xsl:value-of select="$Category16Title"/>
          </xsl:when>
          <xsl:when test="$Category17 &lt; 0">
            <xsl:value-of select="$Category17Title"/>
          </xsl:when>
          <xsl:when test="$Category18 &lt; 0">
            <xsl:value-of select="$Category18Title"/>
          </xsl:when>
          <xsl:when test="$Category19 &lt; 0">
            <xsl:value-of select="$Category19Title"/>
          </xsl:when>
          <xsl:when test="$Category20 &lt; 0">
            <xsl:value-of select="$Category20Title"/>
          </xsl:when>
          <xsl:when test="$Category21 &lt; 0">
            <xsl:value-of select="$Category21Title"/>
          </xsl:when>
          <xsl:when test="$Category22 &lt; 0">
            <xsl:value-of select="$Category22Title"/>
          </xsl:when>
          <xsl:when test="$Category23 &lt; 0">
            <xsl:value-of select="$Category23Title"/>
          </xsl:when>
          <xsl:when test="$Category24 &lt; 0">
            <xsl:value-of select="$Category24Title"/>
          </xsl:when>
          <xsl:when test="$Category25 &lt; 0">
            <xsl:value-of select="$Category25Title"/>
          </xsl:when>
          <xsl:when test="$Category26 &lt; 0">
            <xsl:value-of select="$Category26Title"/>
          </xsl:when>
          <xsl:when test="$Category27 &lt; 0">
            <xsl:value-of select="$Category27Title"/>
          </xsl:when>
          <xsl:when test="$Category28 &lt; 0">
            <xsl:value-of select="$Category28Title"/>
          </xsl:when>
          <xsl:when test="$Category29 &lt; 0">
            <xsl:value-of select="$Category29Title"/>
          </xsl:when>
          <xsl:otherwise>
            <b>NA</b>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>


      <xsl:variable name="NotUsedCategoryDescription2">
        <!-- Category available but not being used #2 -->
        <xsl:choose>
          <xsl:when test="$Category1 &lt; 0">
            <xsl:value-of select="$Category1Description"/>
          </xsl:when>
          <xsl:when test="$Category2 &lt; 0">
            <xsl:value-of select="$Category2Description"/>
          </xsl:when>
          <xsl:when test="$Category3 &lt; 0">
            <xsl:value-of select="$Category3Description"/>
          </xsl:when>
          <xsl:when test="$Category4 &lt; 0">
            <xsl:value-of select="$Category4Description"/>
          </xsl:when>
          <xsl:when test="$Category5 &lt; 0">
            <xsl:value-of select="$Category5Description"/>
          </xsl:when>
          <xsl:when test="$Category6 &lt; 0">
            <xsl:value-of select="$Category6Description"/>
          </xsl:when>
          <xsl:when test="$Category7 &lt; 0">
            <xsl:value-of select="$Category7Description"/>
          </xsl:when>
          <xsl:when test="$Category8 &lt; 0">
            <xsl:value-of select="$Category8Description"/>
          </xsl:when>
          <xsl:when test="$Category9 &lt; 0">
            <xsl:value-of select="$Category9Description"/>
          </xsl:when>
          <xsl:when test="$Category10 &lt; 0">
            <xsl:value-of select="$Category10Description"/>
          </xsl:when>
          <xsl:when test="$Category11 &lt; 0">
            <xsl:value-of select="$Category11Description"/>
          </xsl:when>
          <xsl:when test="$Category12 &lt; 0">
            <xsl:value-of select="$Category12Description"/>
          </xsl:when>
          <xsl:when test="$Category13 &lt; 0">
            <xsl:value-of select="$Category13Description"/>
          </xsl:when>
          <xsl:when test="$Category14 &lt; 0">
            <xsl:value-of select="$Category14Description"/>
          </xsl:when>
          <xsl:when test="$Category15 &lt; 0">
            <xsl:value-of select="$Category15Description"/>
          </xsl:when>
          <xsl:when test="$Category16 &lt; 0">
            <xsl:value-of select="$Category16Description"/>
          </xsl:when>
          <xsl:when test="$Category17 &lt; 0">
            <xsl:value-of select="$Category17Description"/>
          </xsl:when>
          <xsl:when test="$Category18 &lt; 0">
            <xsl:value-of select="$Category18Description"/>
          </xsl:when>
          <xsl:when test="$Category19 &lt; 0">
            <xsl:value-of select="$Category19Description"/>
          </xsl:when>
          <xsl:when test="$Category20 &lt; 0">
            <xsl:value-of select="$Category20Description"/>
          </xsl:when>
          <xsl:when test="$Category21 &lt; 0">
            <xsl:value-of select="$Category21Description"/>
          </xsl:when>
          <xsl:when test="$Category22 &lt; 0">
            <xsl:value-of select="$Category22Description"/>
          </xsl:when>
          <xsl:when test="$Category23 &lt; 0">
            <xsl:value-of select="$Category23Description"/>
          </xsl:when>
          <xsl:when test="$Category24 &lt; 0">
            <xsl:value-of select="$Category24Description"/>
          </xsl:when>
          <xsl:when test="$Category25 &lt; 0">
            <xsl:value-of select="$Category25Description"/>
          </xsl:when>
          <xsl:when test="$Category26 &lt; 0">
            <xsl:value-of select="$Category26Description"/>
          </xsl:when>
          <xsl:when test="$Category27 &lt; 0">
            <xsl:value-of select="$Category27Description"/>
          </xsl:when>
          <xsl:when test="$Category28 &lt; 0">
            <xsl:value-of select="$Category28Description"/>
          </xsl:when>
          <xsl:when test="$Category29 &lt; 0">
            <xsl:value-of select="$Category29Description"/>
          </xsl:when>

          <xsl:otherwise>
            <b>NA</b>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
    
    
    <xsl:variable name="NotUsedCategoryTitle3">
      <!-- Category available but not being used #3 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Categroy1_Title"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2_Title"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Title"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Title"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Title"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Title"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Title"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Title"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Title"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Title"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Title"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Title"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Title"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Title"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Title"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Title"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Title"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Title"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Title"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Title"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Title"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Title"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Title"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Title"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Title"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Title"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Title"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Title"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Title"/>
        </xsl:when>
        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="NotUsedCategoryDescription3">
      <!-- Category available but not being used #3 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Category1Description"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2Description"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Description"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Description"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Description"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Description"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Description"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Description"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Description"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Description"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Description"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Description"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Description"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Description"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Description"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Description"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Description"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Description"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Description"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Description"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Description"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Description"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Description"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Description"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Description"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Description"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Description"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Description"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Description"/>
        </xsl:when>

        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
    <xsl:variable name="NotUsedCategoryTitle4">
      <!-- Category available but not being used #4 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Categroy1_Title"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2_Title"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Title"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Title"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Title"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Title"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Title"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Title"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Title"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Title"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Title"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Title"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Title"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Title"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Title"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Title"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Title"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Title"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Title"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Title"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Title"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Title"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Title"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Title"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Title"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Title"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Title"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Title"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Title"/>
        </xsl:when>
        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="NotUsedCategoryDescription4">
      <!-- Category available but not being used #4 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Category1Description"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2Description"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Description"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Description"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Description"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Description"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Description"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Description"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Description"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Description"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Description"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Description"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Description"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Description"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Description"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Description"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Description"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Description"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Description"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Description"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Description"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Description"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Description"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Description"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Description"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Description"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Description"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Description"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Description"/>
        </xsl:when>

        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
    
    <xsl:variable name="NotUsedCategoryTitle5">
      <!-- Category available but not being used #5 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Categroy1_Title"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2_Title"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Title"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Title"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Title"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Title"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Title"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Title"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Title"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Title"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Title"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Title"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Title"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Title"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Title"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Title"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Title"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Title"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Title"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Title"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Title"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Title"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Title"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Title"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Title"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Title"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Title"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Title"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Title"/>
        </xsl:when>
        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="NotUsedCategoryDescription5">
      <!-- Category available but not being used #5 -->
      <xsl:choose>
        <xsl:when test="$Category1 &lt; 0">
          <xsl:value-of select="$Category1Description"/>
        </xsl:when>
        <xsl:when test="$Category2 &lt; 0">
          <xsl:value-of select="$Category2Description"/>
        </xsl:when>
        <xsl:when test="$Category3 &lt; 0">
          <xsl:value-of select="$Category3Description"/>
        </xsl:when>
        <xsl:when test="$Category4 &lt; 0">
          <xsl:value-of select="$Category4Description"/>
        </xsl:when>
        <xsl:when test="$Category5 &lt; 0">
          <xsl:value-of select="$Category5Description"/>
        </xsl:when>
        <xsl:when test="$Category6 &lt; 0">
          <xsl:value-of select="$Category6Description"/>
        </xsl:when>
        <xsl:when test="$Category7 &lt; 0">
          <xsl:value-of select="$Category7Description"/>
        </xsl:when>
        <xsl:when test="$Category8 &lt; 0">
          <xsl:value-of select="$Category8Description"/>
        </xsl:when>
        <xsl:when test="$Category9 &lt; 0">
          <xsl:value-of select="$Category9Description"/>
        </xsl:when>
        <xsl:when test="$Category10 &lt; 0">
          <xsl:value-of select="$Category10Description"/>
        </xsl:when>
        <xsl:when test="$Category11 &lt; 0">
          <xsl:value-of select="$Category11Description"/>
        </xsl:when>
        <xsl:when test="$Category12 &lt; 0">
          <xsl:value-of select="$Category12Description"/>
        </xsl:when>
        <xsl:when test="$Category13 &lt; 0">
          <xsl:value-of select="$Category13Description"/>
        </xsl:when>
        <xsl:when test="$Category14 &lt; 0">
          <xsl:value-of select="$Category14Description"/>
        </xsl:when>
        <xsl:when test="$Category15 &lt; 0">
          <xsl:value-of select="$Category15Description"/>
        </xsl:when>
        <xsl:when test="$Category16 &lt; 0">
          <xsl:value-of select="$Category16Description"/>
        </xsl:when>
        <xsl:when test="$Category17 &lt; 0">
          <xsl:value-of select="$Category17Description"/>
        </xsl:when>
        <xsl:when test="$Category18 &lt; 0">
          <xsl:value-of select="$Category18Description"/>
        </xsl:when>
        <xsl:when test="$Category19 &lt; 0">
          <xsl:value-of select="$Category19Description"/>
        </xsl:when>
        <xsl:when test="$Category20 &lt; 0">
          <xsl:value-of select="$Category20Description"/>
        </xsl:when>
        <xsl:when test="$Category21 &lt; 0">
          <xsl:value-of select="$Category21Description"/>
        </xsl:when>
        <xsl:when test="$Category22 &lt; 0">
          <xsl:value-of select="$Category22Description"/>
        </xsl:when>
        <xsl:when test="$Category23 &lt; 0">
          <xsl:value-of select="$Category23Description"/>
        </xsl:when>
        <xsl:when test="$Category24 &lt; 0">
          <xsl:value-of select="$Category24Description"/>
        </xsl:when>
        <xsl:when test="$Category25 &lt; 0">
          <xsl:value-of select="$Category25Description"/>
        </xsl:when>
        <xsl:when test="$Category26 &lt; 0">
          <xsl:value-of select="$Category26Description"/>
        </xsl:when>
        <xsl:when test="$Category27 &lt; 0">
          <xsl:value-of select="$Category27Description"/>
        </xsl:when>
        <xsl:when test="$Category28 &lt; 0">
          <xsl:value-of select="$Category28Description"/>
        </xsl:when>
        <xsl:when test="$Category29 &lt; 0">
          <xsl:value-of select="$Category29Description"/>
        </xsl:when>

        <xsl:otherwise>
          <b>NA</b>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    


        
        
    <html>
      <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
        <title>Successfactors: Statement v4c</title>
        <link href="https://performancemanager.successfactors.com/css/profed/styles.css"
					media="screen" rel="stylesheet" type="text/css"/>
        <link href="https://performancemanager.successfactors.com/css/profed/print.css"
					media="print" rel="stylesheet" type="text/css"/>
        <style type="text/css">
          #statementContainer {
          margin: 0 auto;
          width: 800px;
          text-align: left;
          border: 1px solid #e6e6e6;
          border-top: 2px solid #ccc;
          border-bottom: 0;
          }
          <!--
          @font-face {
          font-family: 'ATT'; /* give your font a name to reference it by later on! */
          src: url(ATTAleckSans_Blk.ttf);
          /* use src to point to the location of your custom font could be from your local server folder (like ./fonts/) or a remote location. */
          }-->
          #tblhdr {
          background: #1b7e28;
          color: white;
          }
          #tblplan {
          background: #0574ac;
          color: white;
          }
          #tblgoal {
          background: #ffffff;
          }
          .q1open, .q2open, .q3open, .q4open, .q5open {
          color: white;
          }
          .q1close, .q2close, .q3close, .q4close, .q5close {
          color: white;
          }
          .q1Dopen, .q2Dopen, .q3Dopen, .q4Dopen, .q5Dopen {
          color: white;
          }
          .q1Dclose, .q2Dclose, .q3Dclose, .q4Dclose, .q5Dclose {
          color: white;
          }
          <!--
          table{
          border-radius:10px;
          -moz-border-radius:10px;
          -webkit-border-radius:10px;
          } -->
          .two-col-special {
          <!--border: 1px dotted blue;-->
          overflow: auto;
          margin: 0;
          padding: 0;
          font-size:9px;
          }

          .two-col-special li {
          display: inline-block;
          width: 45%;
          margin: 0;
          padding: 0;
          vertical-align: top; /* In case multi-word categories form two lines */
          }
          .two-col-special li:before {
          content: '■';
          padding: 5px;
          margin-right: 5px; /* you can tweak the gap */
          color: orange;
          background-color: white; /* in case you want a color... */
          display: inline-block;
          }

          .two-col-special li:nth-child(1):before {
          color: #71c5e8;
          }

          .two-col-special li:nth-child(2):before {
          color: #0568ae;
          }

          .two-col-special li:nth-child(3):before {
          color: #d2d2d2;
          }

          .two-col-special li:nth-child(4):before {
          color: #959595;
          }

          .two-col-special li:nth-child(5):before {
          color: #5a5a5a;
          }
          .two-col-special li:nth-child(6):before {
          color: #ffb81c;
          }

          .two-col-special li:nth-child(7):before {
          color: #b5bd00;
          }

          .two-col-special li:nth-child(8):before {
          color: #4ca90c;
          }

          .two-col-special li:nth-child(9):before {
          color: #007a3e;
          }

          .two-col-special li:nth-child(10):before {
          color: #caa2dd;
          }

          .two-col-special li:nth-child(11):before {
          color: #9063cd;
          }

          .two-col-special li:nth-child(12):before {
          color: #702f8a;
          }


          <!--Starting new class for list in table-->
          .table-special {
          <!--border: 1px dotted blue;-->
          overflow: auto;
          margin: 0;
          padding: 0;
          font-size:12px;
          }

          .table-special li {
          display: inline-block;
          width: 45%;
          margin: 0;
          padding: 0;
          font-size: 36px;
          vertical-align: top; /* In case multi-word categories form two lines */
          }
          .table-special li:before {
          content: '■';
          padding: 5px;
          margin-right: 5px; /* you can tweak the gap */
          color: orange;
          background-color: white; /* in case you want a color... */
          display: inline-block;
          }

          .table-special li span {
          font-size: 12px;
          }
          .table-special li:nth-child(1):before {
          color: #71c5e8;
          }

          .table-special li:nth-child(2):before {
          color: #0568ae;
          }

          #center{
          position: absolute;
          top: 180px;
          left:140px;

          text-align: center;

          color: red;

          }

          @media print {
          #empinfo {color: black;}
          #plan {color: black;}
          #Graph { }
          #statementContainer { }
          }
        </style>
        <style type="text/css" media="print">
          td {
          color: black;
          }
        </style>

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">

          // Load the Visualization API and the corechart package.
          google.charts.load('current', {'packages':['corechart']});

          // Set a callback to run when the Google Visualization API is loaded.
          google.charts.setOnLoadCallback(drawChart);

          // Callback that creates and populates a data table,
          // instantiates the pie chart, passes in the data and
          // draws it.
          function drawChart() {

          // Create the data table.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Category');
          data.addColumn('number', 'Amount');
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Categroy1_Title"/><![CDATA[']]>,<xsl:value-of select="$Category1"/>]
          ]);
          
          if ((<xsl:value-of select="$Category2"/> > 0) <![CDATA[&&]]> (<![CDATA["]]><xsl:value-of select="$Category2_Title"/><![CDATA["]]> != "TOTAL REWARD VALUE")) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category2_Title"/><![CDATA[']]>,<xsl:value-of select="$Category2"/>]
          ]);
          };

          if (<xsl:value-of select="$Category3"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category3Title"/><![CDATA[']]>,<xsl:value-of select="$Category3"/>]
          ]);
          };

          if (<xsl:value-of select="$Category4"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category4Title"/><![CDATA[']]>,<xsl:value-of select="$Category4"/>]
          ]);
          };

          if (<xsl:value-of select="$Category5"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category5Title"/><![CDATA[']]>,<xsl:value-of select="$Category5"/>]
          ]);
          };

          if (<xsl:value-of select="$Category6"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category6Title"/><![CDATA[']]>,<xsl:value-of select="$Category6"/>]
          ]);
          };

          if (<xsl:value-of select="$Category7"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category7Title"/><![CDATA[']]>,<xsl:value-of select="$Category7"/>]
          ]);
          };

          if (<xsl:value-of select="$Category8"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category8Title"/><![CDATA[']]>,<xsl:value-of select="$Category8"/>]
          ]);
          };

          if (<xsl:value-of select="$Category9"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category9Title"/><![CDATA[']]>,<xsl:value-of select="$Category9"/>]
          ]);
          };
          
          if (<xsl:value-of select="$Category10"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category10Title"/><![CDATA[']]>,<xsl:value-of select="$Category10"/>]
          ]);
          };


          if (<xsl:value-of select="$Category11"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category11Title"/><![CDATA[']]>,<xsl:value-of select="$Category11"/>]
          ]);
          };


          if (<xsl:value-of select="$Category12"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category12Title"/><![CDATA[']]>,<xsl:value-of select="$Category12"/>]
          ]);
          };

          if (<xsl:value-of select="$Category13"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category13Title"/><![CDATA[']]>,<xsl:value-of select="$Category13"/>]
          ]);
          };

          if (<xsl:value-of select="$Category14"/> > 0 ) {
          data.addRows([
          [<![CDATA[']]><xsl:value-of select="$Category14Title"/><![CDATA[']]>,<xsl:value-of select="$Category14"/>]
          ]);
          };

          if ((<xsl:value-of select="$Category15"/> > 0) <![CDATA[&& ]]> (<![CDATA["]]><xsl:value-of select="$Category15Title"/><![CDATA["]]> != "TOTAL REWARD VALUE")) {
        data.addRows([
        [<![CDATA[']]><xsl:value-of select="$Category15Title"/><![CDATA[']]>,<xsl:value-of select="$Category15"/>]
          ]);
          };

          // data.addRows(['{$Categroy1_Title}',{$tstRatio}]);
          //data.addColumn('string',<xsl:value-of select="$Categroy1_Title"/>);
          //dataTable.addColumn('number',<xsl:value-of select="tstRatio"/>);

          // Set chart options
          var options = {
          // legend not displayed
          legend: {
          position: 'none',
          },
          sliceVisibilityThreshold: .0001,
          pieHole: 0.7,
          pieSliceText: 'none',
          pieSliceBorderColor: "none",
          colors: ['#71c5e8', '#0568ae', '#d2d2d2', '#959595' , '#5a5a5a', '#ffb81c', '#b5bd00', '#4ca90c', '#007a3e', '#caa2dd', '#9063cd', '#702f8a' ],
          width:'100%',
          'height':200};

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
          chart.draw(data, options);
          
          }
        </script>
      <!--https://performancemanager4.successfactors.com/doc/custom/ATT/att_CompStmt_Graphic_Header.JPG.jpg-->
       
      </head>
      <body class="statement">
        <div id="statementContainer">
          <table id="content" style="vertical-align: top;"
						summary="Compensation Statement" width="100%">
            <tr>
              <td style="vertical-align: top;  width=100%;">
              <!--  <table summary="logo" width="100%">
                  <tr>
                    <td class="logo" width="100%"> -->
                      <img
                      src="https://performancemanager4.successfactors.com/doc/custom/ATT/you_matter.png"
                      
												/>
                    </td>
                  </tr>
                </table>
            <!--  </td>
            </tr>
          </table> -->
          <table id="titlestatement" style="vertical-align:top;" width="100%">
            <tr>
              <td style="vertical-align: middle; padding-left: 10px; background: #009FDB; color: white;" width="100%" height="35px">
                <b> Your 2017 Total Rewards Statement </b>
              </td>
            </tr>
            <tr>
              <td style="vertical-align: middle; background: #ffffff; padding-left: 10px; color:#191919 font-size: 12px;">
                <strong> <xsl:value-of select="concat($firstName,' ',$lastName)"/>
                </strong>
              </td>
            </tr>
            <tr>
              <td style="vertical-align: middle; background: #ffffff; padding-left: 10px; color:#191919 font-size: 12px;">
                <xsl:value-of select="$jobTitle"/>
              </td>
              
            </tr>
          </table>
          
          <div id="statementContainer">
         
            <table id="graph_legend" style="vertical-align:top;" width="100%">
              <tr>
                <td style="vertical-align: middle; padding-left: 10px; background: #ffffff;  font-size: 9x;"  width="70%">
                  <ul class="two-col-special">
                    <!--<li type="square" style="color:#71c5e8; font-size: 9px;" >-->
                      <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Categroy1_Title"/>
                      </span>
                    </li>
                    <!--<li type="square" style="color:#0568ae" >-->
                    <xsl:if test="$Category2 &gt; 0 and ($Category2_Title != 'TOTAL REWARD VALUE')" >
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category2_Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category3 &gt; 0 and ($Category3Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category3Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category4 &gt; 0 and ($Category4Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category4Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category5 &gt; 0 and ($Category5Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category5Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category6 &gt; 0 and ($Category6Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category6Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category7 &gt; 0 and ($Category7Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category7Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category8 &gt; 0 and ($Category8Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category8Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category9 &gt; 0 and ($Category9Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category9Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category10 &gt; 0 and ($Category10Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category10Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category11 &gt; 0 and ($Category11Title != 'TOTAL REWARD VALUE')" >
                    <li>
                      <span style="color:#000000">
                        <xsl:value-of select="$Category11Title"/>
                      </span>
                    </li>
                    </xsl:if>
                    <xsl:if test="$Category12 &gt; 0 and ($Category12Title != 'TOTAL REWARD VALUE')" >
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category12Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category13 &gt; 0 and ($Category13Title != 'TOTAL REWARD VALUE')" >
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category13Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category14 &gt; 0 and ($Category14Title != 'TOTAL REWARD VALUE')" >
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category14Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category15 &gt; 0 and ($Category15Title != 'TOTAL REWARD VALUE')" >
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category15Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category16 &gt; 0 and ($Category16Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category16Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category17 &gt; 0 and ($Category17Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category17Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category18 &gt; 0 and ($Category18Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category18Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category19 &gt; 0 and ($Category19Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category19Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category20 &gt; 0 and ($Category20Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category20Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category21 &gt; 0 and ($Category21Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category21Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category22 &gt; 0 and ($Category22Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category22Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category23 &gt; 0 and ($Category23Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category23Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category24 &gt; 0 and ($Category24Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category24Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category25 &gt; 0 and ($Category25Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category25Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category26 &gt; 0 and ($Category26Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category26Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category27 &gt; 0 and ($Category27Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category27Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category28 &gt; 0 and ($Category28Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category28Title"/>
                        </span>
                      </li>
                    </xsl:if>
                    <xsl:if test="$Category29 &gt; 0 and ($Category29Title != 'TOTAL REWARD VALUE')">
                      <li>
                        <span style="color:#000000">
                          <xsl:value-of select="$Category29Title"/>
                        </span>
                      </li>
                    </xsl:if>

                  </ul>

                </td>
                <td>
                  <div style="position: relative; " id="chart_div"></div>
                 <!-- <div style="z-index: -1; text-align: center;">
                    <font style="color:black;font-weight: bold;font: 10px arial, sans-serif;">
                      <xsl:value-of select="$Category15"/>
                    </font>
                    <font style="color:grey;font: 10px arial, sans-serif;">92% to Target</font>
                  </div> -->
                </td>
              </tr>
             
            </table>

          <!--  
            <table style="vertical-align:top;" width="100%">
              <tr>
                <td width="15%" bgcolor="#71c5e8">
                                   
                </td>
                <td width="65%">
                  <b><xsl:value-of select="$Categroy1_Title"/>
                  </b>
                  <p>
                    <xsl:value-of select="$Category1Description"/>
                  </p>
                  
                </td>
                <td width="20%">
                  <b>
                    <xsl:value-of select="$Category1"/>
                  </b>
                </td>
              </tr>
              <tr>
                <td width="15%" bgcolor="#71c5e8">

                </td>
                <td style="padding:10px" width="65%">
                  <b>+
                    Title
                  </b>
                  <p>
                    Description
                  </p>

                </td>
                <td width="20%">
                  <b>
                    Amount
                  </b>00
                </td>
              </tr>
            </table> -->

            <script type="text/javascript" language="javascript">
              var bgcolorcodes = ["#71c5e8", "#0568ae", "#d2d2d2", "#959595" , "#5a5a5a", "#ffb81c", "#b5bd00", "#4ca90c", "#007a3e", "#caa2dd", "#9063cd", "#702f8a" ];
              var i = 0;
            </script>

            
            <table style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black; font-size:12px" width="100%">
              <xsl:if test="$Category1 &gt; 0 and ($Categroy1_Title != 'TOTAL REWARD VALUE')" >
                <!--This section to be displayed if category 1 is not total reward and also greater than 0-->
                
                <tr>
                  <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas1" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas1");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b><xsl:value-of select="$Categroy1_Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category1Description"/> </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb"><b><xsl:value-of select="concat($curSymbol,format-number($Category1,'###,###'))"/></b></span>
                    
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 2 is not total reward and also greater than 0-->
              <xsl:if test="$Category2 &gt; 0 and ($Category2_Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas2" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas2");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category2_Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category2Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category2,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 3 is not total reward and also greater than 0-->
              <xsl:if test="$Category3 &gt; 0 and ($Category3Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas3" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas3");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category3Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category3Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category3,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 4 is not total reward and also greater than 0-->
              <xsl:if test="$Category4 &gt; 0 and ($Category4Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas4" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas4");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category4Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category4Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category4,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 5 is not total reward and also greater than 0-->
              <xsl:if test="$Category5 &gt; 0 and ($Category5Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas5" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas5");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category5Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category5Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category5,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 6 is not total reward and also greater than 0-->
              <xsl:if test="$Category6 &gt; 0 and ($Category6Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas6" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas6");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category6Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category6Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category6,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 6 is not total reward and also greater than 0-->
              <xsl:if test="$Category7 &gt; 0 and ($Category7Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas7" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas7");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category7Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category7Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category7,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 8 is not total reward and also greater than 0-->
              <xsl:if test="$Category8 &gt; 0 and ($Category8Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas8" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas8");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    
                      <b>
                        <xsl:value-of select="$Category8Title"/>
                      </b>
                    
                    <p>
                      <xsl:value-of select="$Category8Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                      <xsl:value-of select="concat($curSymbol,format-number($Category8,'###,###'))"/>
                    </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 9 is not total reward and also greater than 0-->
              <xsl:if test="$Category9 &gt; 0 and ($Category8Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas9" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas9");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    
                      <b>
                        <xsl:value-of select="$Category9Title"/>
                      </b>
                    
                    <p>
                      <xsl:value-of select="$Category9Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                    <b>
                      <xsl:value-of select="concat($curSymbol,format-number($Category9,'###,###'))"/>
                    </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 10 is not total reward and also greater than 0-->
              <xsl:if test="$Category10 &gt; 0 and ($Category8Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas10" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas10");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category10Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category10Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category10,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 11 is not total reward and also greater than 0-->
              <xsl:if test="$Category11 &gt; 0 and ($Category11Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas11" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas11");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category11Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category11Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category11,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 12 is not total reward and also greater than 0-->
              <xsl:if test="$Category12 &gt; 0 and ($Category12Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas12" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas12");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category12Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category12Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category12,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 13 is not total reward and also greater than 0-->
              <xsl:if test="$Category13 &gt; 0 and ($Category13Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas13" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas13");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category13Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category13Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category13,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 14 is not total reward and also greater than 0-->
              <xsl:if test="$Category14 &gt; 0 and ($Category14Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas14" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas14");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category14Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category14Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category14,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!--This section to be displayed if category 15 is not total reward and also greater than 0-->
              <xsl:if test="$Category15 &gt; 0 and ($Category15Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas15" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas15");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category15Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category15Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category15,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <!--This section to be displayed if category 16 is not total reward and also greater than 0-->
              <xsl:if test="$Category16 &gt; 0 and ($Category16Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas16" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas16");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category16Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category16Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category16,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category17 &gt; 0 and ($Category17Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas17" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas17");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category17Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category17Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category17,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category18 &gt; 0 and ($Category18Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas18" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas18");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category18Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category18Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category18,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category19 &gt; 0 and ($Category19Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas19" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas19");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category19Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category19Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category19,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category20 &gt; 0 and ($Category20Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas20" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas20");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category20Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category20Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category20,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category21 &gt; 0 and ($Category21Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas21" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas21");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category21Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category21Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category21,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              
                
              <xsl:if test="$Category22 &gt; 0 and ($Category22Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas22" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas22");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category22Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category22Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category22,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              
              <xsl:if test="$Category23 &gt; 0 and ($Category23Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas23" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas23");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category23Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category23Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category23,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category24 &gt; 0 and ($Category24Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas24" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas24");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category24Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category24Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category24,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
            
              <xsl:if test="$Category25 &gt; 0 and ($Category25Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas25" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas25");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category25Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category25Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category25,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <xsl:if test="$Category26 &gt; 0 and ($Category26Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas26" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas26");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category26Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category26Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category26,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
                      
              
              <xsl:if test="$Category27 &gt; 0 and ($Category27Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas27" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas27");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category27Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category27Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category27,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
                      
              <xsl:if test="$Category28 &gt; 0 and ($Category28Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas28" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas28");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category28Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category28Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category28,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
                      
              <xsl:if test="$Category29 &gt; 0 and ($Category29Title != 'TOTAL REWARD VALUE')" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas29" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas29");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$Category29Title"/>
                    </b>
                    <p>
                      <xsl:value-of select="$Category29Description"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: middle; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        <xsl:value-of select="concat($curSymbol,format-number($Category29,'###,###'))"/>
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
                
              <!-- This section to be displayed if there is a NotUsedCategoryTitle1 -->
              <xsl:if test="$NotUsedCategoryTitle1 != 'NA'" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvasNU1" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvasNU1");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = "#000000";
                      ctx.fillRect(5,5,30, 30);
                      
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$NotUsedCategoryTitle1"/>
                    </b>
                    <p>
                      <xsl:value-of select="$NotUsedCategoryDescription1"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        NA
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <!-- This section to be displayed if there is a NotUsedCategoryTitle2 -->
              <xsl:if test="$NotUsedCategoryTitle2 != $NotUsedCategoryTitle1" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvasNU2" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvasNU2");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = "#000000";
                      ctx.fillRect(5,5,30, 30);
                      
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$NotUsedCategoryTitle2"/>
                    </b>
                    <p>
                      <xsl:value-of select="$NotUsedCategoryDescription2"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        NA
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <!-- This section to be displayed if there is a NotUsedCategoryTitle3 -->
              <xsl:if test="$NotUsedCategoryTitle3 != $NotUsedCategoryTitle2" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvasNU3" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvasNU3");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = "#000000";
                      ctx.fillRect(5,5,30, 30);
                      
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$NotUsedCategoryTitle3"/>
                    </b>
                    <p>
                      <xsl:value-of select="$NotUsedCategoryDescription3"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        NA
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <!-- This section to be displayed if there is a NotUsedCategoryTitle4 -->
              <xsl:if test="$NotUsedCategoryTitle4 != $NotUsedCategoryTitle3" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvasNU4" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvasNU4");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = "#000000";
                      ctx.fillRect(5,5,30, 30);
                      
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$NotUsedCategoryTitle4"/>
                    </b>
                    <p>
                      <xsl:value-of select="$NotUsedCategoryDescription4"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        NA
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              
              <!-- This section to be displayed if there is a NotUsedCategoryTitle5 -->
              <xsl:if test="$NotUsedCategoryTitle5 != $NotUsedCategoryTitle5" >
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvasNU5" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvasNU5");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = "#000000";
                      ctx.fillRect(5,5,30, 30);
                      
                    </script>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    <b>
                      <xsl:value-of select="$NotUsedCategoryTitle5"/>
                    </b>
                    <p>
                      <xsl:value-of select="$NotUsedCategoryDescription5"/>
                    </p>
                  </td>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                    <span style="display: block; text-align: center; color:#009fdb">
                      <b>
                        NA
                      </b>
                    </span>
                  </td>
                </tr>
              </xsl:if>

              <!-- Test Code For Preview Only- Remove when final-->
              <!--
                <tr>
                  <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                    <canvas id="myCanvas00" width="40" height="40" >
                      &#11036;
                    </canvas>
                    <script>
                      var c = document.getElementById("myCanvas00");
                      var ctx = c.getContext("2d");
                      ctx.fillStyle = bgcolorcodes[i];
                      ctx.fillRect(5,5,30, 30);
                      if (i == bgcolorcodes.length) {
                      i=0;}
                      else {
                      i = i+1; }
                    </script>
                  </td>
                  <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                    Test Content 2
                  </td>
                  <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                   <span style="display: block; text-align: center; color:#009fdb"> Amount Test 2 </span>
                  </td>
                </tr>
               
              <tr>
                <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                  <canvas id="myCanvas000" width="40" height="40" >
                    &#11036;
                  </canvas>
                  <script>
                    var c = document.getElementById("myCanvas000");
                    var ctx = c.getContext("2d");
                    ctx.fillStyle = bgcolorcodes[i];
                    ctx.fillRect(5,5,30, 30);
                    if (i == bgcolorcodes.length) {
                    i=0;}
                    else {
                    i = i+1; }
                  </script>
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                  Test Content 2
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                  Amount Test 2
                </td>
              </tr>


              <tr>
                <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                  <canvas id="myCanvas01" width="40" height="40" >
                    &#11036;
                  </canvas>
                  <script>
                    var c = document.getElementById("myCanvas01");
                    var ctx = c.getContext("2d");
                    ctx.fillStyle = bgcolorcodes[i];
                    ctx.fillRect(5,5,30, 30);
                    if (i == bgcolorcodes.length) {
                    i=0;}
                    else {
                    i = i+1; }
                  </script>
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                  Test Content 2
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                  Amount Test 2
                </td>
              </tr>

              <tr>
                <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                  <canvas id="myCanvas02" width="40" height="40" >
                    &#11036;
                  </canvas>
                  <script>
                    var c = document.getElementById("myCanvas02");
                    var ctx = c.getContext("2d");
                    ctx.fillStyle = bgcolorcodes[i];
                    ctx.fillRect(5,5,30, 30);
                    if (i == bgcolorcodes.length) {
                    i=0;}
                    else {
                    i = i+1; }
                  </script>
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                  Test Content 2
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                  Amount Test 2
                </td>
              </tr>

              <tr>
                <td style="vertical-align:middle; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="6%">
                  <canvas id="myCanvas03" width="40" height="40" >
                    &#11036;
                  </canvas>
                  <script>
                    var c = document.getElementById("myCanvas03");
                    var ctx = c.getContext("2d");
                    ctx.fillStyle = bgcolorcodes[i];
                    ctx.fillRect(5,5,30, 30);
                    if (i == bgcolorcodes.length) {
                    i=0;}
                    else {
                    i = i+1; }
                  </script>
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="74%">
                  Test Content 2
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                  Amount Test 2
                </td>
              </tr>
              -->
            </table>
            <br> </br>
            <!--Final Total Reward Dsiplay Section-->
            <table style="vertical-align:middle; border-collapse: collapse; background: #009FDB; text-align: left; padding: 10px; border: 1px solid black; font-size:12px" width="100%">

              <tr>
                
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="80%">
                  <b>                       TOTAL REWARD VALUE</b>
                </td>
                <td style="vertical-align:top; border-collapse: collapse; text-align: left; padding: 10px; border: 1px solid black;" width="20%">
                  <!--
                    <xsl:if test="$Category15Title = 'TOTAL REWARD VALUE'" >
                      <b> <xsl:value-of select="$Category15"/>
                      </b>
                    </xsl:if>
                    -->
                  <span style="display: block; text-align: center; ">
                    <b>
                      <xsl:value-of select="$FinalAmount"/>
                    </b>
                  </span>
                </td>
              </tr>
            </table>

            <br></br>
            <br></br>
           
            
          </div>

          
        </div>
      </body>
    </html>
    
  </xsl:template>
 
</xsl:stylesheet>