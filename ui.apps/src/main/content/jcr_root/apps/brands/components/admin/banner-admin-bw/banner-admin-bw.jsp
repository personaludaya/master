<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>
<%
String ctaStyle = properties.get("cta-style", "");
String ctaType = properties.get("cta-type", "");
String ctaIconStyle = properties.get("cta-icon-style","");
String ctaPath = properties.get("cta-path",null);
ctaPath = ctaPath == null ? "" : WCMUtil.getURL(ctaPath, isAuthor);
String ctaText = properties.get("cta-text",null);
ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
String ctaIcon = properties.get("cta-icon",null);

String bannerImgStyle = properties.get("banner-img-style","");
%>
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

<c:set var="varBannerTitle" value="<%= properties.get("banner-title_t",null)  %>"/>
<c:set var="varBannerCopy" value="<%= properties.get("banner-copy_t",null)  %>"/>
<c:set var="varBannerIcon" value="<%= properties.get("banner-icon",null)  %>"/>
<c:set var="varBannerIconStyle" value="<%= properties.get("banner-icon-style",null)  %>"/>
<c:set var="varBannerImgPath" value="<%= properties.get("banner-img-path",null)  %>"/>
<c:set var="varBannerImgAlt" value="<%= properties.get("banner-img-alt_t",null)  %>"/>
<c:set var="varBannerImgStyle" value="<%= bannerImgStyle  %>"/>

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

Banner Title: <c:out value="${varBannerTitle}"/>
<br/>
Banner Copy: <c:out value="${varBannerCopy}"/>
<br/>
Banner Icon: <c:out value="${varBannerIcon}"/>
<br/>
Banner Icon Style: <c:out value="${varBannerIconStyle}"/>
<br/>
Banner Image Path:
<br/>
<c:if test="${varBannerImgPath != null}">
	<img src="<c:out value="${varBannerImgPath}"/>" alt="<c:out value="${varBannerImgAlt != null ? varBannerImgAlt : varBannerTitle}"/>" data-rjs="2">
	<br/>
</c:if>
Banner Image Style: ${varBannerImgStyle}
<br/>
Cta Style: <c:out value="${varCtaStyle}"/>
<br/>
Cta Icon Style: <c:out value="${varCtaIconStyle}"/>
<br/>
Cta Type: <c:out value="${varCtaType}"/>
<br/>
Cta Type Css Class: <c:out value="${varCtaTypeClass}"/>
<br/>
Cta Path: <c:out value="${varCtaPath}"/>
<br/>
Cta Text: <c:out value="${varCtaText}"/>
<br/>
Cta Icon: <c:out value="${varCtaIcon}"/>
<br/>
CTA Open in new window: <c:out value="${ctaOpenNewWin}"/>