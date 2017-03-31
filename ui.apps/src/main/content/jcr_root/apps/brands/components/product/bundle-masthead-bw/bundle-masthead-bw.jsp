<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*" %>

<%
String bundleTagLine = properties.get("bundle-tagline_t", null); 
BundleController bundleController = new BundleController();
Bundle bundle = new Bundle();
bundle = bundleController.getBundlePageProperties(currentPage, isAuthor, slingRequest);

String bundlePageTitle = bundle.getBundlePageTitle();
String bundleRetailPrice = bundle.getBundleRetailPrice();
String[] bundlePrdtPathsArr = bundle.getBundlePrdtPathsArr();
String thisBundleConsistsOfLabel = I18nUtil.getLabel("thisbundleconsistsof", currentPage, slingRequest, null);
String bundlePriceCurrency = bundle.getBundlePriceCurrency();
String buyLabel = I18nUtil.getLabel("buy", currentPage, slingRequest, null);
String buyNowLabel = I18nUtil.getLabel("buynow", currentPage, slingRequest, null);
String bundleEcommerceUrl = bundle.getBundleEcommerceUrl();

/* for analytics */
String bundleMastheadComponentName = component.getProperties().get("jcr:title", "");

String bm_bundleCatTagId = "";
String bm_prdtId = pageProperties.get("prdt-id", "");
String bm_prdtEcCatId = pageProperties.get("prdt-ec-category-id", "");

Map<String, String> bm_BundleCategoryMap = WCMUtil.getTagMapList(currentPage, site_locale, "bundle-category");
for (Map.Entry<String, String> entry : bm_BundleCategoryMap.entrySet() ) {
	bm_bundleCatTagId = WCMUtil.getTagKeyByTags(entry.getKey());
}
%>

<c:set var="varBundleMastheadComponentName" value="<%= bundleMastheadComponentName  %>"/>
<c:set var="varBundleTagLine" value="<%= bundleTagLine  %>"/>
<c:set var="varBundlePageTitle" value="<%= bundlePageTitle  %>"/>
<c:set var="varBundleRetailPrice" value="<%= bundleRetailPrice  %>"/>
<c:set var="varThisBundleConsistsOfLabel" value="<%= thisBundleConsistsOfLabel  %>"/>
<c:set var="varBundlePrdtPathsArr" value="<%= bundlePrdtPathsArr  %>"/>
<c:set var="varBundlePriceCurrency" value="<%= bundlePriceCurrency  %>"/>
<c:set var="varBuyBundleLabel" value="<%= buyLabel %>"/>
<c:set var="varBundleEcommerceUrl" value="<%= bundleEcommerceUrl %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varBuyNowBundleLabel" value="<%= buyNowLabel %>"/>
<c:set var="varBundleName" value="<%= currentPage.getName() %>"/>
<c:set var="varBundleCatTagID" value="<%= bm_bundleCatTagId %>"/>
<c:set var="varPrdtID" value="<%= bm_prdtId %>"/>
<c:set var="varPrdtEcCatID" value="<%= bm_prdtEcCatId %>"/>


<h1 class="secondary-color">${varBundlePageTitle}</h1>
<div class="section-container bundles-details">
	 <article class="campaign-text">
       <p>${varBundleTagLine}</p>
     </article>
     
     <div class="bundles-wrapper">
     	<h3 class="secondary-color text-center">${varThisBundleConsistsOfLabel}</h3>
     	
     	<c:if test="${fn:length(varBundlePrdtPathsArr) > 0}">
     		<div class="container-fluid">
	     		<div class="row">
	     		<!-- Start Product Page Looping -->
	     		 <%
				  for (int i = 0; i < bundlePrdtPathsArr.length ; i++) {
					  Page bundlePrdtPage = pageManager.getPage(bundlePrdtPathsArr[i]);
					  ProductController productController = new ProductController();
					  Product product = new Product();
					  product = productController.getProuctPageProperties(bundlePrdtPage, isAuthor, slingRequest);
					  
					  Map<String, String> prdtLifeStageMapTags = product.getPrdLifeStageMap();
					  String bundlePrdtPagePath = WCMUtil.getURL(bundlePrdtPathsArr[i], isAuthor);
			 	 %>
			 	 
			 	 	<c:set var="varBundlePrdtPageTitle" value="<%= product.getPrdPageTitle() %>" />
			 	 	<c:set var="varBundlePrdtPagePath" value="<%= bundlePrdtPagePath %>" />
					<c:set var="varBundlePrdtImgPath" value="<%= product.getPrdImgPath() %>" />
					<c:set var="varBundlePrdtImgAltText" value="<%= product.getPrdImgAltText() %>" />
					<c:set var="varBundlePrdtSpecialPriceLabel" value="<%= product.getPrdSpecialPriceTitle() %>" />
					<c:set var="varBundlePrdtSpecialPrice" value="<%= product.getPrdSpecialPrice() %>" />
					<c:set var="varBundlePrdtPriceCurrency" value="<%= product.getPrdPriceCurrency() %>" />
					<c:set var="varBundlePrdtRetailPriceLabel" value="<%= product.getPrdRetailPriceTitle() %>" />
					<c:set var="varBundlePrdtRetailPrice" value="<%= product.getPrdRetailPrice() %>" />
					<c:set var="varBundlePrdtECommerceUrl" value="<%= product.getPrdEcommerceUrl() %>"/>
					<c:set var="varBundlePrdtHidePrdtPrice" value="<%= product.isPrdHideProductPrice() %>"/>
		
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
						<div class="product-info-overview">
							<a href="${varBundlePrdtPagePath}"><img class="img-responsive" src="${varBundlePrdtImgPath}" alt="${varBundlePrdtImgAltText}" title="${varBundlePrdtImgAltText}" data-rjs="2"></a>
							<a href="${varBundlePrdtPagePath}">
                            	<h4 class="text-left">${varBundlePrdtPageTitle}</h4>
                            </a>
						
						</div>
					</div>
					
			 	 <% } %>
	     		
	     		<!-- End Product Page looping -->
	     		</div>
     		</div>
     	</c:if>

     </div>
     
       <p class="price"><span class="currency">${varBundlePriceCurrency}</span><span class="amount">${varBundleRetailPrice}</span></p>
     <a href="${varBundleEcommerceUrl}" target="_blank" class="btn btn-action" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varBundleMastheadComponentName}","eventAction":"buy","eventURL":"${varBundleEcommerceUrl}"}}, "product":{"productInfo":{"productName":"${varBundleName}","productID":"${varPrdtID}"},"category":{"primaryCategory":"${varBundleCatTagID}","primaryCategoryID":"${varPrdtEcCatID}"}} }'>${varBuyBundleLabel}</a>
</div>





