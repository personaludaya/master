<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>

<%
String timing = properties.get("timing", null);
List<Node> carouselNodeList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "carousel");
String carouselFreeForm = properties.get("carousel-freeform", "");
%>

<c:set var="varCarouselFreeForm" value="<%= carouselFreeForm  %>"/>
<c:set var="varTiming" value="<%= timing  %>"/>
<c:set var="varCarouselNodeList" value="<%= carouselNodeList  %>"/>
<c:set var="varNext" value="<%= I18nUtil.getLabel("next", currentPage, slingRequest, null)  %>"/>
<c:set var="varPrev" value="<%= I18nUtil.getLabel("prev", currentPage, slingRequest, null)  %>"/>

<c:choose>
<c:when test="${not empty varCarouselFreeForm}">

<div class="js-campaign-video swiper-container" data-js-loader='["video-player.js"]'>
    <div class="swiper-wrapper">
        
        <%= carouselFreeForm %>
        
    </div>
</div>

</c:when>
<c:otherwise>

<c:if test="${fn:length(varCarouselNodeList) > 0}">
<div class="js-campaign-video swiper-container" data-js-loader='["video-player.js"]'>
    <div class="swiper-wrapper">
        <%
        for (int i = 0; i < carouselNodeList.size(); i++) {
	        Node carouselNode = carouselNodeList.get(i);
	        String carouselImgPath = WCMUtil.getNodePropertyValue(carouselNode, "img-path");
	        String imgAlt = WCMUtil.getNodePropertyValue(carouselNode, "img-alt_t");
	        imgAlt = imgAlt == "" ? currentPage.getPageTitle() : imgAlt;
	        String videoId = WCMUtil.getNodePropertyValue(carouselNode, "video-id");
	        String videoTitle = WCMUtil.getNodePropertyValue(carouselNode, "video-title_t");
	        String caption = WCMUtil.getNodePropertyValue(carouselNode, "caption_t");
        %>
		
        <c:set var="varCarouselImgPath" value="<%= carouselImgPath  %>"/>
		<c:set var="varImgAlt" value="<%= imgAlt  %>"/>
		<c:set var="varVideoId" value="<%= videoId  %>"/>
		<c:set var="varVideoTitle" value="<%= videoTitle  %>"/>
		<c:set var="varCaption" value="<%= caption  %>"/>
		
        <!-- start loop -->
        <div class="swiper-slide">
            <!-- campaign-video molecule start here-->
            <div class="section-container campaign-video-player-container style1">
                <div class="campaign-video-loader"></div>
	                
                <%-- If need adjust the alignment
                <c:if test="${empty varVideoTitle}">
                <br/><br/>
                </c:if>
                --%>
	                
                <c:if test="${not empty varVideoId}">
                <a class="campaign-video-player-wrapper" data-options='{"type":"youtube","vid":"${varVideoId}","width":"100%","height":"505px","autoplay":"${varTiming}","name":"<c:out value="${varVideoTitle}"/>"}'>
                </c:if>
                
	                <div class="background-container background-cover-image" style="background-image: url(${varCarouselImgPath})" title="${varImgAlt}" alt="${varImgAlt}">
	                    <c:if test="${not empty varVideoId}">
	                    <div class="play-icon">
	                        <svg class="brands-icon highlight">
	                            <use href="<%= svgIconPath %>#icon-play" xlink:href="<%= svgIconPath %>#icon-play"></use>
	                        </svg>
	                    </div>
	                    </c:if>
	                </div>
	                    	
                <c:if test="${not empty varVideoId}">
                </a>
                </c:if>
	                 
                <c:if test="${not empty varCaption}">
                <p class="video-caption">${varCaption}</p>
                </c:if>
	                 
            </div>
            <!-- campaign-video molecule end here-->
        </div>
        <!-- end loop -->	
        <% 
        }	
        %>
	</div>
	
	<c:if test="${fn:length(varCarouselNodeList) > 1}">
    <div class="swiper-prev">
        <div class="swiper-button-wrapper">
            <div class="swiper-button">
                <svg class="brands-icon link-icon-small icon-center">
                    <use href="<%= svgIconPath %>#icon-arrow-left" xlink:href="<%= svgIconPath %>#icon-arrow-left"></use>
                </svg>
            </div>
        </div>
    </div>
        
    <div class="swiper-next">
        <div class="swiper-button-wrapper">
            <div class="swiper-button">
                <svg class="brands-icon link-icon-small icon-center">
                    <use href="<%= svgIconPath %>#icon-arrow-right" xlink:href="<%= svgIconPath %>#icon-arrow-right"></use>
                </svg>
            </div>
        </div>
    </div>
    </c:if>
</div>
</c:if>

</c:otherwise>
</c:choose>