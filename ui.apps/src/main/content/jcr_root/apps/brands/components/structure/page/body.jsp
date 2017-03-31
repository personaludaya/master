<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String cssCtry = site_ctry;
String cssLang = site_lang;
String cssAuthor = "";

if (isAuthor) {
	cssAuthor = "cq-author";
}
String currentTemplate = currentPage.getProperties().get("cq:template", String.class);
String seoItemType = "";
if(currentTemplate!=null && currentTemplate.equals("/apps/brands/templates/product-page")){
	seoItemType = "http://schema.org/Product";
}
%>

<c:set var="varCssCtry" value="<%= cssCtry %>"/>
<c:set var="varCssLang" value="<%= cssLang %>"/>
<c:set var="varCssAuthor" value="<%= cssAuthor %>"/>
<c:set var="varSeoItemType" value="<%= seoItemType %>"/>

<body class="${varCssCtry} ${varCssLang} ${varCssAuthor}" itemscope="" itemtype="${varSeoItemType }">
<cq:include script="cookie-policy.jsp" />

<div class="brands-canvas">
  <cq:include script="node-swiper.jsp" />
  
  <%-- IMPT! header is included in canvas-bkgrd.jsp --%>
  <cq:include script="canvas-bkgrd.jsp" />
  
  <cq:include script="content.jsp" />
  
  <cq:include script="footer.jsp" />
</div>

<cq:include script="js-libs.jsp" />

<cq:include script="gtm.jsp" />

<cq:include script="analytics.jsp" />

<%-- custom body content --%>
<cq:include script="misc-body-content.jsp" />

<cq:include path="timing" resourceType="foundation/components/timing" />
</body>