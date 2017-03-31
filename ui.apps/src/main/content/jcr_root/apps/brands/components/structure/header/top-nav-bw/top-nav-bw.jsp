<%--
  Top Navigation Header component
  Consists of: Logo, Navigation, CTA Button
  ==============================================================================
  Requirements:

--%>
<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang.StringUtils" %>
<% 
String ev5clickloc = "clickloc=topnav";
String topNavConfigPath = pageProperties.getInherited("top-nav-path", "");
String ctaPath = pageProperties.getInherited("top-nav-cta-path", "");
String ctaText = pageProperties.getInherited("top-nav-cta-text_t","");
boolean ctaOpenNewWin = pageProperties.getInherited("top-nav-cta-new-win", "").equals("true");
if (ctaText.isEmpty() && !ctaPath.isEmpty()) {
    Page ctaPage = pageManager.getPage(ctaPath);
    ctaText = (ctaPage==null) ? ctaText : ctaPage.getTitle();
}

String homeLblActiveStr = "";
String homeLabel = I18nUtil.getLabel("home", currentPage, slingRequest, null);
String homeLabelPath = pageProperties.getInherited("logo-path", "");

if(StringUtils.isNotEmpty(homeLabelPath)) {
    if(StringUtils.equalsIgnoreCase(currentPage.getPath(), homeLabelPath)) {
        homeLblActiveStr = "active";
    }
    homeLabelPath = WCMUtil.getURL(homeLabelPath, isAuthor);
    homeLabelPath += ("#" + ev5clickloc);
}

NodeIterator topNavChildNodes = null;
Resource topNavRes = (topNavConfigPath.isEmpty()) ? null : resourceResolver.resolve(topNavConfigPath + "/jcr:content/par");
if (topNavRes != null) {
    Node topNavNode = topNavRes.adaptTo(Node.class);
    topNavChildNodes = topNavNode.getNodes();
}

String componentTitle = component.getProperties().get("jcr:title", "");
%>
<c:set var="varComponentTitle" value="<%= componentTitle %>" />
<c:set var="varCtaPath" value="<%= WCMUtil.getURL(ctaPath, isAuthor) %>" />
<c:set var="varCtaText" value="<%= ctaText %>" />
<c:set var="varCtaOpenNewWin" value="<%= ctaOpenNewWin %>"/>
<c:if test="${varCtaOpenNewWin == 'true'}">
    <c:set var="varCtaOpenNewWinTarget" value="target=_blank"/>
</c:if>
<c:set var="varHomeLblActiveStr" value="<%= homeLblActiveStr %>" />
<c:set var="varHomeLabel" value="<%=homeLabel %>" />
<c:set var="varHomeLabelPath" value="<%= homeLabelPath %>" />

