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

String spTitle = properties.get("signpost-title_t", "");
String spCopy = properties.get("signpost-copy_t", "");
String spIcon = properties.get("signpost-icon", "");
String spIconStyle = properties.get("signpost-icon-style", "");
String spImagePath = properties.get("signpost-img-path", "");
String spImageAltText = properties.get("signpost-img-alt_t", "");
String spBtnText = properties.get("signpost-btn-text", "");
String spBtnPath = properties.get("signpost-btn-path", "");

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


<c:set var="varSpBtnOpenNewWin" value="<%= properties.get("signpost-btn-open-new-win", "").equals("true")  %>"/>
<c:if test="${varSpBtnOpenNewWin == 'true'}">
	<c:set var="varSpBtnOpenNewWinTarget" value="target=_blank"/>
</c:if>

<c:set var="varSpTitle" value="<%= spTitle %>"/>
<c:set var="varSpCopy" value="<%= spCopy %>"/>
<c:set var="varSpIcon" value="<%= spIcon %>"/>
<c:set var="varSpIconStyle" value="<%= spIconStyle %>"/>
<c:set var="varSpImagePath" value="<%= spImagePath %>"/>
<c:set var="varSpImageAltText" value="<%= spImageAltText %>"/>
<c:set var="varSpBtnText" value="<%= spBtnText %>"/>
<c:set var="varSpBtnPath" value="<%= spBtnPath %>"/>

Signpost Title: <c:out value="${varSpTitle}"/>
<br/>
Signpost Copy: <c:out value="${varSpCopy}"/>
<br/>
Signpost Icon: <c:out value="${varSpIcon}"/>
<br/>
Signpost Icon Style: <c:out value="${varSpIconStyle}"/>
<br/>
Signpost Button Text: <c:out value="${varSpBtnText}"/>
<br/>
Signpost Button Path: <c:out value="${varSpBtnPath}"/>
<br/>
Signpost Button Open New Window: <c:out value="${varSpBtnOpenNewWin}"/>
<br/>
<c:if test="${varSpImagePath != null}">
	<img src="<c:out value="${varSpImagePath}"/>" alt="<c:out value="${varSpImageAltText != null ? varSpImageAltText : varSpTitle}"/>" data-rjs="2">
	<br/>
</c:if>
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