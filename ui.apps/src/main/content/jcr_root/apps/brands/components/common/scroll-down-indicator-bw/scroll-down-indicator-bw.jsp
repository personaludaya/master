<%@include file="/apps/brands/global/global.jsp" %><%
%>
<%@page import="com.brands.core.utils.*" %>

<c:set var="varHideInMobile" value="<%= properties.get("hide-in-mobile", "").equals("true")  %>"/>
<c:set var="varHideScrollText" value="<%= properties.get("hide-scroll-text", "").equals("true")  %>"/>
<c:set var="svgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varScrollTextStyle" value="<%= properties.get("scroll-text-style",null)  %>"/>

<c:set var="varHideInMobileValue" value=""/>
<c:if test="${varHideInMobile == 'true'}">
	<c:set var="varHideInMobileValue" value="hidden-xs"/>
</c:if>

<c:set var="varHideScrollTextValue" value="<%= I18nUtil.getLabel("scolldowntoexplore", currentPage, slingRequest, null) %>"/>

<div class="view-all-wrapper text-center ${varHideInMobileValue} scroll-down">
  <a class="view-all ${varScrollTextStyle}">
  	<c:if test="${varHideScrollText != 'true'}">
  		${varHideScrollTextValue}
  	</c:if>
  	
      <svg class="brands-icon link-icon-small icon-scroll-down">
        <use href="${svgIconPath}#icon-arrow-down" xlink:href="${svgIconPath}#icon-arrow-down"></use>
      </svg>
  </a>
</div>