<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*" %><%
%><%
String bkgrdStyle = properties.get("bkgrd-style", null);
String bkgrdContainerImgPath = properties.get("bkgrd-img-path", null);
bkgrdContainerImgPath = (bkgrdContainerImgPath == null) ? "" : "style=\"background-image: url(\'"+ bkgrdContainerImgPath + "\')\"";
%>

<c:set var="varBkgrdStyle" value="<%= bkgrdStyle %>"/>
<c:set var="varBkgrdContainerImgPath" value="<%= bkgrdContainerImgPath %>"/>

<div class="background-container ${varBkgrdStyle}" ${varBkgrdContainerImgPath}>
  <cq:include path="background-container-par" resourceType="foundation/components/parsys"/>
</div>

<% 
if (isAuthor) { %>
<div class="clear"></div>
<%
} %>

<cq:include path="background-container-end" resourceType="brands/components/common/background-container-bw/endbar" />