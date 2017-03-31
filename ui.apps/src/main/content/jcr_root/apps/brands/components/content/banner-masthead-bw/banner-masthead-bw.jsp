<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils"%>

<%
String bannerTitle = properties.get("banner-title_t", "");
String bannerCopy = properties.get("banner-copy_t", "");
String bannerImgPath = properties.get("banner-img-path",null);
bannerImgPath = bannerImgPath == null ? "" : WCMUtil.getURL(bannerImgPath, isAuthor);
String bannerImgAlt = properties.get("banner-img-alt_t",null);
bannerImgAlt = StringUtils.isEmpty(bannerImgAlt) ? currentPage.getTitle() : bannerImgAlt;

String ctaStyle = properties.get("cta-style", "");
String ctaType = properties.get("cta-type", "");
String ctaIconStyle = properties.get("cta-icon-style","");
String ctaPath = properties.get("cta-path",null);
ctaPath = ctaPath == null ? "" : WCMUtil.getURL(ctaPath, isAuthor);
String ctaText = properties.get("cta-text",null);
ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
String ctaIcon = properties.get("cta-icon",null);
%>

<c:set var="varBannerTitle" value="<%= bannerTitle %>"/>
<c:set var="varBannerCopy" value="<%= bannerCopy %>"/>
<c:set var="varBannerImgPath" value="<%= bannerImgPath %>"/>
<c:set var="varBannerImgAlt" value="<%= bannerImgAlt %>"/>

<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win", "").equals("true")  %>"/>
<c:if test="${ctaOpenNewWin == 'true'}">
	<c:set var="ctaOpenNewWinTarget" value="target=_blank"/>
</c:if>
<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
<c:set var="varCtaTypeClass" value=""/>
<c:set var="varCtaPath" value="<%= ctaPath %>"/>
<c:set var="varCtaText" value="<%= ctaText %>"/>
<c:set var="varCtaIcon" value="<%= ctaIcon %>"/>

<c:choose>
    <c:when test="${varCtaType == 'button' }">
       <c:set var="varCtaTypeClass" value="btn btn-action btn-lg"/>
    </c:when>
    <c:when test="${varCtaType == 'link'}">
       <c:set var="varCtaTypeClass" value="view-all"/>
    </c:when>
    <c:otherwise>
	   <c:set var="varCtaTypeClass" value=""/>
    </c:otherwise>
</c:choose>

<div class="masthead-2c-big-container masthead-style5">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-8 col-xs-offset-2 hidden-lg hidden-md hidden-sm">
				<img class="img-responsive img-style1" src="${varBannerImgPath}" alt="${varBannerImgAlt}" title="${varBannerImgAlt}" data-rjs="2">
			</div>
			<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
	        <!-- campaign-text molecule start here-->
	                  <article class="campaign-text">
	                        <h2 class="secondary-color text-left">${varBannerTitle}</h2>
	                    <p>${varBannerCopy}</p>
	                    <a href="${varCtaPath}" class="${varCtaTypeClass}">${varCtaText}</a>
	                  </article>
	          </div>
	          <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6 col-lg-offset-0 col-md-offset-0 col-sm-offset-0 col-xs-offset-3 hidden-xs">
	          	<img class="img-responsive img-style1" src="${varBannerImgPath}"  alt="${varBannerImgAlt}" title="${varBannerImgAlt}" data-rjs="2">
	          </div>
		</div>
	</div>
</div>