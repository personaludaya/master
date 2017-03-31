<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %>

<%
String prdtBottleImgPath = WCMUtil.getPagePropertyValue(currentPage, "prdt-bottle-img-path");
String prdtRetailPrice = WCMUtil.getPagePropertyValue(currentPage, "prdt-retail-price");
String prdtSpecialPrice = WCMUtil.getPagePropertyValue(currentPage, "prdt-special-price");
String prdtRetailPriceTitle = WCMUtil.getPagePropertyValue(currentPage, "prdt-retail-price-title");
String prdtSpecialPriceTitle = WCMUtil.getPagePropertyValue(currentPage, "prdt-special-price-title");
String prdtPriceCurrency = WCMUtil.getPagePropertyValue(currentPage, "prdt-price-currency");
String buyNowLabel = I18nUtil.getLabel("buynow", currentPage, slingRequest, null);
String retailPriceLabel = I18nUtil.getLabel(prdtRetailPriceTitle, currentPage, slingRequest, null);
String specialPriceLabel = I18nUtil.getLabel(prdtSpecialPriceTitle, currentPage, slingRequest, null);
String eCommerceUrl = WCMUtil.getPagePropertyValue(currentPage, "prdt-ec-url");
eCommerceUrl = eCommerceUrl == null ? "" : WCMUtil.getURL(eCommerceUrl, isAuthor);  

String prdtBottleImgAltText = WCMUtil.getPagePropertyValue(currentPage, "prdt-bottle-img-alt_t");
prdtBottleImgAltText = StringUtils.isEmpty(prdtBottleImgAltText) ? currentPage.getPageTitle() : prdtBottleImgAltText;

/* for analytics */
String prdtBottleComponentName = component.getProperties().get("jcr:title", "");

if (StringUtils.isEmpty(eCommerceUrl)) {
    String buttonLoc = "body";
    eCommerceUrl = eCommerceUrl + "#pid=bw_by_"+ buttonLoc +"_" + prdtBottleComponentName;
}

String pbp_prdtCatTagId = "";
String pbp_prdtId = pageProperties.get("prdt-id", "");
String pbp_prdtEcCatId = pageProperties.get("prdt-ec-category-id", "");

Map<String, String> pbp_prdtCategoryMap = WCMUtil.getTagMapList(currentPage, site_locale, "prdt-category");
for (Map.Entry<String, String> entry : pbp_prdtCategoryMap.entrySet() ) {
	pbp_prdtCatTagId = WCMUtil.getTagKeyByTags(entry.getKey());
}
%>

<c:set var="varPrdtBottleImgPath" value="<%= prdtBottleImgPath %>"/>
<c:set var="varPrdtBottleImgAlt" value="<%= prdtBottleImgAltText %>"/>
<c:set var="varRetailPriceLabel" value="<%= retailPriceLabel %>"/>
<c:set var="varPrdtPriceCurrency" value="<%= prdtPriceCurrency %>"/>
<c:set var="varPrdtRetailPrice" value="<%= prdtRetailPrice %>"/>
<c:set var="varSpecialPriceLabel" value="<%= specialPriceLabel %>"/>
<c:set var="varPrdtSpecialPrice" value="<%= prdtSpecialPrice %>"/>
<c:set var="varBuyNowLabel" value="<%= buyNowLabel %>"/>
<c:set var="varECommerceUrl" value="<%= eCommerceUrl %>"/>
<c:set var="varPrdtBottleComponentName" value="<%= prdtBottleComponentName %>"/>
<c:set var="varPrdtName" value="<%= currentPage.getName() %>" />
<c:set var="varPrdtID" value="<%= pbp_prdtId %>"/>
<c:set var="varPrdtEcCatID" value="<%= pbp_prdtEcCatId %>"/>
<c:set var="varPrdtCatTagID" value="<%= pbp_prdtCatTagId %>"/>

<div class="section-content-wrapper">
	<div class="container-fluid">
		 <div class="row">
		 	<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
		 		<img class="img-responsive img-first" src="${varPrdtBottleImgPath}" alt="${varPrdtBottleImgAlt}" title="${varPrdtBottleImgAlt}" data-rjs="2">
		 	</div>
		 	<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
		 		<article class="campaign-text">
                </article>
                <ul class="product-info-detail">
                	<li>
                      <p class="price">${varRetailPriceLabel}<span class="currency">${varPrdtPriceCurrency}</span><span class="amount">${varPrdtRetailPrice}</span></p>
                      <p>${varSpecialPriceLabel}
                        <del>${varPrdtPriceCurrency}${varPrdtSpecialPrice}</del>
                      </p>
                    </li>
                    <li><a href="${varECommerceUrl}" target="_blank" class="btn btn-action btn-lg" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varPrdtBottleComponentName}","eventAction":"buynow","eventURL":"${varECommerceUrl}"}}, "product":{"productInfo":{"productName":"${varPrdtName}","productID":"${varPrdtID}"},"category":{"primaryCategory":"${varPrdtCatTagID}","primaryCategoryID":"${varPrdtEcCatID}"}} }'>${varBuyNowLabel}</a></li>
                </ul>
		 	</div>
		 </div>
	</div>
</div>
