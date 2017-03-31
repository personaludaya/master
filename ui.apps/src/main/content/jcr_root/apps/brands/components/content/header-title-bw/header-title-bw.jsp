<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*"%>
<%
  String ctaType = properties.get("cta-type", "");
  String ctaStyle = properties.get("cta-style","");
  String ctaIconStyle = properties.get("cta-icon-style","");
  String headerTitleCtaPath = properties.get("cta-path",null);
  String headerAlignment = properties.get("header-alignment","");
  headerTitleCtaPath = headerTitleCtaPath == null ? "" : WCMUtil.getURL(headerTitleCtaPath, isAuthor);
  String headerStyle =  properties.get("header-style",null);
  headerStyle = headerStyle == null ? "" : "class='" + headerAlignment + " " + headerStyle + "'";

  String ctaText = properties.get("cta-text",null);
  ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
%>
<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
<c:set var="varCtaTypeClass" value=""/>

<c:set var="headerTitle" value="<%= properties.get("header-title_t",null)  %>"/>
<c:set var="headerSize" value="<%= properties.get("header-size",null)  %>"/>
<c:set var="headerAlignment" value="<%= properties.get("header-alignment",null)  %>"/>
<c:set var="varHeaderStyle" value="<%= headerStyle %>"/>
<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
<c:set var="ctaPath" value="<%= headerTitleCtaPath  %>"/>
<c:set var="ctaIcon" value="<%= properties.get("cta-icon",null)  %>"/>

<c:set var="varHeaderCtaText" value="<%= ctaText  %>"/>
<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win", "").equals("true")  %>"/>
<c:set var="svgIconPath" value="<%= svgIconPath  %>"/>

<c:if test="${ctaOpenNewWin == 'true'}">
	<c:set var="ctaOpenNewWinTarget" value="target=_blank"/>
</c:if>

<c:if test="${headerTitle != null}">
	<<c:out value="${headerSize}"/> ${varHeaderStyle}>
    	<c:out value="${headerTitle}"/>
	</<c:out value="${headerSize}"/>>
</c:if>


<c:choose>
    <c:when test="${varCtaType == 'button' }">
       <c:set var="varCtaTypeClass" value="view-all btn btn-action"/>
    </c:when>
    <c:when test="${varCtaType == 'link'}">
       <c:set var="varCtaTypeClass" value="view-all"/>
    </c:when>
    <c:otherwise>
	   <c:set var="varCtaTypeClass" value=""/>
    </c:otherwise>
</c:choose>


<c:if test="${ctaPath != null and ctaPath !=''}">
    <div class="view-all-wrapper <c:out value="${headerAlignment}"/>">
        <a href="${ctaPath}" class="${varCtaTypeClass} ${varCtaStyle}" ${ctaOpenNewWinTarget} title="${varHeaderCtaText}">
           <c:out value="${varHeaderCtaText}"/>

           <c:if test="${varCtaType == 'link'}">
               <svg class="brands-icon ${varCtaIconStyle}">
                <use href="<c:out value="${svgIconPath}"/>#<c:out value="${ctaIcon}"/>" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<c:out value="${svgIconPath}"/>#<c:out value="${ctaIcon}"/>"></use>
               </svg>
           </c:if>
        </a>
    </div>
</c:if>