<!-- menu molecule start here-->
<div class="navbar" id="brands-menu-bar" role="navigation">
  <div class="navbar-header hidden-lg hidden-md hidden-sm">
    <button class="navbar-toggle collapsed btn-toggle-menu" data-toggle="collapse" data-target="#brands-menu" aria-expanded="false">
      <span class="sr-only">Brands Menu</span>
      <svg class="brands-icon icon-white icon-no-resize">
        <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-menu" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-menu"></use>
      </svg>
    </button>
    <cq:include path="logo-bw1" resourceType="brands/components/structure/header/logo-bw"/>
  </div>
  
  <div class="collapse navbar-collapse" id="brands-menu" style="background-image: url(<%=imgPath%>/template/mobile-nav-bg.jpg)">
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-12 col-md-12 col-sm-12 hidden-xs">
        <div class="top-bar-container">
          <cq:include path="top-bar-bw" resourceType="brands/components/structure/header/top-bar-bw"/>
        </div>
      </div>
    </div>  
    <div class="row">
      <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
        <cq:include path="logo-bw2" resourceType="brands/components/structure/header/logo-bw"/>
        <button class="btn btn-default pull-right hidden-lg hidden-md hidden-sm" id="closemenu">
          <svg class="brands-icon icon-white">
            <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-close" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-close"></use>
          </svg>
        </button>
      </div>
      <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
        <ul class="nav nav-brands nav-brands-sm navbar-nav">
          <li class="hidden-lg hidden-md hidden-sm ${varHomeLblActiveStr}"><a href="${varHomeLabelPath}">${varHomeLabel }</a></li>
          <%
          int i = 1;
          while(topNavChildNodes != null && topNavChildNodes.hasNext()){
            Node next = topNavChildNodes.nextNode();
            String resourceType = next.getProperty("sling:resourceType").getString();
            if(resourceType.equals("brands/components/admin/top-nav-admin-bw")){
                String navType = next.hasProperty("navigation-type") ? next.getProperty("navigation-type").getString() : "";
                String navTitle = next.hasProperty("cta-text_t") ? next.getProperty("cta-text_t").getString() : "";
                String navPath = next.hasProperty("cta-path") ? next.getProperty("cta-path").getString() : "";
                boolean navOpenNewWin = next.hasProperty("cta-open-new-win") ? next.getProperty("cta-open-new-win").getString().equals("true") : false;
                boolean navHideInDesktop = next.hasProperty("cta-hide-in-desktop") ? next.getProperty("cta-hide-in-desktop").getString().equals("true") : false;
                String hideInDesktopCssStr = "";
                String activeCssStr = "";
                if (navTitle.isEmpty() && !navPath.isEmpty()) {
                    Page navPage = pageManager.getPage(navPath);
                    if (navPage != null) {
                        navTitle = WCMUtil.getNavTitle(navPage);
                    }
                }

                if(StringUtils.isNotEmpty(navPath)) {
                    if(StringUtils.equalsIgnoreCase(currentPage.getPath(), navPath)) {
                        activeCssStr = "active";
                    }
                    navPath = WCMUtil.getURL(navPath, isAuthor);
                    navPath += "#"+ev5clickloc;
                }

                if(navHideInDesktop) {
                    hideInDesktopCssStr = "hidden-lg hidden-md hidden-sm";
                }
                %>
                <c:set var="varNavType" value="<%= navType %>" />
                <c:set var="varNavTitle" value="<%= navTitle %>" />
                <c:set var="varNavPath" value="<%= navPath  %>"/>
                <c:set var="varActiveCssStr" value="<%= activeCssStr %>" />
                <c:set var="varHideInDesktopCssStr" value="<%= hideInDesktopCssStr %>" />
                <c:if test="${varNavType == 'self-link'}">
                    <c:set var="varNavOpenNewWin" value="<%= navOpenNewWin  %>"/>
                    <li class="${varActiveCssStr} ${varHideInDesktopCssStr}"><a href="${varNavPath}" <c:out value="${varNavOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varNavTitle}</a></li>
                </c:if>
                <c:if test="${varNavType == 'display-panel'}">
                    <c:set var="varMenuCounter" value="<%= i %>"/>
                    <li class="${varActiveCssStr}"><a href="${varNavPath}" data-menu-id="menu${varMenuCounter}">${varNavTitle}</a></li>
                </c:if>
                <%
                if (navType.equals("display-panel")) i++;
            }
          }
          %>
        </ul>
      </div>
      <c:if test="${not empty varCtaPath}">
      <div class="col-lg-2 col-lg-2 col-md-2 col-sm-2 col-xs-12 onlinestorecontainer">
        <a class="btn btn-default btn-lg pull-right btn-block btn-onlinestore" href="${varCtaPath}" ${varCtaOpenNewWinTarget} data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"header:${varComponentTitle}","eventAction":"online-store","eventURL":"${varCtaPath}"}}}'>${varCtaText}</a>
      </div>
      </c:if>
    </div>
  	<div class="row">
      <div class="hidden-lg hidden-md hidden-sm col-xs-12">
        <div class="top-bar-container">
          <cq:include path="top-bar-bw" resourceType="brands/components/structure/header/top-bar-bw"/>
        </div>
      </div>
    </div>
  </div>
  </div>
  <cq:include path="chatbot-bw" resourceType="brands/components/structure/header/chatbot-bw"/>  
</div>

<!-- menu molecule start here-->
<cq:include script="stub-subnav.jsp" />