<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,
                org.apache.commons.lang3.StringUtils"
%><%
String[] cpgnBannerAdminPathArr = properties.get("cmpgn-admin-paths", String[].class);
String intervalUnit = properties.get("carousel-interval-unit", "seconds");
String intervalStrVal = properties.get("carousel-interval-value", "300");
Long intervalVal= Long.parseLong(intervalStrVal);
Long intervalMs = 0L;

if (StringUtils.equalsIgnoreCase("minutes", intervalUnit)) {
    intervalMs = intervalVal * 60 * 1000;
} else if (StringUtils.equalsIgnoreCase("seconds", intervalUnit)) {
    intervalMs = intervalVal * 1000;
} else {
    intervalMs = intervalVal;
}

String campaignBkgrdImgPath = properties.get("campaign-bkgrd-img-path", "");
String campaignBkgrdStyle = properties.get("campaign-bkgrd-style", "");
String campaignFreeForm = properties.get("campaign-freeform", "");
%>

<c:set var="varCampaignBkgrdImgPath" value="<%= campaignBkgrdImgPath %>"/>
<c:set var="varCampaignBkgrdStyle" value="<%= campaignBkgrdStyle %>"/>
<c:set var="varCampaignFreeForm" value="<%= campaignFreeForm %>"/>

<c:choose>
<c:when test="${not empty varCampaignFreeForm}">

<!-- campaign-container start here-->
<div data-js-loader='["campaign.js"]'></div>
<div class="js-campaign swiper-container swiper-container-horizontal" data-interval="<%=intervalMs%>">
    <div class="swiper-wrapper">

        <%= campaignFreeForm %>

    </div>
</div>
<!-- campaign-container end here-->

</c:when>
<c:otherwise>

