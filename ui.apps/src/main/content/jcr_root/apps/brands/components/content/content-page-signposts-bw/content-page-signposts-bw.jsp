<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
String noOfCols = properties.get("no-of-cols", "cols3");

%>

<c:set var="varNoOfCols" value="<%= noOfCols  %>"/>


<c:if test="${varNoOfCols == 'cols3'}">
	<cq:include script="3columns.jsp"/>
</c:if>


<c:if test="${varNoOfCols == 'cols4'}">
	<cq:include script="4columns.jsp"/>
</c:if>
