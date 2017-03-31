<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="java.util.*,
                org.apache.sling.api.scripting.SlingBindings,
                com.brands.core.utils.WCMUtil,
                com.day.cq.wcm.api.WCMMode" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String errorPg = "/content/brands/sg/en/error-404";

if (null != currentPage && currentPage.getDepth() > 3) {
    Page apage = currentPage.getAbsoluteParent(3);
    errorPg = WCMUtil.getPagePropertyValue(apage, "error-404-path");
}

String errorUrl = WCMUtil.getURL(errorPg, isAuthor);

//send 404
response.setStatus(404);
%>
<sling:include path="<%= errorUrl %>"/>