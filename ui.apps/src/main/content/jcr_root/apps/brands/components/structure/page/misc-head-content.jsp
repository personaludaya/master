<%@include file="/apps/brands/global/global.jsp" %>
<%
String content = currentPage.getProperties().get("head-script-current", "");
if(!"".equals(content)){
    out.print(content);
}

content = pageProperties.getInherited("head-script-inherited", "");
if(!"".equals(content)){
    out.print(content);
}

content = currentPage.getProperties().get("third-party-tracking-current", "");
if(!"".equals(content)){
    out.print(content);
}

content = pageProperties.getInherited("third-party-tracking-inherited", "");
if(!"".equals(content)){
    out.print(content);
}
%>