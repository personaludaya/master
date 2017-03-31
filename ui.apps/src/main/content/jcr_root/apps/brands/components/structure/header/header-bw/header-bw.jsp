<%@include file="/apps/brands/global/global.jsp" %>
<%
String loaderPath = svgIconPath + "#icon-loading";
String iconUpPath = svgIconPath + "#icon-arrow-up";
String iconDownPath = svgIconPath + "#icon-arrow-down";
String iconClosePath = svgIconPath + "#icon-close";

//Site Paths
String customerSvcPath = WCMUtil.getURL(pageProperties.getInherited("custsvc-path", ""), isAuthor);
String storeLocationPath = WCMUtil.getURL(pageProperties.getInherited("store-location-path", ""), isAuthor);
String ourProductsPath = WCMUtil.getURL(pageProperties.getInherited("products-path", ""), isAuthor);
String faqPath = WCMUtil.getURL(pageProperties.getInherited("faq-path", ""), isAuthor);
String beMagPath = WCMUtil.getURL(pageProperties.getInherited("be-magazine-path", ""), isAuthor);
String ecStorePromotionPath = WCMUtil.getURL(pageProperties.getInherited("ecstore-promotions-path", ""), isAuthor);
%>
<!-- header component start here-->
<div class="header" id="header">
	<c:set var="varSiteCountry" value="<%=site_name %>"/>
	<c:set var="varSiteLangCode" value="<%= site_language %>"/>
  	<c:set var="varChatbotLoader" value="<%= loaderPath %>"/>
  	
  	<c:set var="varCustSvcPath" value="<%= customerSvcPath %>"/>
  	<c:set var="varStoreLocPath" value="<%= storeLocationPath %>"/>
  	<c:set var="varOurPdtsPath" value="<%= ourProductsPath %>"/>
  	<c:set var="varFaqPath" value="<%= faqPath %>"/>
  	<c:set var="varBeMagPath" value="<%= beMagPath %>"/>
  	<c:set var="varEcstorePromotionsPath" value="<%= ecStorePromotionPath %>"/>

  	<c:set var="varIconUpPath" value="<%= iconUpPath %>"/>
  	<c:set var="varIconDownPath" value="<%= iconDownPath %>"/>
  	<c:set var="varIconClosePath" value="<%= iconClosePath %>"/>
  	
  <input id="siteCountry" type="hidden" name="site-country" value="${varSiteCountry }"/>
  <input id="siteLangCode" type="hidden" name="site-lang-code" value="${varSiteLangCode }"/>
  <input id="loaderPath" type="hidden" name="chatbot-loader" value="${varChatbotLoader }"/>

  <input id="iconArrowUpPath" type="hidden" name="icon-arrow-up-path" value="${varIconUpPath }"/>
  <input id="iconArrowDownPath" type="hidden" name="icon-arrow-down-path" value="${varIconDownPath }"/>
  <input id="iconClosePath" type="hidden" name="icon-close-path" value="${varIconClosePath }"/>
  
    <input id="customerSvcPath" type="hidden" value="${varCustSvcPath }"/>
    <input id="storeLocationPath" type="hidden" value="${varStoreLocPath }"/>
    <input id="ourProductsPath" type="hidden" value="${varOurPdtsPath }"/>
    <input id="faqPath" type="hidden" value="${varFaqPath }"/>
    <input id="beMagPath" type="hidden" value="${varBeMagPath }"/>
 	<input id="ecstorePromotionsPath" type="hidden" value="${varEcstorePromotionsPath }"/> 
  
  <div class="header-wrapper">
	<cq:include path="top-nav-bw" resourceType="brands/components/structure/header/top-nav-bw"/>
    <cq:include path="search-bw" resourceType="brands/components/structure/header/search-bw"/>
  </div>
</div>
<!-- header component end here-->