<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>

<%
String cpgnBkgrdImgPath = properties.get("cpgn-carousel-background-img", "");
String cpgnBkgrdStyle = properties.get("cpgn-carousel-bkgrd-style", "");
String cpgnMainHeader = properties.get("cpgn-carousel-main-header_t", "");
String cpgnMainHeaderSize = properties.get("cpgn-carousel-main-header-size", "h2");
String cpgnSubHeader = properties.get("cpgn-carousel-sub-header_t", "");
String cpgnSubHeaderSize = properties.get("cpgn-carousel-sub-header-size", "h3");
String cpgnOverview = properties.get("cpgn-carousel-overview_t", "");
String cpgnCTAPath = properties.get("cpgn-carousel-cta-path", "");
String cpgnCTATxt = properties.get("cpgn-carousel-cta-text_t", "");
String cpgnCTAOpenNewWindow = properties.get("cpgn-carousel-cta-open-new-win", "false");
String cpgnPriImgPath = properties.get("cpgn-carousel-pri-img", "");
String cpgnPriImgAltTxt = properties.get("cpgn-carousel-pri-img-alt-txt_t", "");
String cpgnPriImgHeader = properties.get("cpgn-carousel-pri-header_t", "");
String cpgnPriHeaderSize = properties.get("cpgn-carousel-pri-header-size", "h5");
String cpgnPriImgDescr = properties.get("cpgn-carousel-pri-descr_t", "");
String cpgnSecImgPath = properties.get("cpgn-carousel-sec-img", "");
String cpgnSecImgAltTxt = properties.get("cpgn-carousel-sec-img-alt-txt_t", "");
String cpgnSecImgDescr = properties.get("cpgn-carousel-sec-descr_t", "");
%>

<c:set var="varBkgrdImgPath" value="<%= cpgnBkgrdImgPath %>"/>
<c:set var="varBkgrdStyle" value="<%= cpgnBkgrdStyle %>"/>
<c:set var="varMainHeader" value="<%= cpgnMainHeader  %>"/>
<c:set var="varMainHeaderSize" value="<%= cpgnMainHeaderSize  %>"/>
<c:set var="varSubHeader" value="<%= cpgnSubHeader  %>"/>
<c:set var="varSubHeaderSize" value="<%= cpgnSubHeaderSize  %>"/>
<c:set var="varOverview" value="<%= cpgnOverview  %>"/>
<c:set var="varCTAPath" value="<%= cpgnCTAPath  %>"/>
<c:set var="varCTATxt" value="<%= cpgnCTATxt %>"/>
<c:set var="varCTAOpenNewWindow" value="<%= cpgnCTAOpenNewWindow  %>"/>
<c:set var="varPriImgPath" value="<%= cpgnPriImgPath  %>"/>
<c:set var="varPriImgAltTxt" value="<%= cpgnPriImgAltTxt  %>"/>
<c:set var="varPriImgHeader" value="<%= cpgnPriImgHeader  %>"/>
<c:set var="varPriImgHeaderSize" value="<%= cpgnPriHeaderSize  %>"/>
<c:set var="varPriImgDescr" value="<%= cpgnPriImgDescr  %>"/>
<c:set var="varSecImgPath" value="<%= cpgnSecImgPath  %>"/>
<c:set var="varSecImgAltTxt" value="<%= cpgnSecImgAltTxt  %>"/>
<c:set var="varSecImgDescr" value="<%= cpgnSecImgDescr  %>"/>

<fieldset>
    <legend style="color:#fff">Campaign Background Settings</legend>
    Campaign Banner Background Image Path: <c:out value="${varBkgrdImgPath}"/>
    <br />
    Campaign Banner Background Style: <c:out value="${varBkgrdStyle}"/>
</fieldset>
<br />
<fieldset>
    <legend style="color:#fff">Campaign Banner Header, Copy and CTA Settings</legend>
    Campaign Banner Main Header: <c:out value="${varMainHeader}"/>
    <br />
    Campaign Banner Main Header Size: <c:out value="${varMainHeaderSize}"/>
    <br />
    Campaign Banner Sub-Header: <c:out value="${varSubHeader}"/>
    <br />
    Campaign Banner Sub-Header Size: <c:out value="${varSubHeaderSize}"/>
    <br />
    Campaign Banner Overview: <c:out value="${varOverview}"/>
    <br />
    Campaign Banner CTA Path: <c:out value="${varCTAPath}"/>
    <br />
    Campaign Banner CTA Text: <c:out value="${varCTATxt}"/>
    <br />
    Campaign Banner CTA Open in New Window?: <c:out value="${varCTAOpenNewWindow}"/>
</fieldset>
<br />
<fieldset>
    <legend style="color:#fff">Campaign Banner Primary Image Settings</legend>
    Campaign Banner Primary Image Path: <c:out value="${varPriImgPath}"/>
    <br />
    Campaign Banner Primary Image Alternate Text: <c:out value="${varPriImgAltTxt}"/>
    <br />
    Campaign Banner Primary Image Information Header: <c:out value="${varPriImgHeader}"/>
    <br />
    Campaign Banner Primary Image Information Header Size: <c:out value="${varPriImgHeaderSize}"/>
    <br />
    Campaign Banner Primary Image Information Description/Sub-text: <c:out value="${varPriImgDescr}"/>
</fieldset>
<br />
<fieldset>
    <legend style="color:#fff">Campaign Banner Secondary Image Settings</legend>
    Campaign Banner Secondary Image Path: <c:out value="${varSecImgPath}"/>
    <br />
    Campaign Banner Secondary Image Alternate Text: <c:out value="${varSecImgAltTxt}"/>
    <br />
    Campaign Banner Secondary Image Description/Sub-text: <c:out value="${varSecImgDescr}"/>
</fieldset>