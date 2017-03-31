<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %>

<%
String prdtImgPath = WCMUtil.getPagePropertyValue(currentPage, "prdt-img-path");
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

String prdtImgAltText = WCMUtil.getPagePropertyValue(currentPage, "prdt-img-alt_t");
prdtImgAltText = StringUtils.isEmpty(prdtImgAltText) ? currentPage.getPageTitle() : prdtImgAltText;

String hightLightTitle = properties.get("hightlight-title_t", "");

boolean hidePrdtPriceInfo = false;
hidePrdtPriceInfo = WCMUtil.getPagePropertyValue(currentPage, "hide-prdt-price").equals("true");

/* for analytics */
String prdtInfoPriceComponentName = component.getProperties().get("jcr:title", "");

if (StringUtils.isEmpty(eCommerceUrl)) {
    String buttonLoc = "body";
    eCommerceUrl = eCommerceUrl + "#pid=bw_by_"+ buttonLoc +"_" + prdtInfoPriceComponentName;
}

String pip_prdtCatTagId = "";
String pip_prdtId = pageProperties.get("prdt-id", "");
String pip_prdtEcCatId = pageProperties.get("prdt-ec-category-id", "");

Map<String, String> pip_prdtCategoryMap = WCMUtil.getTagMapList(currentPage, site_locale, "prdt-category");
for (Map.Entry<String, String> entry : pip_prdtCategoryMap.entrySet() ) {
    pip_prdtCatTagId = WCMUtil.getTagKeyByTags(entry.getKey());
}
%>

<c:set var="varPrdtImgPath" value="<%= prdtImgPath %>"/>
<c:set var="varPrdtPageTitle" value="<%= currentPage.getPageTitle() %>"/>
<c:set var="varPrdtImgAltText" value="<%= prdtImgAltText %>"/>
<c:set var="varRetailPriceLabel" value="<%= retailPriceLabel %>"/>
<c:set var="varPrdtPriceCurrency" value="<%= prdtPriceCurrency %>"/>
<c:set var="varPrdtRetailPrice" value="<%= prdtRetailPrice %>"/>
<c:set var="varSpecialPriceLabel" value="<%= specialPriceLabel %>"/>
<c:set var="varPrdtSpecialPrice" value="<%= prdtSpecialPrice %>"/>
<c:set var="varBuyNowLabel" value="<%= buyNowLabel %>"/>
<c:set var="varECommerceUrl" value="<%= eCommerceUrl %>"/>
<c:set var="varHightLightTitle" value="<%= hightLightTitle %>"/>
<c:set var="varPrdtInfoPriceComponentName" value="<%= prdtInfoPriceComponentName %>"/>
<c:set var="varHidePrdtPriceInfo" value="<%= hidePrdtPriceInfo  %>"/>
<c:set var="varPrdtName" value="<%= currentPage.getName() %>" />
<c:set var="varPrdtID" value="<%= pip_prdtId %>"/>
<c:set var="varPrdtEcCatID" value="<%= pip_prdtEcCatId %>"/>
<c:set var="varPrdtCatTagID" value="<%= pip_prdtCatTagId %>"/>

<div class="section-content-wrapper">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <img class="img-responsive img-first" src="${varPrdtImgPath}" alt="${varPrdtImgAltText}" title="${varPrdtImgAltText}" data-rjs="2">
            </div>
            
            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                <div class="content-wrapper">
                    <h2 class="text-left text-center-xs">${varHightLightTitle}</h2>
                    <p>${varPrdtPageTitle}</p>
                    <ul class="product-info-detail">
                        <c:if test="${varHidePrdtPriceInfo == 'false'}">
                            <li>
                                <p class="price">
                                    ${varSpecialPriceLabel}<span class="currency">${varPrdtPriceCurrency}</span><span
                                        class="amount">${varPrdtSpecialPrice}</span>
                                </p>
                                <p>
                                    ${varRetailPriceLabel}
                                    <del>${varPrdtPriceCurrency}${varPrdtRetailPrice}</del>
                                </p>
                            </li>
                        </c:if>
                        <li><a href="${varECommerceUrl}" target="_blank" class="btn btn-action btn-lg" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varPrdtInfoPriceComponentName}","eventAction":"buynow","eventURL":"${varECommerceUrl}"}}, "product":{"productInfo":{"productName":"${varPrdtUniqueName}","productID":"${varPrdtID}"},"category":{"primaryCategory":"${varPrdtCatTagID}","primaryCategoryID":"${varPrdtEcCatID}"}} }'>${varBuyNowLabel}</a></li>
                    </ul>
                </div>
            </div>
            
        </div>
    </div>
</div>