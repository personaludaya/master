<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>
<%

String instagramUrl = properties.get("instagram-url",null);
instagramUrl = instagramUrl == null ? "" : WCMUtil.getURL(instagramUrl, isAuthor);

String instagramImg = properties.get("instagram-img",null);
%>

<c:set var="varInstagramUrl" value="<%= instagramUrl %>"/>
<c:set var="varInstagramImg" value="<%= instagramImg %>"/>

Instagram URL: <c:out value="${varInstagramUrl}"/>
<br/>
Instagram Image:
<br/>
<c:if test="${varInstagramImg != null}">
	<img src="<c:out value="${varInstagramImg}"/>" data-rjs="2">
</c:if>
