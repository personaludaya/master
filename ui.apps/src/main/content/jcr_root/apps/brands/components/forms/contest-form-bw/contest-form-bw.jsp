<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*"%>

<%
String contentCopyLine1 = properties.get("content_copy_line1_t", "");
String contentCopyLine2 = properties.get("content_copy_line2_t", "");
String contentCopyLine3 = properties.get("content_copy_line3_t", "");
%>

<c:set var="varContentCopyLine1" value="<%= contentCopyLine1 %>"/>
<c:set var="varContentCopyLine2" value="<%= contentCopyLine2 %>"/>
<c:set var="varContentCopyLine3" value="<%= contentCopyLine3 %>"/>

<div data-js-loader='["contest-participant-form-container.js"]'></div>
<div class="container-fluid">
	 <div class="row">
	 	 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	 	 	 <p class="tagline">${varContentCopyLine1}</p>
	 	 	  <div class="participant-form-wrapper">
	 	 	  	<div class="row">
	 	 	  		<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 col-lg-offset-2 col-md-offset-2 col-sm-offset-2 col-xs-offset-0">
	 	 	  			<h2>${varContentCopyLine2}</h2>
                        <p class="subheader">${varContentCopyLine3}</p>
                        <cq:include path="contestspar" resourceType="foundation/components/parsys"/>
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