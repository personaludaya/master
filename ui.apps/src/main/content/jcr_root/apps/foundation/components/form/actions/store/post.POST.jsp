<%--
  ADOBE CONFIDENTIAL
  ___________________

   Copyright 2016 Adobe Systems Incorporated
   All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.

  ==============================================================================

  Form 'action' component

  Handles the form store

--%><%
%><%@include file="/apps/brands/global/global.jsp"%><%
%><%@page session="false" %><%
%><%@page import="org.apache.commons.lang3.StringUtils"%><%
String redirectPath = (String)request.getAttribute("redirectPath");
String tid = (String)request.getAttribute("varFormTransactionId");
if(StringUtils.isNotEmpty(tid)){
	//try get cookie
 	Cookie cookie = slingRequest.getCookie("bwtid");
	if(cookie!= null){
		//delete cookie because it's invalid
		cookie.setMaxAge(0);
	} 
	Cookie formTidCookie = new Cookie("bwtid", tid);
	formTidCookie.setHttpOnly(true);
	formTidCookie.setMaxAge(180);
	if(request.isSecure()) formTidCookie.setSecure(true);
	response.addCookie(formTidCookie);
}
if(StringUtils.isNotEmpty(redirectPath)){
	response.sendRedirect(WCMUtil.getURL(redirectPath));
}

%>
