<%@include file="/apps/brands/global/global.jsp"%>
<%@ page import="com.day.cq.wcm.foundation.Placeholder" %>
<cq:text property="text" escapeXml="false"
        placeholder="<%= Placeholder.getDefaultPlaceholder(slingRequest, component, null)%>"/>