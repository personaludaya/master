<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*"%>

<%
  String content = properties.get("content_t", "");
%>

<c:set var="varContent" value="<%= content %>"/>

<div data-js-loader='["contest-participant-form-container.js"]'></div>
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<p class="tagline text-center">${varContent}</p>
			<div class="participant-form-wrapper">
				<div class="row">
					<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 col-lg-offset-2 col-md-offset-2 col-sm-offset-2 col-xs-offset-0">
						<cq:include path="contactuspar" resourceType="foundation/components/parsys"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%
//for analytics::datalayer
String formComponentName = component.getProperties().get("jcr:title", "");
String formId = currentPage.getName();
request.setAttribute("varFormInfoFormName", formComponentName + ":" + formId);
%>