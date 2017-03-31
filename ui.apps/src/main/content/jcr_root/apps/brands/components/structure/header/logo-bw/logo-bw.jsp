<%--
  Top Navigation Header component
  Consists of: Logo
  ==============================================================================
  Requirements:

--%>
<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang.StringUtils" %>
<% 
String logoPath = pageProperties.getInherited("logo-path", "");
logoPath = WCMUtil.getURL(logoPath, isAuthor);
if(StringUtils.isNotEmpty(logoPath)) logoPath += "#clickloc=topnav";
String logoAlt = pageProperties.getInherited("logo-alt_t", "");
%>
<c:set var="varLogoPath" value="<%= logoPath  %>"/>
<c:set var="varLogoAlt" value="<%= logoAlt  %>"/>

<a href="${varLogoPath}">
	<img class="brands-logo img-responsive" src="<%=imgPath%>/header/logo.png" alt="${varLogoAlt}" data-rjs="2">
	<img class="brands-logo-fixed img-responsive" src="<%=imgPath%>/header/logo.png" alt="${varLogoAlt}" data-rjs="2">
</a>