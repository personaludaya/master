<%--
  Copyright 1997-2008 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Global WCM script.

  This script can be used by any other script in order to get the default
  tag libs, sling objects and CQ objects defined.

  the following page context attributes are initialized via the <cq:defineObjects/>
  tag:

    @param slingRequest SlingHttpServletRequest
    @param slingResponse SlingHttpServletResponse
    @param resource the current resource
    @param currentNode the current node
    @param log default logger
    @param sling sling script helper

    @param componentContext component context of this request
    @param editContext edit context of this request
    @param properties properties of the addressed resource (aka "localstruct")
    @param pageManager page manager
    @param currentPage containing page addressed by the request (aka "actpage")
    @param resourcePage containing page of the addressed resource (aka "myPage")
    @param pageProperties properties of the containing page
    @param component current CQ5 component
    @param designer designer
    @param currentDesign design of the addressed resource  (aka "actdesign")
    @param resourceDesign design of the addressed resource (aka "myDesign")
    @param currentStyle style of the addressed resource (aka "actstyle")

  ==============================================================================

--%><%@page session="false" import="javax.jcr.*,
        org.apache.sling.api.resource.Resource,
        org.apache.sling.api.resource.ValueMap,
        org.apache.sling.settings.SlingSettingsService,
        com.day.cq.commons.inherit.InheritanceValueMap,
        com.day.cq.wcm.commons.WCMUtils,
        com.day.cq.wcm.api.Page,
        com.day.cq.wcm.api.PageFilter,
        com.day.cq.wcm.api.NameConstants,
        com.day.cq.wcm.api.PageManager,
        com.day.cq.wcm.api.designer.Designer,
        com.day.cq.wcm.api.designer.Design,
        com.day.cq.wcm.api.designer.Style,
        com.day.cq.wcm.api.components.ComponentContext,
        com.day.cq.wcm.api.components.EditContext,
        com.day.cq.wcm.api.WCMMode,
        com.day.cq.wcm.api.PageFilter,
        com.day.cq.wcm.foundation.Placeholder,
        java.util.*,
        java.text.*,
        com.brands.core.utils.*,
        org.apache.commons.collections.IteratorUtils"
%><%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0" %><%
%><%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %><%
%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
%><%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%
%><%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%
%><cq:defineObjects /><%

// add more initialization code here
String designPath	= (currentDesign == null) ? designer.getDesignPath(currentPage) : currentDesign.getPath();
String assetPath	= designPath + "/clientlib-site";
String jsPath    	= assetPath + "/js";
String cssPath   	= assetPath + "/css";
String imgPath   	= assetPath + "/images";
String svgIconPath	= imgPath + "/icons/symbol-defs.svg";
String bkgrdImgPath	= imgPath + "/templates/";

String ANALYTICS_BODY = "body";

String CQ_dateFormat = "dd MMM yyyy";
SimpleDateFormat sdf = new SimpleDateFormat(CQ_dateFormat);

PageFilter pageFilter = new PageFilter();

//is author mode
boolean isAuthor = false;
if (WCMMode.fromRequest(request) == WCMMode.EDIT || WCMMode.fromRequest(request) == WCMMode.DESIGN) {
    isAuthor = true;
}

boolean isPreview = false;
if (WCMMode.fromRequest(request) == WCMMode.PREVIEW) {
    isPreview = true;
}

boolean isPublish = false;
if (WCMMode.fromRequest(request) == WCMMode.DISABLED) {
	isPublish = true;
}

String globalProperties = "/etc/designs/brands/properties/global.properties";
// check runmodes
Set<String> runmodes = sling.getService(SlingSettingsService.class).getRunModes();
if (runmodes.contains("author")) {
	globalProperties = "/etc/designs/brands/properties/global-author.properties";
}

String site_language	= "";
Locale site_locale      = null;
String site_rootPath	= "";
String site_name        = "";
String site_ctry        = "";
String site_lang        = "";
if (null != currentPage && currentPage.getDepth() > 3) {
	site_language 	= pageProperties.getInherited("jcr:language", "en");
	site_locale 	= currentPage.getLanguage(true);
    try {
    	site_rootPath = currentPage.getAbsoluteParent(2).getName();
    }
    catch(Exception e) { }
    try {
    	site_name = currentPage.getAbsoluteParent(2).getName();
    }
    catch(Exception e) { }
    if (!StringUtil.isEmpty(site_name)) {
        site_ctry = site_name;
        site_lang = site_language.substring(0, 2);
    }
    if (site_locale.toString().equalsIgnoreCase("in_ID")) {
    	site_locale = new Locale("id_ID");
    }
}
%>
<c:set var="varAnalyticsBody" value="<%= ANALYTICS_BODY %>"/>
<%
%><%//Developer's note: Please ensure that this always remain as the last line; no empty newlines beyond %>