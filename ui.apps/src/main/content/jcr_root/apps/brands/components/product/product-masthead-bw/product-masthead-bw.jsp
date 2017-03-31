<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,
                org.apache.commons.lang3.StringUtils" %>

<%
String prdtMastheadBottleImgPath = WCMUtil.getPagePropertyValue(currentPage, "prdt-bottle-img-path");
String prdtMastheadRetailPrice = WCMUtil.getPagePropertyValue(currentPage, "prdt-retail-price");
String prdtMastheadSpecialPrice = WCMUtil.getPagePropertyValue(currentPage, "prdt-special-price");
String prdtMastheadRetailPriceTitle = WCMUtil.getPagePropertyValue(currentPage, "prdt-retail-price-title");
String prdtMastheadSpecialPriceTitle = WCMUtil.getPagePropertyValue(currentPage, "prdt-special-price-title");
String prdtMastheadPriceCurrency = WCMUtil.getPagePropertyValue(currentPage, "prdt-price-currency");
String buyNowLabel = I18nUtil.getLabel("buynow", currentPage, slingRequest, null);
String mastheadRetailPriceLabel = I18nUtil.getLabel(prdtMastheadRetailPriceTitle, currentPage, slingRequest, null);
String mastheadSpecialPriceLabel = I18nUtil.getLabel(prdtMastheadSpecialPriceTitle, currentPage, slingRequest, null);
String eCommerceUrlMasthead = WCMUtil.getPagePropertyValue(currentPage, "prdt-ec-url");
eCommerceUrlMasthead = eCommerceUrlMasthead == null ? "" : WCMUtil.getURL(eCommerceUrlMasthead, isAuthor);

String prdtMastheadBottleImgAltText = WCMUtil.getPagePropertyValue(currentPage, "prdt-bottle-img-alt_t");
prdtMastheadBottleImgAltText = StringUtils.isEmpty(prdtMastheadBottleImgAltText) ? currentPage.getPageTitle() : prdtMastheadBottleImgAltText;

String prdtTagline = properties.get("prdt-tagline_t", "");
String thisProductIsForLabel = I18nUtil.getLabel("thisproductisfor", currentPage, slingRequest, null);

Locale locale = currentPage.getLanguage(true);
//List<String> prdtLiftStageTags = WCMUtil.getTagList(currentPage, locale, "prdt-life-stage");

Map<String, String> prdtLiftStageMapTags = WCMUtil.getTagMapList(currentPage, locale, "prdt-life-stage");

String compareOtherProductsLabel = I18nUtil.getLabel("compareotherproducts", currentPage, slingRequest, null);
String mastheadParentPagePath = currentPage.getParent().getPath();
mastheadParentPagePath = mastheadParentPagePath == null ? "" : WCMUtil.getURL(mastheadParentPagePath, isAuthor);  

String[] prdtBenefitArr = properties.get("prdt-benefits_t", String[].class);

String prdtDropletImgPath = pageProperties.get("prdt-droplet-img-path", "");
boolean hidePrdtPriceMasthead = false;
hidePrdtPriceMasthead = pageProperties.get("hide-prdt-price", "").equals("true");

/* for analytics */
String prdtMastheadComponentName = component.getProperties().get("jcr:title", "");

if (StringUtils.isEmpty(eCommerceUrlMasthead)) {
    String buttonLoc = "body";
    eCommerceUrlMasthead = eCommerceUrlMasthead + "#pid=bw_by_"+ buttonLoc +"_" + prdtMastheadComponentName;
}

String pm_prdtCatTagId = "";
String pm_prdtId = pageProperties.get("prdt-id", "");
String pm_prdtEcCatId = pageProperties.get("prdt-ec-category-id", "");

Map<String, String> pm_prdtCategoryMap = WCMUtil.getTagMapList(currentPage, site_locale, "prdt-category");
for (Map.Entry<String, String> entry : pm_prdtCategoryMap.entrySet() ) {
    pm_prdtCatTagId = WCMUtil.getTagKeyByTags(entry.getKey());
}
%>

