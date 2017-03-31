<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>

<%
  List<Node> contentRowNodeList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "content-row");
%>

<c:set var="varContentRowList" value="<%= contentRowNodeList  %>"/>

<c:if test="${fn:length(varContentRowList) > 0}">
	 <div class="masthead-2c-big-bgimage-container">
	 	<div class="container-fluid">
	 		<div class="row">
	 			<%
					 for (int i = 0; i < contentRowNodeList.size(); i++) {
						 Node contentRowNode = contentRowNodeList.get(i);
			         	 String contentRowImgPath = WCMUtil.getNodePropertyValue(contentRowNode, "img-path");
			         	 contentRowImgPath = WCMUtil.getURL(contentRowImgPath, isAuthor);
			         	 String contentRowImgAlt = WCMUtil.getNodePropertyValue(contentRowNode, "img-alt_t");
			         	 contentRowImgAlt = contentRowImgAlt == "" ? currentPage.getPageTitle() : contentRowImgAlt;
			         	 String contentRowTitle = WCMUtil.getNodePropertyValue(contentRowNode, "title_t").replace("\n", "<br/>");
			         	 String contentRowCtaText = WCMUtil.getNodePropertyValue(contentRowNode, "cta-text");
			         	 contentRowCtaText = I18nUtil.getLabel(contentRowCtaText, currentPage, slingRequest, null);
			         	 String contentRowCtaPath = WCMUtil.getNodePropertyValue(contentRowNode, "cta-path");
     					 contentRowCtaPath = contentRowCtaPath == null ? "" : WCMUtil.getURL(contentRowCtaPath, isAuthor);
			         	 String contentRowCtaStyle = WCMUtil.getNodePropertyValue(contentRowNode, "cta-style");
    					 String contentRowCtaIconStyle = WCMUtil.getNodePropertyValue(contentRowNode, "cta-icon-style");
    			         String contentRowCtaType = WCMUtil.getNodePropertyValue(contentRowNode, "cta-type");
			         	 String contentRowCtaIcon = WCMUtil.getNodePropertyValue(contentRowNode, "cta-icon");
			         	 boolean contentRowCtaOpenNewWin = false;
			         	 contentRowCtaOpenNewWin = WCMUtil.getNodePropertyValue(contentRowNode, "cta-open-new-win").equals("true");
			        	 String openInNewWindowString = "";
		
		        	 	 if (contentRowCtaOpenNewWin){
		        	 		openInNewWindowString = " target='_blank'";
		        		 }
					%>
					
					<c:set var="varContentRowImgPath" value="<%= contentRowImgPath  %>"/>
					<c:set var="varContentRowImgAlt" value="<%= contentRowImgAlt  %>"/>
					<c:set var="varContentRowTitle" value="<%= contentRowTitle  %>"/>
					<c:set var="varContentRowCtaText" value="<%= contentRowCtaText  %>"/>
					<c:set var="varContentRowCtaPath" value="<%= contentRowCtaPath  %>"/>
					<c:set var="varContentRowCtaStyle" value="<%= contentRowCtaStyle  %>"/>
                	<c:set var="varContentRowCtaIconStyle" value="<%= contentRowCtaIconStyle  %>"/>
                	<c:set var="varContentRowCtaType" value="<%= contentRowCtaType  %>"/>
					<c:set var="varContentRowCtaIcon" value="<%= contentRowCtaIcon  %>"/>
					<c:set var="varOpenInNewWindowString" value="<%= openInNewWindowString  %>"/>
					<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
					<c:set var="varContentRowCtaTypeClass" value=""/>


                    <c:choose>
                        <c:when test="${varContentRowCtaType == 'button' }">
                           <c:set var="varContentRowCtaTypeClass" value="btn btn-action btn-lg"/>
                        </c:when>
                        <c:when test="${varContentRowCtaType == 'link'}">
                           <c:set var="varContentRowCtaTypeClass" value="view-all"/>
                        </c:when>
                        <c:otherwise>
                           <c:set var="varContentRowCtaTypeClass" value=""/>
                        </c:otherwise>
                	</c:choose>

				        <!-- start loop -->
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<img class="masthead-background" src="${varContentRowImgPath}" alt="${varContentRowImgAlt}" title="${varContentRowImgAlt}" data-rjs="2">
							<div class="content-wrapper">
								<h3>${varContentRowTitle}</h3>
                      			<div class="view-all-wrapper text-center">
                                    <a href="${varContentRowCtaPath}" class="${varContentRowCtaTypeClass} ${varContentRowCtaStyle}" ${openInNewWindowString} title="${varContentRowTitle}">
                      					<c:out value="${varContentRowCtaText}"/>

                                        <c:if test="${varContentRowCtaType == 'link'}">
                                            <svg class="brands-icon ${varContentRowCtaIconStyle}">
                                                <use
                                                href="<c:out value="${varSvgIconPath}"/>#<c:out value="${varContentRowCtaIcon}"/>"
                                                xmlns:xlink="http://www.w3.org/1999/xlink"
                                                xlink:href="<c:out value="${varSvgIconPath}"/>#<c:out value="${varContentRowCtaIcon}"/>"></use>
                                          </svg>
                                        </c:if>
									</a>
                      			</div>
							</div>
						</div>
				        <!-- end loop -->
				
				<% }
					
				%>
	 		</div>
	 	</div>
	 </div>   
</c:if>
