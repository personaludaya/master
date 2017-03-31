<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String cols = properties.get("cols", "cols2");
%>

<c:set var="varCols" value="<%= cols %>"/>

<div class="container-fluid">
<div class="row">

<c:if test="${varCols == 'cols2'}">
	<c:forEach var="i" begin="1" end="2" step="1">	
	<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
		<cq:include path="cols-par-${i}" resourceType="foundation/components/parsys"/>
	</div>
	</c:forEach>
</c:if>

<c:if test="${varCols == 'cols2a'}">
	<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
		<cq:include path="cols-par-1" resourceType="foundation/components/parsys"/>
	</div>
	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
		<cq:include path="cols-par-2" resourceType="foundation/components/parsys"/>
	</div>
</c:if>

<c:if test="${varCols == 'cols2b'}">
	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
		<cq:include path="cols-par-1" resourceType="foundation/components/parsys"/>
	</div>
	<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
		<cq:include path="cols-par-2" resourceType="foundation/components/parsys"/>
	</div>
</c:if>

<c:if test="${varCols == 'cols3'}">
	<c:forEach var="i" begin="1" end="3" step="1">
	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
		<cq:include path="cols-par-${i}" resourceType="foundation/components/parsys"/>
	</div>
	</c:forEach>
</c:if>

<c:if test="${varCols == 'cols4'}">
	<c:forEach var="i" begin="1" end="4" step="1">
	<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
		<cq:include path="cols-par-${i}" resourceType="foundation/components/parsys"/>
	</div>
	</c:forEach>
</c:if>

</div>
</div>

<% 
if (isAuthor) { %>
<div class="clear"></div>
<%
} %>

<cq:include path="column-control-end" resourceType="brands/components/common/column-control-bw/endbar" />