<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varPrdtMastheadComponentName" value="<%= prdtMastheadComponentName  %>"/>
<c:set var="varPrdtMastheadBottleImgPath" value="<%= prdtMastheadBottleImgPath %>"/>
<c:set var="varPrdtMastheadPageTitle" value="<%= currentPage.getPageTitle() %>"/>
<c:set var="varMastheadRetailPriceLabel" value="<%= mastheadRetailPriceLabel %>"/>
<c:set var="varPrdtMastheadPriceCurrency" value="<%= prdtMastheadPriceCurrency %>"/>
<c:set var="varPrdtMastheadRetailPrice" value="<%= prdtMastheadRetailPrice %>"/>
<c:set var="varMastheadSpecialPriceLabel" value="<%= mastheadSpecialPriceLabel %>"/>
<c:set var="varPrdtMastheadSpecialPrice" value="<%= prdtMastheadSpecialPrice %>"/>
<c:set var="varBuyNowMastheadLabel" value="<%= buyNowLabel %>"/>
<c:set var="varECommerceUrlMasthead" value="<%= eCommerceUrlMasthead %>"/>
<c:set var="varPrdtTagLine" value="<%= prdtTagline %>"/>
<c:set var="varPrdtMastheadBottleImgAlt" value="<%= prdtMastheadBottleImgAltText %>"/>
<c:set var="varThisProductIsForLabel" value="<%= thisProductIsForLabel %>"/>
<c:set var="varCompareOtherProductsLabel" value="<%= compareOtherProductsLabel %>"/>
<c:set var="varMastheadParentPagePath" value="<%= mastheadParentPagePath  %>"/>
<c:set var="varPrdtBenefitArr" value="<%= prdtBenefitArr  %>"/>
<c:set var="varPrdtDropletImgPath" value="<%= prdtDropletImgPath  %>"/>
<c:set var="varHidePrdtPriceMasthead" value="<%= hidePrdtPriceMasthead  %>"/>
<c:set var="varPrdtName" value="<%= currentPage.getName() %>"/>
<c:set var="varPrdtCatTagID" value="<%= pm_prdtCatTagId %>"/>
<c:set var="varPrdtID" value="<%= pm_prdtId %>"/>
<c:set var="varPrdtEcCatID" value="<%= pm_prdtEcCatId %>"/>

