<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
String contentSignpostPath = properties.get("content-signpost-path", null);
String[] bundleSignpostPathsArr = properties.get("bundle-signpost-paths", String[].class);
String thisBundleIncludesLabel = I18nUtil.getLabel("thisbundleincludes", currentPage, slingRequest, null);

String bundleContentSignpostComponentName = component.getProperties().get("jcr:title", "");
%>

<c:set var="varContentSignpostPath" value="<%= contentSignpostPath  %>"/>
<c:set var="varBundleSignpostPathsArr" value="<%= bundleSignpostPathsArr  %>"/>
<c:set var="varThisBundleIncludesLabel" value="<%= thisBundleIncludesLabel  %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varBundleContentSignpostComponentName" value="<%= bundleContentSignpostComponentName  %>"/>
	
<div class="bundles-wrapper">
	<div class="container-fluid">
		<div class="row">
			<c:if test="${fn:length(varBundleSignpostPathsArr) > 0}">
				<!-- Start Bundle Signpost looping -->
				
				<%
				for (int i = 0; i < bundleSignpostPathsArr.length; i++) {
					Page bundlePage = pageManager.getPage(bundleSignpostPathsArr[i]);
					BundleController bundleController = new BundleController();
					Bundle bundle = new Bundle();
					bundle = bundleController.getBundlePageProperties(bundlePage, isAuthor, slingRequest);
					
					BasicController basicController = new BasicController();
					Basic basic = new Basic();
					basic = basicController.getBasicPageProperties(bundlePage, isAuthor, slingRequest);
					
					String[] bundlePrdtPathsArr = bundle.getBundlePrdtPathsArr();
					String bundlePath = WCMUtil.getURL(bundlePage.getPath(), isAuthor);
			    %>
				
				<c:set var="varBundlePageTitle" value="<%= bundle.getBundlePageTitle()  %>"/>
				<c:set var="varBundleBasicOverview" value="<%= basic.getBasicOverview()  %>"/>
				<c:set var="varBundleImagePath" value="<%= bundle.getBundleImgPath()  %>"/>
				<c:set var="varBundleImageAltText" value="<%= bundle.getBundleImgAltText()  %>"/>
				<c:set var="varBundlePrdtPathsArr" value="<%= bundlePrdtPathsArr  %>"/>
				<c:set var="varBundlePriceCurrency" value="<%= bundle.getBundlePriceCurrency()  %>"/>
				<c:set var="varBundleRetailPrice" value="<%= bundle.getBundleRetailPrice()  %>"/>
				<c:set var="varBundlePath" value="<%= bundlePath  %>"/>
				
				
				<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
					<div class="article">
					 <a href="${varBundlePath}">
						<img class="full-width" src="${varBundleImagePath}" alt="${varBundleImageAltText}" title="${varBundleImageAltText}" data-rjs="2">
                            <h4 class="text-left">${varBundlePageTitle}</h4>
                        </a>
                        <p>${varBundleBasicOverview}</p>
                      	<p>${varThisBundleIncludesLabel}</p>
                      	<ul>
                      		<c:if test="${fn:length(varBundlePrdtPathsArr) > 0}">
                      		<!-- Start Product Title looping -->
                      		
                      		<%
							  for (int j = 0; j < bundlePrdtPathsArr.length ; j++) {
								  Page bundlePrdtPage = pageManager.getPage(bundlePrdtPathsArr[j]);
								  ProductController productController = new ProductController();
								  Product product = new Product();
								  product = productController.getProuctPageProperties(bundlePrdtPage, isAuthor, slingRequest);
                      		%>
                      		
                      			<c:set var="varPrdtPageTitle" value="<%= product.getPrdPageTitle()  %>"/>
	                        	
	                        	<li>${varPrdtPageTitle}</li>
	                        
	                        <% } %>
	                        </c:if>
	                        
	                        <!-- End Product Title looping -->
                      </ul>
                      <p class="price"><span class="currency">${varBundlePriceCurrency}</span><span class="amount">${varBundleRetailPrice}</span></p>
					</div>
				</div>
					
				<% } %>
				<!--  End Bundle Signpost looping -->
			</c:if>
			
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
				
				<c:set var="varContSignBtn" value="<%= contSignBtn %>"/>
				<c:set var="varContSignCta" value="<%= contSignCta %>"/>
				<c:set var="varSignpostTitle" value="<%= signpostTitle %>"/>
				<c:set var="varSignpostCopy" value="<%= signpostCopy %>"/>
				<c:set var="varSignpostCopyBtnText" value="<%= contSignBtnText %>"/>
				<c:set var="varSignpostBtnPath" value="<%=signpostBtnPath%>" />
				<c:set var="varSignpostIconStyle" value="<%=signpostIconStyle%>" />
				<c:set var="varSignPostOpenInNewWindowString" value="<%=signPostOpenInNewWindowString%>" />
				
				<c:set var="varContSignCtaText" value="<%= contSignCtaText %>"/>
				<c:set var="varContSignCtaPath" value="<%= contSignCtaPath %>"/>
				<c:set var="varContSignCtaStyle" value="<%= contSignCtaStyle %>"/>
				<c:set var="varContSignCtaIcon" value="<%= contSignCtaIcon %>"/>
				<c:set var="varContSignCtaOpenInNewWindowString" value="<%= contSignCtaOpenInNewWindowString %>"/>
				
				<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				 <div class="section-container ads-box free-home-delivery">
				 	 <div class="background-container gradient-background">
				 		 <svg class="brands-icon icon-white icon-free-home-delivery icon-center">
                            <use href="${varSvgIconPath}#${varSignpostIconStyle}" xlink:href="${varSvgIconPath}#${varSignpostIconStyle}"></use>
                          </svg>
                          
                           <div class="content">
                                <h3 class="${varContSignCtaStyle}">${varSignpostTitle}</h3>
	                            <p>${varSignpostCopy}</p>
	                            <a href="${varSignpostBtnPath}" ${varSignPostOpenInNewWindowString} class="btn btn-action" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varBundleContentSignpostComponentName}","eventAction":${varContSignBtn},"eventURL":"${varSignpostBtnPath}"}}, "product":{"productInfo":{"productName":"","productID":""},"category":{"primaryCategory":"","primaryCategoryID":""}} }'>${varSignpostCopyBtnText}</a>
	                            
	                            <div class="view-all-wrapper">
	                            	<a href="${varContSignCtaPath}" ${varContSignCtaOpenInNewWindowString} class="view-all" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"${varAnalyticsBody}:${varBundleContentSignpostComponentName}","eventAction":"${varContSignCta}","eventURL":"${varContSignCtaPath}"}}, "product":{"productInfo":{"productName":"","productID":""},"category":{"primaryCategory":"","primaryCategoryID":""}} }'>${varContSignCtaText}
		                                <svg class="brands-icon icon-white link-icon-small">
		                                  <use href="${varSvgIconPath}#${varContSignCtaIcon}" xlink:href="${varSvgIconPath}#${varContSignCtaIcon}"></use>
		                                </svg>
	                                </a>
                                </div>
                          </div>
					 	</div>
					 </div>
				</div>
            </c:if>
		</div>
	</div>
</div>



