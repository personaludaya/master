<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*"%>

<%
  String contentStyle = properties.get("content-style", "none");
  String contentType = properties.get("content-type", "none");
  String ctaStyle = properties.get("cta-style", "");
  String ctaTextAlignment = properties.get("cta-text-alignment","");
  String ctaType = properties.get("cta-type", "");
  String ctaIconStyle = properties.get("cta-icon-style","");
  String content = properties.get("content_t", null);
  String ctaPath = properties.get("cta-path",null);
  ctaPath = ctaPath == null ? "" : WCMUtil.getURL(ctaPath, isAuthor);
  String ctaText = properties.get("cta-text",null);
  ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
  String ctaIcon = properties.get("cta-icon",null);
  contentStyle = contentStyle.equals("none") ? "" : contentStyle;
  contentType = contentType.equals("none") ? "" : contentType;
  
  String textImgPath =  properties.get("img-path",null);
  String textImgAltText =  properties.get("img-alt_t",null);
  textImgAltText = textImgAltText == null ? currentPage.getPageTitle() : textImgAltText;
  
  String[] contentBulletsArr = properties.get("content-bullets_t", String[].class);
%>
<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
<c:set var="varCtaTextAlignment" value="<%= ctaTextAlignment %>"/>
<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
<c:set var="varCtaTypeClass" value=""/>
<c:set var="varContentStyle" value="<%= contentStyle %>"/>
<c:set var="varContentType" value="<%= contentType %>"/>
<c:set var="varContent" value="<%= content %>"/>
<c:set var="varCtaPath" value="<%= ctaPath %>"/>
<c:set var="varCtaText" value="<%= ctaText %>"/>
<c:set var="varCtaIcon" value="<%= ctaIcon %>"/>
<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win", "").equals("true")  %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varTextImgPath" value="<%= textImgPath  %>"/>
<c:set var="varTextImgAltText" value="<%= textImgAltText  %>"/>
<c:set var="varContentBulletsArr" value="<%= contentBulletsArr  %>"/>


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

<c:set var="varIsBulletExit" value="false"/>
<c:set var="varBulletCss" value=""/>

<c:if test="${fn:length(varContentBulletsArr) > 0}">
	<c:set var="varIsBulletExit" value="true"/>
	<c:set var="varBulletCss" value="bullet-list"/>
</c:if>

 <article class="campaign-text ${varBulletCss} ${varContentStyle} ${varContentType}">
    <cq:include path="header-title-bw" resourceType="brands/components/content/header-title-bw"/>
     
    <c:if test="${varTextImgPath != null}">
    <img class="img-responsive" src="${varTextImgPath}" alt="${varTextImgAltText}" title="${varTextImgAltText}" data-rjs="2">
    </c:if>
     
    <p>${varContent}</p>
     
	<c:if test="${varIsBulletExit == 'true'}">
	<ul>
    <%    
    for (int i = 0; i < contentBulletsArr.length ; i++) { %>
        <c:set var="varContentBullet" value="<%= contentBulletsArr[i]  %>" />
		<li>${varContentBullet}</li>
	<%    
	} %>
	</ul>
	</c:if>
	
    <c:if test="${varCtaPath != null and varCtaPath !=''}">
    <div class="view-all-wrapper ${varCtaTextAlignment}">
        <a href="<c:out value="${varCtaPath}"/>" class="${varCtaTypeClass} ${varCtaStyle}" ${ctaOpenNewWinTarget}  title="${varCtaText}"/>
            <c:out value="${varCtaText}"/>
            <c:if test="${varCtaType == 'link'}">
            <svg class="brands-icon ${varCtaIconStyle}">
                <use href="<c:out value="${varSvgIconPath}"/>#<c:out value="${varCtaIcon}"/>" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<c:out value="${varSvgIconPath}"/>#<c:out value="${varCtaIcon}"/>"></use>
            </svg>
            </c:if>
        </a>
    </div>
    </c:if>    
	
</article>