<h1 itemprop="name">${varPrdtMastheadPageTitle}</h1>
<div class="container-fluid product-info">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<h4 class="product-tagline" itemprop="description">${varPrdtTagLine}</h4>
		</div>
		
		<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-xs">
			<!-- product-info-benefits molecule start here-->
			<div class="product-info-benefits">
				 <h4 class="title hide">${varThisProductIsForLabel}</h4>
				 <div class="product-info-benefits-wrapper">
				 	<ul class="benefits-item">
				 		
                            <!-- Start looping for the Brand Stage -->
                            <%
	                            //for (String prdtLiftStageTag : prdtLiftStageTags) {
	                            	for (Map.Entry<String, String> entry : prdtLiftStageMapTags.entrySet() ) {
	                            		String prdtLifeStageTagKey = entry.getKey();
	                            		String[] prdtLifeStageTagKeys = prdtLifeStageTagKey.split("/");
	                            		prdtLifeStageTagKey = prdtLifeStageTagKeys[prdtLifeStageTagKeys.length-1];
                            %>
                            	<c:set var="varPrdtLiftStageTagKey" value="<%= prdtLifeStageTagKey %>"/>
                            	<c:set var="varPrdtLiftStageTagValue" value="<%= entry.getValue() %>"/>
                            	<c:set var="varSvgIcon" value="<%= WCMUtil.getProductStageIcon(prdtLifeStageTagKey) %>"/>
                            	
                            	<c:set var="varSvgIconCss" value=""/>
                            	
                            	<c:if test="${varPrdtLiftStageTagKey == 'seniors'}">
                            		<c:set var="varSvgIconCss" value="icon-senior--product-benefits"/>
                            	</c:if>
                            	
	                            <li>
	                              <svg class="brands-icon">
	                                <use href="${varSvgIconPath}#${varSvgIcon}" xlink:href="${varSvgIconPath}#${varSvgIcon}"></use>
	                              </svg>
	                            
	                            <div class="benefit-name">${varPrdtLiftStageTagValue}</div>
		                        </li>
		                        
	                        <% } %>
                            <!-- End looping for the Brand Stage -->
				 	</ul>
				 	
				 	<c:if test="${fn:length(varPrdtBenefitArr) > 0}">
					 	 <ul class="benefits-info-item">
					 	 <%
		 					  for (int i = 0; i < prdtBenefitArr.length ; i++) {
					 	 %>
					 	 
					 	 <c:set var="varPrdtBenefit" value="<%= prdtBenefitArr[i]  %>"/>
	                        <li>${varPrdtBenefit}</li>
	                       
	                     <%  } %>
	                      </ul>
                    </c:if>
				 	
				 </div>
			</div>
			<!-- product-info-benefits molecule end here-->
		</div>
		
		<!-- start second column -->
		<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
			<div class="product-info-slide">
				<div class="product-info-image">
					<c:if test="${varPrdtDropletImgPath != ''}">
						<img class="product-background img-responsive" src="${varPrdtDropletImgPath}" alt="${varPrdtMastheadBottleImgAlt}" data-rjs="2">
					</c:if>
						<img class="product-image" src="${varPrdtMastheadBottleImgPath}" alt="${varPrdtMastheadBottleImgAlt}" data-rjs="2">
				</div>
			</div>
		</div>
		<!-- end second column -->

		<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-lg hidden-md hidden-sm">
			<!-- product-info-benefits molecule start here-->
			<div class="product-info-benefits">
				 <h4 class="title hide">${varThisProductIsForLabel}</h4>
				 <div class="product-info-benefits-wrapper">
				 	<ul class="benefits-item">
				 		
                            <!-- Start looping for the Brand Stage -->
                            <%
	                            //for (String prdtLiftStageTag : prdtLiftStageTags) {
	                            	for (Map.Entry<String, String> entry : prdtLiftStageMapTags.entrySet() ) {
	                            		String prdtLifeStageTagKey = entry.getKey();
	                            		String[] prdtLifeStageTagKeys = prdtLifeStageTagKey.split("/");
	                            		prdtLifeStageTagKey = prdtLifeStageTagKeys[prdtLifeStageTagKeys.length-1];
                            %>
                            	<c:set var="varPrdtLiftStageTagKey" value="<%= prdtLifeStageTagKey %>"/>
                            	<c:set var="varPrdtLiftStageTagValue" value="<%= entry.getValue() %>"/>
                            	<c:set var="varSvgIcon" value="<%= WCMUtil.getProductStageIcon(prdtLifeStageTagKey) %>"/>
                            	
                            	<c:set var="varSvgIconCss" value=""/>
                            	
                            	<c:if test="${varPrdtLiftStageTagKey == 'seniors'}">
                            		<c:set var="varSvgIconCss" value="icon-senior--product-benefits"/>
                            	</c:if>
                            	
	                            <li>
	                              <svg class="brands-icon">
	                                <use href="${varSvgIconPath}#${varSvgIcon}" xlink:href="${varSvgIconPath}#${varSvgIcon}"></use>
	                              </svg>
	                            
	                            <div class="benefit-name">${varPrdtLiftStageTagValue}</div>
		                        </li>
		                        
	                        <% } %>
                            <!-- End looping for the Brand Stage -->
				 	</ul>
				 	
				 	<c:if test="${fn:length(varPrdtBenefitArr) > 0}">
					 	 <ul class="benefits-info-item">
					 	 <%
		 					  for (int i = 0; i < prdtBenefitArr.length ; i++) {
					 	 %>
					 	 
					 	 <c:set var="varPrdtBenefit" value="<%= prdtBenefitArr[i]  %>"/>
	                        <li>${varPrdtBenefit}</li>
	                       
	                     <%  } %>
	                      </ul>
                    </c:if>
				 	
				 </div>
			</div>
			<!-- product-info-benefits molecule end here-->
		</div>


		<!-- start third column -->
		<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
			<ul class="product-info-detail">
				<c:if test="${varHidePrdtPriceMasthead == 'false'}">
					<li>
				  		<p class="price">
							${varMastheadSpecialPriceLabel}<span class="currency">${varPrdtMastheadPriceCurrency}</span><span
								class="amount">${varPrdtMastheadSpecialPrice}</span>
						</p>
						<p>
							${varMastheadRetailPriceLabel}
							<del>${varPrdtMastheadPriceCurrency}${varPrdtMastheadRetailPrice}</del>
						</p>
					</li>
				</c:if>
				<li>
				    <a href="${varECommerceUrlMasthead}" target="_blank" class="btn btn-action btn-lg" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varPrdtMastheadComponentName}","eventAction":"buynow", "eventURL": "${varECommerceUrlMasthead}"}}, "product":{"productInfo":{"productName":"${varPrdtName}","productID":"${varPrdtID}"},"category":{"primaryCategory":"${varPrdtCatTagID}","primaryCategoryID":"${varPrdtEcCatID}"}} }'>
				    ${varBuyNowMastheadLabel}</a></li>
				<li>
					<div class="view-all-wrapper text-center-xs">
						<a href="${varMastheadParentPagePath}" class="view-all btn-link">${varCompareOtherProductsLabel} <svg
								class="brands-icon link-icon-small">
                                              <use
									href="${varSvgIconPath}#icon-arrow-right"
									xlink:href="${varSvgIconPath}#icon-arrow-right"></use>
                                            </svg></a>
					</div>
				</li>
			</ul>
		</div>
		<!-- end third column -->

	</div>
</div>
 