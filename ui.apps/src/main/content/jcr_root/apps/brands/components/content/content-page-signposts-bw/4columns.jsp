<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
String[] contentPageSignpostPathsArr = properties.get("contentpage-signpost-paths", String[].class);
String adminContentSignpostPath = properties.get("content-signpost-path", null);
%>

<c:set var="varContentPageSignpostPathsArr" value="<%= contentPageSignpostPathsArr  %>"/>
<c:set var="varAdminContentSignpostPath" value="<%= adminContentSignpostPath  %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>

<c:if test="${fn:length(varContentPageSignpostPathsArr) > 0}">
	<div class="generic-4c-component primary-color component-style1">
		<div class="container-fluid">
			 <div class="row">
			 	<!-- start looping -->
			 	
			 	<%
			 	  String contentSignpostPath = "";
			 	  Basic basic = new Basic();
				  General general = new General();
				  for (int i = 0; i < contentPageSignpostPathsArr.length ; i++) {
					  if(StringUtils.isNotEmpty(contentPageSignpostPathsArr[i])){
		 				  Page contentPageSignpostPage = pageManager.getPage(contentPageSignpostPathsArr[i]);
						  BasicController basicController = new BasicController();
						  
						  basic = basicController.getBasicPageProperties(contentPageSignpostPage, isAuthor, slingRequest);
					  
						  GeneralController generalController = new GeneralController();
						  general = generalController.getGeneralPageProperties(contentPageSignpostPage, isAuthor, slingRequest);
						  
						  contentSignpostPath = WCMUtil.getURL(contentPageSignpostPage.getPath(), isAuthor);
					}
			 	%>
			 	
			 	 <c:set var="varContentSignpostDesc" value="<%= basic.getBasicOverview() %>"/>
	             <c:set var="varContentSignpostTitle" value="<%= basic.getBasicPageTitle() %>"/>
	             <c:set var="varContentSignpostImg" value="<%= general.getGenPageImgPath() %>"/>
	             <c:set var="varContentSignpostImgAltText" value="<%= general.getGenPageImgAltText() %>"/>
	             <c:set var="varContentSignpostPath" value="<%= contentSignpostPath %>"/>
		                
			 	 <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
			 	 	<div class="article primary-color component-style1 text-left ">
			 	 	   <a href="${varContentSignpostPath}"><img class="full-width" src="${varContentSignpostImg}" alt="${varContentSignpostImgAltText}" title="${varContentSignpostImgAltText}" data-rjs="2"></a>
			 	 	   <a href="${varContentSignpostPath}"><h4 class="text-left">${varContentSignpostTitle}</h4></a>
	                   <p>${varContentSignpostDesc}</p>
	                </div>
			 	 </div>
			 	 
			 	 <% } %>
			 	 <!-- end looping -->
			 	 
			 	 <!-- start content signpost -->
			<c:if test="${varAdminContentSignpostPath != null}">
			
				<%
					Page contentSignpostPage = pageManager.getPage(adminContentSignpostPath);
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
						
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
					<div class="section-container ads-box be-in-the-know">
				 		<div class="background-container gradient-background">
				 			<svg class="brands-icon icon-white icon-free-home-delivery icon-center">
                            	<use href="${varSvgIconPath}#${varSignpostIconStyle}" xlink:href="${varSvgIconPath}#${varSignpostIconStyle}"></use>
                            </svg>
                            <div class="content">
                            	<h2 class="${varContSignCtaStyle}">${varSignpostTitle}</h2>
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
			</c:if>
			<!-- end content signpost -->	
			 </div>
		</div>
	</div>
</c:if>