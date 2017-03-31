<%@include file="/apps/brands/global/global.jsp" %>
<%
  String contentType = properties.get("content-type", "carousel");
%>
<c:set var="varContentType" value="<%= contentType %>"/>

<div data-js-loader='["product-manufacturing-process.js"]'></div>

<c:if test="${varContentType == 'carousel'}">
	<cq:include script="manufacturing-process-carousel.jsp"/>
</c:if>

<c:if test="${varContentType == 'listing'}">
	<cq:include script="manufacturing-process-listing.jsp"/>
</c:if>