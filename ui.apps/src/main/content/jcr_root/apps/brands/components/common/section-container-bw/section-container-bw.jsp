<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="org.apache.commons.lang3.StringUtils" %><%

String sectionStyle = properties.get("section-style", null);
String sectionContainerId = "";
if(StringUtils.isNotBlank(sectionStyle) && sectionStyle.equals("our-product--toolbar-and-container")){
	sectionContainerId = "product-compare-selection";
}
%>

<c:set var="varSectionStyle" value="<%= sectionStyle  %>"/>
<c:set var="varSectionContainerId" value="<%= sectionContainerId  %>"/>

<div id="${varSectionContainerId }" class="section-container <c:out value="${varSectionStyle}"/>">
  <cq:include path="section-container-par" resourceType="foundation/components/parsys"/>
</div>

<% 
if (isAuthor) { %>
<div class="clear"></div>
<%
} %>

<cq:include path="section-container-end" resourceType="brands/components/common/section-container-bw/endbar" />