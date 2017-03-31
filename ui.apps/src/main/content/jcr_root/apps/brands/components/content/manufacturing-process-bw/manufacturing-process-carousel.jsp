<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="java.util.*,
                com.brands.core.utils.*"%>

<%
  String manufacturingProcessPath = properties.get("manufacturing-process-path", null);
%>

<c:set var="varManufacturingProcessPath" value="<%= manufacturingProcessPath %>"/>
<c:set var="varNext" value="<%= I18nUtil.getLabel("next", currentPage, slingRequest, null)  %>"/>
<c:set var="varPrev" value="<%= I18nUtil.getLabel("prev", currentPage, slingRequest, null)  %>"/>

<c:if test="${varManufacturingProcessPath != null}">
	<div class="product-manufacturing-process">
		<div class="manufacturing-slides-container swiper-container">
			<div class="js-product-manufacturing-process-slide">
				<%
				   Page rootPage = pageManager.getPage(manufacturingProcessPath);
			    %>
			    <c:set var="varRootPage" value="<%= rootPage %>"/>
			    <c:if test="${varRootPage != null}">
					<div class="swiper-wrapper" data-name="Manufacturing Process">
						<%
							 Page manufacturingProcessAdminRootPage = pageManager.getPage(manufacturingProcessPath);
					         Iterator<Page> iterManufacturingProcessPages = manufacturingProcessAdminRootPage.listChildren(new PageFilter(request));
					           
					         while (iterManufacturingProcessPages.hasNext()) {
					        	 Page iterManufacturingProcessPage = iterManufacturingProcessPages.next();
					        	 Node manufacturingProcessNode = WCMUtil.getNodePropertyValueByPage(iterManufacturingProcessPage, "manufacturing_proces") != null ? WCMUtil.getNodePropertyValueByPage(iterManufacturingProcessPage, "manufacturing_proces") : currentNode;
					        	 String processName = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-name_t");
					        	 String processCopy = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-copy_t");
					        	 String processImgPath = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-img-path");
					        	 String processImgAlt = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-img-alt_t");
					        	 processImgAlt = processImgAlt == "" ? processName : processImgAlt;
						%>
					
						<c:set var="varProcessName" value="<%= processName %>"/>
						<c:set var="varProcessCopy" value="<%= processCopy %>"/>
						<c:set var="varProcessImgPath" value="<%= processImgPath %>"/>
						<c:set var="varProcessImgAlt" value="<%= processImgAlt %>"/>
						
						<!-- Start Looping -->
						<div class="product-manufacturing-process-slide-item swiper-slide" data-title="${varProcessName}">
							<div class="container-fluid">
								<div class="row">
									 <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
									 	<img class="img-responsive" src="${varProcessImgPath}" alt="${varProcessImgAlt}" title="${varProcessImgAlt}" data-rjs="2">
									 </div>
									 <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
		                                <h3>${varProcessName}</h3>
		                                <p>${varProcessCopy}</p>
		                             </div>
								</div>
							</div>
						</div>
						<!-- End looping -->
						
						<%  } %>
					</div>
					
					<div class="container-fluid">
					 <div class="row">
                          <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 col-lg-offset-7 col-md-offset-7 col-sm-offset-7 col-xs-offset-0">
                            <div class="swiper-pagination"></div>
                            <div class="product-manufacturing-process-prev">
                              <div class="swiper-button-wrapper">
                                <div class="swiper-button">
                                  <svg class="brands-icon link-icon-small icon-center">
                                    <use href="<%= svgIconPath %>#icon-arrow-left" xlink:href="<%= svgIconPath %>#icon-arrow-left"></use>
                                  </svg>
                                  <label>${varPrev}</label>
                                </div>
                              </div>
                            </div>
                            <div class="product-manufacturing-process-next">
                              <div class="swiper-button-wrapper">
                                <div class="swiper-button">
                                  <label>${varNext}</label>
                                  <svg class="brands-icon link-icon-small icon-center">
                                    <use href="<%= svgIconPath %>#icon-arrow-right" xlink:href="<%= svgIconPath %>#icon-arrow-right"></use>
                                  </svg>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
				    </div>
				
				</c:if>
			</div>
		</div>
	</div>
</c:if>