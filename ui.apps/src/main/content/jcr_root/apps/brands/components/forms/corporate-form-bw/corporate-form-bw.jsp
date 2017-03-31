<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*"%>

<%
String contentCopyLine1 = properties.get("content_copy_line1_t", "");
String contentCopyLine2 = properties.get("content_copy_line2_t", "");
%>

<c:set var="varContentCopyLine1" value="<%= contentCopyLine1 %>"/>
<c:set var="varContentCopyLine2" value="<%= contentCopyLine2 %>"/>

<div data-js-loader='["corporate-enquiries.js"]'></div>
<div class="participant-form-wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 col-lg-offset-2 col-md-offset-2 col-sm-offset-2 col-xs-offset-0">
				<p class="text-center">${varContentCopyLine1}</p><p class="text-center">${varContentCopyLine2}</p>
				<cq:include path="corporatepar" resourceType="foundation/components/parsys"/>
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