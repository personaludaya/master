<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.day.cq.tagging.Tag,com.day.cq.tagging.TagManager" %><%
%>

<%
String[] prdtLifeStageTags = properties.get("prdt-life-stage-tags", String[].class);
Locale locale = currentPage.getLanguage(true);
TagManager tagManager = resourceResolver.adaptTo(TagManager.class);

String applyLabel = I18nUtil.getLabel("apply", currentPage, slingRequest, null);
String clearAllLabel = I18nUtil.getLabel("clearall", currentPage, slingRequest, null);

%>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varApplyLabel" value="<%= applyLabel  %>"/>
<c:set var="varClearAllLabel" value="<%= clearAllLabel  %>"/>

<div class="our-product-toolbar">
	<div class="container-fluid toolbar-container">
		 <div class="row">
		 	<div class="col-lg-9 col-md-8 col-sm-8 col-xs-12 border-col">
		 		<div class="swiper-container-parent">
			 		<div class="js-toolbar-container swiper-container">
			 			<ul class="swiper-wrapper">
			 				<%
							for (String prdtLifeStageTagName : prdtLifeStageTags){
								
								Tag prdtLifeStageTag = tagManager.resolve(prdtLifeStageTagName);
						        String prdtLifeStageTagTitle = prdtLifeStageTag.getLocalizedTitle(locale);
						        String prdtLifeStageTagID = WCMUtil.getTagKeyByTags(prdtLifeStageTag.getLocalTagID());
							%>
							<c:set var="varPrdtLifeStageTagTitle" value="<%= prdtLifeStageTagTitle  %>"/>
							<c:set var="varPrdtLifeStageTagID" value="<%= prdtLifeStageTagID  %>"/>
							<c:set var="varPrdtLifeStageTagTitleIcon" value="<%= WCMUtil.getProductStageIcon(prdtLifeStageTagID) %>"/>
		
			 				<!-- Start Product Life Stage looping -->
			 				<li class="swiper-slide" data-id="${varPrdtLifeStageTagID}">
			 					<div class="our-product-toolbar-item">
	                              <svg class="brands-icon toolbar">
	                                <use href="${varSvgIconPath}#${varPrdtLifeStageTagTitleIcon}" xlink:href="${varSvgIconPath}#${varPrdtLifeStageTagTitleIcon}"></use>
	                              </svg>
	                              <p>${varPrdtLifeStageTagTitle}</p>
	                            </div>
			 				</li>
			 				
			 				<% } %>
			 				<!-- end looping -->
			 			</ul>
			 			
			 		</div>
			 		
			 		<div class="swiper-lifestages-prev">
	                    <div class="swiper-button-wrapper">
	                      <div class="swiper-button">
	                        <svg class="brands-icon link-icon-small icon-center">
	                          <use href="${varSvgIconPath}#icon-arrow-left" xlink:href="${varSvgIconPath}#icon-arrow-left"></use>
	                        </svg>
	                      </div>
	                    </div>
	                  </div>
	                  <div class="swiper-lifestages-next">
	                    <div class="swiper-button-wrapper">
	                      <div class="swiper-button">
	                        <svg class="brands-icon link-icon-small icon-center">
	                          <use href="${varSvgIconPath}#icon-arrow-right" xlink:href="${varSvgIconPath}#icon-arrow-right"></use>
	                        </svg>
	                      </div>
	                    </div>
	                  </div>
		 		</div>   
		 	</div>
		 	 <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
		 	 	<div class="btn-wrapper">
		 	 		<a herf="" class="btn btn-action" id="applylifestagesfilter" >${varApplyLabel}</a>
		 	 		<a class="btn btn-link" id="clearall">${varClearAllLabel}</a>
		 	 	</div>
		 	 </div>
		 	
		 </div>
	</div>
</div>