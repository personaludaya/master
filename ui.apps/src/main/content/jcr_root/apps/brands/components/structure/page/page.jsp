<%@page session="false" contentType="text/html; charset=utf-8"
		import="com.day.cq.commons.Doctype,
				com.day.cq.wcm.api.WCMMode,
				com.day.cq.wcm.foundation.ELEvaluator" %><%
%><%@include file="/apps/brands/global/global.jsp"%><%                    
%><%
// read the redirect target from the 'page properties' and perform the
// redirect if WCM is disabled.
String location = properties.get("redirectTarget", "");
// resolve variables in path
location = ELEvaluator.evaluate(location, slingRequest, pageContext);
boolean wcmModeIsDisabled = WCMMode.fromRequest(request) == WCMMode.DISABLED;
boolean wcmModeIsPreview = WCMMode.fromRequest(request) == WCMMode.PREVIEW;

if ( (location.length() > 0) && ((wcmModeIsDisabled) || (wcmModeIsPreview)) ) {
    // check for recursion
    if (currentPage != null && !location.equals(currentPage.getPath()) && location.length() > 0) {
        // check for absolute path
        final int protocolIndex = location.indexOf(":/");
        final int queryIndex = location.indexOf('?');
        String redirectPath;

        if ( protocolIndex > -1 && (queryIndex == -1 || queryIndex > protocolIndex) ) {
            redirectPath = location;
        } else {
            redirectPath = slingRequest.getResourceResolver().map(request, location) + ".html";
        }

        // include wcmmode=disabled to redirected url if original request also had that parameter
        //if (wcmModeIsDisabled) {
        //    redirectPath += ((redirectPath.indexOf('?') == -1) ? '?' : '&') + "wcmmode=disabled";
        //}

        response.sendRedirect(redirectPath);
    } else {
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
    return;
}
// set doctype
if (currentDesign != null) {
    currentDesign.getDoctype(currentStyle).toRequest(request);
}

%><%= Doctype.fromRequest(request).getDeclaration() %>
<html <%= wcmModeIsPreview ? "class=\"preview\"" : ""%>>
<cq:include script="head.jsp"/>
<cq:include script="body.jsp"/>
</html>