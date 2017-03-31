<%@include file="/apps/brands/global/global.jsp" %>

<c:set var="varTitle" value="<%= properties.get("title_t",null)  %>"/>
<c:set var="varHeader" value="<%= properties.get("header_t",null)  %>"/>
<c:set var="varContent" value="<%= properties.get("content_t",null)  %>"/>

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-9 col-lg-offset-1 col-md-9 col-sm-9 col-xs-12">
			<p>${varTitle}</p>
			<h1 class="secondary-color">${varHeader}</h1>
			<p>${varContent}</p>
		</div>
	</div>
</div>

<%
//for analytics::datalayer
request.setAttribute("varErrorPageURL", component.getProperties().get("jcr:title", "error-404-bw"));
%>