<!-- campaign-container start here-->
<div data-js-loader='["campaign.js"]'></div>
<div class="js-campaign swiper-container swiper-container-horizontal" data-interval="<%=intervalMs%>">
    <div class="swiper-wrapper">

    <%
        if(cpgnBannerAdminPathArr != null){
        	for (String adminPath : cpgnBannerAdminPathArr) {
        
	            if (StringUtils.isNotEmpty(adminPath)) {
	                Page cpgnAdminPage = pageManager.getPage(adminPath);
	
	                Node cpgnAdminNode = WCMUtil.getNodePropertyValueByPage(cpgnAdminPage, "campaign_carousel_ad") != null ? WCMUtil.getNodePropertyValueByPage(cpgnAdminPage, "campaign_carousel_ad") : currentNode;
	                String cpgnBkgrdImgPath = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-background-img");
	                String cpgnBkgrdStyle = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-bkgrd-style");
	                String cpgnMainHeader = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-main-header_t");
	                String cpgnMainHeaderSize = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-main-header-size");
	                String cpgnSubHeader = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-sub-header_t");
	                String cpgnSubHeaderSize = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-sub-header-size");
	                String cpgnOverview = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-overview_t");
	                String cpgnCTAPath = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-cta-path");
	                String cpgnCTATxt = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-cta-text_t");
	                String cpgnCTAOpenNewWindow = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-cta-open-new-win");
	                String cpgnPriImgPath = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-pri-img");
	                String cpgnPriImgAltTxt = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-pri-img-alt-txt_t");
	                String cpgnPriImgHeader = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-pri-header_t");
	                String cpgnPriHeaderSize = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-pri-header-size");
	                String cpgnPriImgDescr = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-pri-descr_t");
	                String cpgnSecImgPath = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-sec-img");
	                String cpgnSecImgAltTxt = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-sec-img-alt-txt_t");
	                String cpgnSecImgDescr = WCMUtil.getNodePropertyValue(cpgnAdminNode, "cpgn-carousel-sec-descr_t");
	
	                String targetBlankStr = "";
	                String cpgnCTAUrl = "";
	                if (StringUtils.equalsIgnoreCase("true", cpgnCTAOpenNewWindow) ) {
	                    targetBlankStr = "target=\"_blank\"";
	                }
	                if (StringUtils.isNotEmpty(cpgnCTAPath)) {
	                    cpgnCTAUrl = WCMUtil.getURL(cpgnCTAPath, isAuthor);
	                }
	                if (StringUtils.isEmpty(cpgnPriImgAltTxt)) {
	                    cpgnPriImgAltTxt = currentPage.getTitle() + " Primary Image";
	                }
	                if (StringUtils.isEmpty(cpgnSecImgAltTxt)) {
	                    cpgnSecImgAltTxt = currentPage.getTitle() + " Secondary Image";
	                }
    %>
        <c:set var="varBkgrdImgPath" value="<%= cpgnBkgrdImgPath %>"/>
        <c:set var="varBkgrdStyle" value="<%= cpgnBkgrdStyle %>"/>
        <c:set var="varMainHeader" value="<%= cpgnMainHeader  %>"/>
        <c:set var="varMainHeaderSize" value="<%= cpgnMainHeaderSize  %>"/>
        <c:set var="varSubHeader" value="<%= cpgnSubHeader  %>"/>
        <c:set var="varSubHeaderSize" value="<%= cpgnSubHeaderSize  %>"/>
        <c:set var="varOverview" value="<%= cpgnOverview  %>"/>
        <c:set var="varCTAUrl" value="<%= cpgnCTAUrl  %>"/>
        <c:set var="varCTATxt" value="<%= cpgnCTATxt %>"/>
        <c:set var="varCTATargetBlankStr" value="<%= targetBlankStr  %>"/>
        <c:set var="varPriImgPath" value="<%= cpgnPriImgPath  %>"/>
        <c:set var="varPriImgAltTxt" value="<%= cpgnPriImgAltTxt  %>"/>
        <c:set var="varPriImgHeader" value="<%= cpgnPriImgHeader  %>"/>
        <c:set var="varPriImgHeaderSize" value="<%= cpgnPriHeaderSize  %>"/>
        <c:set var="varPriImgDescr" value="<%= cpgnPriImgDescr  %>"/>
        <c:set var="varSecImgPath" value="<%= cpgnSecImgPath  %>"/>
        <c:set var="varSecImgAltTxt" value="<%= cpgnSecImgAltTxt  %>"/>
        <c:set var="varSecImgDescr" value="<%= cpgnSecImgDescr  %>"/>

        <!-- campaign banner start here -->
        <div class="campaign-info swiper-slide">
            <div class="background-container ${varBkgrdStyle}" style="background-image: url(${varBkgrdImgPath})">

                <div class="campaign-container" data-swiper-parallax="-500%">

                    <img class="img-responsive campaign-human" src="${varPriImgPath}" alt="${varPriImgAltTxt}" title="${varPriImgAltTxt}">

                    <div class="campaign-content-header">
                        <${varMainHeaderSize}>
                            ${varMainHeader}
                        </${varMainHeaderSize}>
                        <${varSubHeaderSize}>
                            ${varSubHeader}
                        </${varSubHeaderSize}>
                    </div>

                    <div class="campaign-content">
                        <p>
                            ${varOverview}
                        </p>

                        <c:if test="${not empty varCTATxt}">
                            <a class="btn btn-action" href="${varCTAUrl}" ${varCTATargetBlankStr}>
                                ${varCTATxt}
                            </a>
                        </c:if>
                    </div>

                    <c:if test="${not empty varPriImgPath}">
                        <div class="info">
                            <${varPriImgHeaderSize}>
                                ${varPriImgHeader}
                            </${varPriImgHeaderSize}>
                            <p>
                                ${varPriImgDescr}
                            </p>
                        </div>
                    </c:if>

                    <c:if test="${not empty varSecImgPath}">
                        <div class="campaign-content-product"><img class="img-responsive pull-right" src="${varSecImgPath}" alt="${varSecImgAltTxt}" title="${varSecImgAltTxt}">
                            <p class="text-right">
                                ${varSecImgDescr}
                            </p>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
        <!-- campaign banner end here -->
    <%
	            }
	        }
        }
    %>

    </div>
</div>
<!-- campaign-container end here-->

</c:otherwise>
</c:choose>