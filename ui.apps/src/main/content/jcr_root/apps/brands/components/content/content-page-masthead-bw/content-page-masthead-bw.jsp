<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %><%
%><%
String[] contentPagePathsArr = properties.get("content-page-paths", String[].class);

String ctaStyle = properties.get("cta-style", "");
String ctaType = properties.get("cta-type", "");
String ctaIconStyle = properties.get("cta-icon-style","");
String ctaText = properties.get("cta-text",null);
ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
String ctaIcon = properties.get("cta-icon",null);
%>

<c:set var="varContentPagePathsArr" value="<%= contentPagePathsArr  %>"/>
<c:if test="${fn:length(varContentPagePathsArr) > 0}">

<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win", "").equals("true")  %>"/>
<c:if test="${ctaOpenNewWin == 'true'}">
	<c:set var="ctaOpenNewWinTarget" value="target=_blank"/>
</c:if>
<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
<c:set var="varCtaTypeClass" value=""/>
<c:set var="varCtaText" value="<%= ctaText %>"/>
<c:set var="varCtaIcon" value="<%= ctaIcon %>"/>

<c:choose>
    <c:when test="${varCtaType == 'button' }">
       <c:set var="varCtaTypeClass" value="btn btn-action"/>
    </c:when>
    <c:when test="${varCtaType == 'link'}">
       <c:set var="varCtaTypeClass" value="view-all"/>
    </c:when>
    <c:otherwise>
	   <c:set var="varCtaTypeClass" value=""/>
    </c:otherwise>
</c:choose>

<div class="our-product-banner">
	<div class="container-fluid">
		<div class="row">
		
		<%
		for (int i = 0; i < contentPagePathsArr.length; i++) {
			Page contentPage = pageManager.getPage(contentPagePathsArr[i]);
			String pageTitle = contentPage.getPageTitle();
			String overviewHeader = WCMUtil.getPagePropertyValue(contentPage, "overview-header");
			String genPageImgPath = WCMUtil.getPagePropertyValue(contentPage, "img-path");
			String genPageImgMobilePath = WCMUtil.getPagePropertyValue(contentPage, "img-mobile-path");
		    String genImgAltText = WCMUtil.getPagePropertyValue(contentPage, "img-alt_t");
		    genImgAltText = StringUtils.isEmpty(genImgAltText) ? contentPage.getPageTitle() : genImgAltText;
			String contentPagePath =  WCMUtil.getURL(contentPagePathsArr[i], isAuthor); 
			
			String pillarName = contentPage.getName();
		%>
		
		<c:set var="varPageTitle" value="<%= pageTitle  %>"/>
		<c:set var="varOverviewHeader" value="<%= overviewHeader  %>"/>
		<c:set var="varGenPageImgPath" value="<%= genPageImgPath  %>"/>
		<c:set var="varGenPageImgMobilePath" value="<%= genPageImgMobilePath  %>"/>
		<c:set var="varGenImgAltText" value="<%= genImgAltText  %>"/>
		<c:set var="varContentPagePath" value="<%= contentPagePath  %>"/>
		<c:set var="varPillarName" value="<%= pillarName  %>"/>
		
			<!-- Start Looping -->
			<div class="col-lg-4 col-md-4 col-md-4 col-xs-12">
                <!-- our-product-banner-item start here-->
                <div class="our-product-banner-item">
                    <div class="thumbnail">
                        <div class="row">

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col-right-xs">
                                <img class="img-responsive full-width hidden-xs" src="${varGenPageImgPath}" alt="${varGenImgAltText}" title="${varGenImgAltText}">
                            	  <div class="background-container background-cover-image hidden-lg hidden-md hidden-sm" style="background-image:url('${varGenPageImgMobilePath}'); height:202px;" alt="${varGenImgAltText}" title="${varGenImgAltText}"></div>
                            	
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col-left-xs">
                                <div class="caption-container">
                                    <div class="caption">
                                        <h3>${varPageTitle}</h3>
                                        <p>${varOverviewHeader}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="btn-wrapper">
                            <a href="${varContentPagePath}#pillar=${varPillarName}" class="${varCtaTypeClass}" ${ctaOpenNewWinTarget}>${varCtaText}</a>
                        </div>

                    </div>
                </div>
                <!-- our-product-banner-item end here-->
			</div>
			<!-- End looping -->
		<% } %>
		</div>
	</div>
</div>  
</c:if>