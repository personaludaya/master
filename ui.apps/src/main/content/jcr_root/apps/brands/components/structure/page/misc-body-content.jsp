<%@include file="/apps/brands/global/global.jsp" %>
<!-- custom body content start -->
<%
String contentAdditionCurrent = currentPage.getProperties().get("content-addition-current", "");
if(!"".equals(contentAdditionCurrent)){
    out.print(contentAdditionCurrent);
}

String contentAdditionInherited = pageProperties.getInherited("content-addition-inherited", "");
if(!"".equals(contentAdditionInherited)){
    out.print(contentAdditionInherited);
}
%>
<!-- custom body content end -->