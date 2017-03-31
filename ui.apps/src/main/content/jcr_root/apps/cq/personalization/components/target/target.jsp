<%@page session="false"%><%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ~
  ~ ADOBE CONFIDENTIAL
  ~ __________________
  ~
  ~  Copyright 2013 Adobe Systems Incorporated
  ~  All Rights Reserved.
  ~
  ~ NOTICE:  All information contained herein is, and remains
  ~ the property of Adobe Systems Incorporated and its suppliers,
  ~ if any.  The intellectual and technical concepts contained
  ~ herein are proprietary to Adobe Systems Incorporated and its
  ~ suppliers and are protected by trade secret or copyright law.
  ~ Dissemination of this information or reproduction of this material
  ~ is strictly forbidden unless prior written permission is obtained
  ~ from Adobe Systems Incorporated.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page import="org.apache.commons.lang.StringUtils,
                  com.day.cq.i18n.I18n,
                  com.day.cq.wcm.api.WCMMode,
                  com.day.cq.wcm.webservicesupport.ConfigurationManager" %><%!

private static final String LOCATION = "location";
private static final String PN_ENGINE = "cq:targetEngine";
private static final String DEFAULT_ENGINE = "cq";
private static final String TEST_AND_TARGET_ENGINE = "tnt";
private static final String CONTEXT_HUB_ENGINE="cq_contexthub";

%><%
I18n i18n = new I18n(slingRequest);

String location = properties.get(LOCATION, String.class);
if (StringUtils.isEmpty(location) && WCMMode.fromRequest(request) == WCMMode.EDIT) {
%><h3 class="cq-texthint-placeholder"><%= i18n.get("No location is set for this target") %></h3>
  <img src="/libs/cq/ui/resources/0.gif" class="cq-teaser-placeholder" alt=""><%
} else {
    // look up property on current component node...
    // (note that the value can be the empty string, meaning "inherit")
    String engine = properties.get(PN_ENGINE, String.class);
    
    if (StringUtils.isEmpty(engine)) {
        // ... or from inherited page property...
        engine = pageProperties.getInherited(PN_ENGINE, String.class);
    }
    if (StringUtils.isEmpty(engine)) {
        // ... or if not explicitly set, use tnt engine if t&t cloud service config is present
        final ConfigurationManager cfgMgr = resource.getResourceResolver().adaptTo(ConfigurationManager.class);
        String[] services = pageProperties.getInherited("cq:cloudserviceconfigs", new String[]{});
        if (cfgMgr != null && cfgMgr.getConfiguration("testandtarget", services) != null) {
            engine = TEST_AND_TARGET_ENGINE;
        }
    }

    String script = "engine_cq";
    if (StringUtils.isEmpty(engine)) {
        // ... otherwise default to "cq"
        // engine = DEFAULT_ENGINE;
        slingRequest.setAttribute("engine", CONTEXT_HUB_ENGINE);
    } else if (engine.equals("cq_campaign")) {
        script = "engine_cq_campaign";
    } else if (engine.startsWith("cq")) {
        slingRequest.setAttribute("engine", engine);
    } else {
        script = "engine_tnt";
    }
    pageContext.setAttribute("script",script);

%>

    <cq:include script="${script}.jsp" /><%
}
%>
