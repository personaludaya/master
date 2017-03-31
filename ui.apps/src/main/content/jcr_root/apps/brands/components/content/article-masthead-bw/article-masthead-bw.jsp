<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.day.cq.wcm.api.*" %>
<%
String currentPageTemplatePath = pageProperties.get("cq:template", "/apps/brands/templates/bemagazine-page");
%>

<c:set var="varCurrentPageTemplatePath" value="<%= currentPageTemplatePath %>"/>

<c:if test="${varCurrentPageTemplatePath == '/apps/brands/templates/content-page'}">
	<cq:include script="article-masthead.jsp"/>
</c:if>

<c:if test="${varCurrentPageTemplatePath == '/apps/brands/templates/bemagazine-page'}">
	<cq:include script="bemagazine-masthead.jsp"/>
</c:if>