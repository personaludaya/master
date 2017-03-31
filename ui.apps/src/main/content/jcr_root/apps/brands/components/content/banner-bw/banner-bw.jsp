<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils"%>

<%
String bannerAdminPath = properties.get("banner-admin-path", null);
%>
<c:set var="varBannerAdminPath" value="<%= bannerAdminPath %>"/>

<c:if test="${varBannerAdminPath != null}">
	
	<%
		Page bannerAdminPage = pageManager.getPage(bannerAdminPath);
	    Node bannerAdminNode = WCMUtil.getNodePropertyValueByPage(bannerAdminPage, "banner_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(bannerAdminPage, "banner_admin_bw") : currentNode;
	    String bannerCopy = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-copy_t");
	    String bannerIcon = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-icon");
	    String bannerTitle = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-title_t");
	    String bannerImgAlt = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-img-alt_t");
	    bannerImgAlt = StringUtils.isEmpty(bannerImgAlt) ? bannerTitle : bannerImgAlt;
	    String bannerImgPath = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-img-path");
	    String bannerIconStyle = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-icon-style");
	    String bannerImgStyle = WCMUtil.getNodePropertyValue(bannerAdminNode, "banner-img-style");
	    
	    String ctaStyle = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-style");
	    String ctaType = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-type");
	    String ctaIconStyle = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-icon-style");
	    String ctaPath = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-path");  
	    ctaPath = ctaPath == null ? "" : WCMUtil.getURL(ctaPath, isAuthor);
	    String ctaText = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-text");
	    ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
	    String ctaIcon = WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-icon");
	   
	%>
	
	<c:set var="varBannerCopy" value="<%= bannerCopy %>"/>
	<c:set var="varBannerIcon" value="<%= bannerIcon %>"/>
	<c:set var="varBannerImgAlt" value="<%= bannerImgAlt %>"/>
	<c:set var="varBannerImgPath" value="<%= bannerImgPath %>"/>
	<c:set var="varBannerTitle" value="<%= bannerTitle %>"/>
	<c:set var="varBannerIconStyle" value="<%= bannerIconStyle %>"/>
	<c:set var="varBannerImgStyle" value="<%= bannerImgStyle %>"/>
	
	<c:set var="ctaOpenNewWin" value="<%= WCMUtil.getNodePropertyValue(bannerAdminNode, "cta-open-new-win").equals("true")  %>"/>
	<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
	<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
	<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
	<c:set var="varCtaTypeClass" value=""/>
	<c:set var="varCtaPath" value="<%= ctaPath %>"/>
	<c:set var="varCtaText" value="<%= ctaText %>"/>
	<c:set var="varCtaIcon" value="<%= ctaIcon %>"/>
	
	<c:if test="${ctaOpenNewWin == 'true'}">
		<c:set var="ctaOpenNewWinTarget" value="target=_blank"/>
	</c:if>
	
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
	
	<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
	
	<c:if test="${varBannerImgPath == ''}">
		<div class="section-container ads-box campaign-ads">
			<div class="background-container gradient-background">
				<div class="container-fluid ads-content">
					<div class="row">
						 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		                   <svg class="brands-icon icon-white icon-green-banner">
		                     <use href="${varSvgIconPath}#${varBannerIconStyle}" xlink:href="${varSvgIconPath}#${varBannerIconStyle}"></use>
		                   </svg>
		                 </div>
		                 
		                  <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		                    <h3 class="secondary-color text-center">${varBannerTitle}</h3>
		                   	<p style="text-align:center;">${varBannerCopy}</p>
		                    <div class="view-all-wrapper text-center"><a href="${varCtaPath}" ${ctaOpenNewWinTarget} class="view-all">${varCtaText}
		                       <svg class="brands-icon icon-white link-icon-small">
		                         <use href="${varSvgIconPath}#${varCtaIcon}" xlink:href="${varSvgIconPath}#${varCtaIcon}"></use>
		                       </svg></a>
		                    </div>
		                 </div>
					</div>
				</div>
		</div>
		</div>
	</c:if>

	<c:if test="${varBannerImgPath != ''}">
		<div class="section-container ads-box ${varBannerImgStyle}">
			<div class="background-container gradient-background">
				<div class="container-fluid ads-content">
					<div class="row">
						 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		                   <img class="img-responsive" src="${varBannerImgPath}" alt="${varBannerImgAlt}" title="${varBannerImgAlt}" data-rjs="2">
		                 </div>
		                 
		                 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		                  		<h3 class="secondary-color text-center">${varBannerTitle}</h3>
			                   	<p style="text-align:center;">${varBannerCopy}</p>
			                    <div class="view-all-wrapper text-center"><a href="${varCtaPath}" ${ctaOpenNewWinTarget} class="view-all">${varCtaText}
			                       <svg class="brands-icon icon-white link-icon-small">
			                         <use href="${varSvgIconPath}#${varCtaIcon}" xlink:href="${varSvgIconPath}#${varCtaIcon}"></use>
			                       </svg></a>
			                    </div>
		                 </div>
					</div>
				</div>
		</div>
		</div>
	</c:if>
	
</c:if>

