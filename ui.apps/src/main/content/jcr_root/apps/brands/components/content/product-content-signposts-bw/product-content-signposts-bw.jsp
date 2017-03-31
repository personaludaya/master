<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
String contentSignpostPath = properties.get("content-signpost-path", null);
String[] prdtSignpostPathsArr = properties.get("prdt-signpost-paths", String[].class);
boolean showCompare = properties.get("show-compare-checkbox", "").equals("true");

String contentSignpostBuyNowLabel = I18nUtil.getLabel("buynow", currentPage, slingRequest, null);
String componentName = component.getProperties().get("jcr:title", "");
%>

<c:set var="varPrdtSignpostPathsArr" value="<%= prdtSignpostPathsArr  %>"/>
<c:set var="varContentSignpostPath" value="<%= contentSignpostPath  %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varContentSignpostBuyNowLabel" value="<%=contentSignpostBuyNowLabel%>" />
<c:set var="varComponentName" value="<%=componentName%>" />
<c:set var="varShowCompare" value="<%= showCompare %>"/>

<div class="product-info-similar">
	<div class="container-fluid">
		<div class="row">
			
			<c:if test="${fn:length(varPrdtSignpostPathsArr) > 0}">

			<%
				for (int i = 0; i < prdtSignpostPathsArr.length; i++) {
					ProductController productController = new ProductController();
					Page prdSignpostPage = pageManager.getPage(prdtSignpostPathsArr[i]);
					Product product = new Product();
					product = productController.getProuctPageProperties(prdSignpostPage, isAuthor, slingRequest);
					
					Map<String, String> prdtLifeStageMapTags = product.getPrdLifeStageMap();
					String prdtPath = WCMUtil.getURL(prdSignpostPage.getPath(), isAuthor);
					
					String prdtCatgoryTagID = "";
					for (Map.Entry<String, String> entry : product.getPrdCategoryMap().entrySet() ) {
					    prdtCatgoryTagID = WCMUtil.getTagKeyByTags(entry.getKey());
					}
			%>
					
			<c:set var="varPrdtUniqueName" value="<%= prdSignpostPage.getName() %>" />
			<c:set var="varPrdtContentSignpostTitle" value="<%= product.getPrdPageTitle() %>" />
			<c:set var="varPrdtContentSignpostImgPath" value="<%= product.getPrdImgPath() %>" />
			<c:set var="varPrdtContentSignpostImgAltText" value="<%= product.getPrdImgAltText() %>" />
			<c:set var="varContentSignpostSpecialPriceLabel" value="<%= product.getPrdSpecialPriceTitle() %>" />
			<c:set var="varPrdtContentSignpostSpecialPrice" value="<%= product.getPrdSpecialPrice() %>" />
			<c:set var="varPrdtContentSignpostPriceCurrency" value="<%= product.getPrdPriceCurrency() %>" />
			<c:set var="varContentSignpostRetailPriceLabel" value="<%= product.getPrdRetailPriceTitle() %>" />
			<c:set var="varPrdtContentSignpostRetailPrice" value="<%= product.getPrdRetailPrice() %>" />
			<c:set var="varContentSignpostECommerceUrl" value="<%= product.getPrdEcommerceUrl() %>"/>
			<c:set var="varContentSignpostHidePrdtPrice" value="<%= product.isPrdHideProductPrice() %>"/>
			<c:set var="varPrdtPath" value="<%= prdtPath %>"/>
			<c:set var="varPrdtID" value="<%= product.getPrdId() %>"/>
			<c:set var="varPrdtEcCatID" value="<%= product.getPrdEcommerceCatId() %>"/>
			<c:set var="varPrdtCatTagID" value="<%= prdtCatgoryTagID %>"/>			
			
				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
					<!-- product info overview start here-->
					<div class="product-info-overview">
					<a href="${varPrdtPath}">
						<img class="img-responsive" src="${varPrdtContentSignpostImgPath}" alt="${varPrdtContentSignpostImgAltText}" title="${varPrdtContentSignpostImgAltText}" data-rjs="2">
						
						
							<h4 class="text-left">${varPrdtContentSignpostTitle}</h4>
						</a>
						
						<c:if test="${varShowCompare}">
						<div class="checkbox checkbox-primary">
                          <input type="checkbox" data-analytics='{"event":{"eventInfo":{"eventType":"product_selectcomparison","eventName":"name-of-the-product","eventAction":"select comparison"}}}' data-product-unique-id="${varPrdtUniqueName}">
                          <label>Compare</label>
                        </div>
                        </c:if>
						
						<div class="product-info-overview-detail">
							
							<ul class="product-benefits">
							
								<!-- start lift stage tag looping -->
							    <%
	                            	for (Map.Entry<String, String> entry : prdtLifeStageMapTags.entrySet() ) {
	                            		String prdtLifeStageKey = entry.getKey();
	                            		String[] prdtLifeStageKeys = prdtLifeStageKey.split("/");
	                            		prdtLifeStageKey = prdtLifeStageKeys[prdtLifeStageKeys.length-1];
	                            %>
	                            
	                            <c:set var="varPrdtLifeStageKey" value="<%= prdtLifeStageKey %>"/>
                            	<c:set var="varPrdtLifeStageValue" value="<%= entry.getValue() %>"/>
                            	<c:set var="varPrdtContentSignpostSvgIcon" value="<%= WCMUtil.getProductStageIcon(prdtLifeStageKey) %>"/>
                            	
								<li>
		                          <svg class="brands-icon pull-left link-icon-small">
		                            <use href="${varSvgIconPath}#${varPrdtContentSignpostSvgIcon}" xlink:href="${varSvgIconPath}#${varPrdtContentSignpostSvgIcon}"></use>
		                          </svg>
		                          ${varPrdtLifeStageValue}
		                        </li>
		                        <% } %>
		                        <!-- end lift stage tag looping -->                  
							</ul>
												
							<ul class="product-info-detail">
							<c:if test="${varContentSignpostHidePrdtPrice == 'false'}">
								<li>
                                  <p class="price">${varContentSignpostSpecialPriceLabel}<span class="currency">${varPrdtContentSignpostPriceCurrency}</span><span class="amount">${varPrdtContentSignpostSpecialPrice}</span></p>
                                  <p>${varContentSignpostRetailPriceLabel}
                                    <del>${varPrdtContentSignpostPriceCurrency}${varPrdtContentSignpostRetailPrice}</del>
                                  </p>
                                </li>
                               </c:if>
                                <li><a href="${varContentSignpostECommerceUrl}" target="_blank" class="btn btn-action btn-lg" 
                                        data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varComponentName}","eventAction":"buynow","eventURL":"${varContentSignpostECommerceUrl}"}}, "product":{"productInfo":{"productName":"${varPrdtUniqueName}","productID":"${varPrdtID}"},"category":{"primaryCategory":"${varPrdtCatTagID}","primaryCategoryID":"${varPrdtEcCatID}"}} }'>${varContentSignpostBuyNowLabel}</a></li>
							</ul>
							
							
						</div>
					</div>
					<!-- product info overview end here-->
				</div>
		
			<%
				}
			%>
		
			</c:if>
			
			<!-- start content signpost -->
			<c:if test="${varContentSignpostPath != null}">
			
				<%
					Page contentSignpostPage = pageManager.getPage(contentSignpostPath);
					Node contentSignpostNode = WCMUtil.getNodePropertyValueByPage(contentSignpostPage, "signpost_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(contentSignpostPage, "signpost_admin_bw") : currentNode;
					String signpostTitle = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-title_t");
					String signpostCopy = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-copy_t");
					String signpostIconStyle = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-icon-style");
					
					String contSignBtn = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-text");
					String contSignBtnText = I18nUtil.getLabel(contSignBtn, contentSignpostPage, slingRequest, null);
					
					String contSignCta = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-text");
					String contSignCtaText = I18nUtil.getLabel(contSignCta, contentSignpostPage, slingRequest, null);
					
					String signpostBtnPath = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-path");
					signpostBtnPath = WCMUtil.getURL(signpostBtnPath, isAuthor);
					
					String contSignCtaPath = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-path");
					contSignCtaPath = WCMUtil.getURL(contSignCtaPath, isAuthor);
					
					String contSignCtaStyle = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-style");
					String contSignCtaIcon = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-icon");
					
					boolean signpostBtnOpenNewWin = false;
					signpostBtnOpenNewWin = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-open-new-win").equals("true");
		        	String signPostOpenInNewWindowString = "";
	
	        	 	if (signpostBtnOpenNewWin){
	        	 		signPostOpenInNewWindowString = " target='_blank'";
	        		}
	        	 	
	        	 	boolean contSignCtaOpenNewWin = false;
	        	 	contSignCtaOpenNewWin = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-open-new-win").equals("true");
		        	String contSignCtaOpenInNewWindowString = "";
	
	        	 	if (contSignCtaOpenNewWin){
	        	 		contSignCtaOpenInNewWindowString = " target='_blank'";
	        		}
					
				%>
				
				<c:set var="varSignpostTitle" value="<%= signpostTitle %>"/>
				<c:set var="varSignpostCopy" value="<%= signpostCopy %>"/>
				<c:set var="varSignpostCopyBtnText" value="<%= contSignBtnText %>"/>
				<c:set var="varContSignCta" value="<%= contSignCta %>"/>
				<c:set var="varContSignBtn" value="<%= contSignBtn %>"/>
				
				<c:set var="varSignpostBtnPath" value="<%=signpostBtnPath%>" />
				<c:set var="varSignpostIconStyle" value="<%=signpostIconStyle%>" />
				<c:set var="varSignPostOpenInNewWindowString" value="<%=signPostOpenInNewWindowString%>" />
				
				<c:set var="varContSignCtaText" value="<%= contSignCtaText %>"/>
				<c:set var="varContSignCtaPath" value="<%= contSignCtaPath %>"/>
				<c:set var="varContSignCtaStyle" value="<%= contSignCtaStyle %>"/>
				<c:set var="varContSignCtaIcon" value="<%= contSignCtaIcon %>"/>
				<c:set var="varContSignCtaOpenInNewWindowString" value="<%= contSignCtaOpenInNewWindowString %>"/>
						
				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="section-container ads-box free-home-delivery">
                        <div class="background-container gradient-background">
	                        <div class="ads-content">
	                            <svg class="brands-icon icon-white icon-free-home-delivery icon-center">
	                                <use href="${varSvgIconPath}#${varSignpostIconStyle}" xlink:href="${varSvgIconPath}#${varSignpostIconStyle}"></use>
	                            </svg>
	                            <div class="content">
	                                <h3 class="${varContSignCtaStyle}">${varSignpostTitle}</h3>
	                                <p>${varSignpostCopy}</p>
	                                <a href="${varSignpostBtnPath}" ${varSignPostOpenInNewWindowString} class="btn btn-action" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varComponentName}","eventAction":"${varContSignBtn}","eventURL":"${varSignpostBtnPath}"}}, "product":{"productInfo":{"productName":"","productID":""},"category":{"primaryCategory":"","primaryCategoryID":""}} }'>${varSignpostCopyBtnText}</a>
	                                <div class="view-all-wrapper">
	                                    <a href="${varContSignCtaPath}" ${varContSignCtaOpenInNewWindowString} class="view-all" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varComponentName}","eventAction":"${varContSignCta}","eventURL":"${varContSignCtaPath}"}}, "product":{"productInfo":{"productName":"","productID":""},"category":{"primaryCategory":"","primaryCategoryID":""}} }'>${varContSignCtaText}
	                                        <svg class="brands-icon icon-white link-icon-small">
	                                            <use href="${varSvgIconPath}#${varContSignCtaIcon}" xlink:href="${varSvgIconPath}#${varContSignCtaIcon}"></use>
	                                        </svg>
	                                    </a>
	                                </div>
	                            </div>                          
	                        </div> 
                        </div>
                    </div>
                </div>
			</c:if>
			<!-- end content signpost -->		
		</div>
	</div>
</div>



