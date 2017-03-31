<%@include file="/apps/brands/global/global.jsp" %>
<%
  String opt = properties.get("opt", null);
%>
<c:set var="varOpt" value="<%= opt %>"/>

<c:if test="${varOpt == 'store-locations'}">
	<cq:include script="store-locations.jsp"/>
</c:if>

<c:if test="${varOpt == 'ingredients'}">
	<cq:include script="ingredients.jsp"/>
</c:if>