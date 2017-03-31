<%@include file="/apps/brands/global/global.jsp" %><%
%><%@ page import="com.day.cq.commons.Doctype,com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.day.cq.commons.Externalizer" %><%
%><%

// Setting CanonicalURL
final Externalizer externalizer = resourceResolver.adaptTo(Externalizer.class);
final String canonicalURL  = externalizer.absoluteLink(slingRequest, slingRequest.getScheme(), currentPage.getPath()) + ".html";

String pageDescription  = (pageProperties.get("meta-description") != null) ? pageProperties.get("meta-description").toString() : "";
String pageKeywords     = WCMUtil.getKeywords(currentPage, "seotags", resourceResolver);
String pageTitle    = currentPage.getPageTitle();
String title      = pageProperties.get("seo-title",currentPage.getTitle());
String langCode     = WCMUtil.getLanguageCode(currentPage.getPath());
String siteName         = I18nUtil.getLabel("sitename", currentPage, slingRequest, null);

String xs = Doctype.isXHTML(request) ? "/" : "";
String favIcon = imgPath + "/icons/favicon.ico";
//String favIcon = currentDesign.getPath() + "/favicon.ico";
if (resourceResolver.getResource(favIcon) == null) {
    favIcon = null;
}

String imagePath = imgPath + "/header/logo-fixed.png";  
String propertyImgInherited = pageProperties.getInherited("prop-img-path-inherited", "");
String propertyImgCurrent = pageProperties.get("prop-img-path-current", "");
String pageImg = pageProperties.get("img-path", "");

String propertyImg = imagePath;
if(!propertyImgCurrent.isEmpty()) {
    propertyImg = propertyImgCurrent;
} else if(!propertyImgInherited.isEmpty()) {
    propertyImg = propertyImgInherited;
} 
if (!pageImg.isEmpty()) {
    propertyImg = pageImg; 
}

String domain = slingRequest.getScheme() + "://" + slingRequest.getServerName();
%>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"<%=xs%>>
  <%-- [Page Name] | [Site Name] --%>
  <title><%= title %> - <%= siteName %></title>
  <link rel="canonical" href="<%= xssAPI.getValidHref(canonicalURL) %>" />
    <meta name="description" content="<%= xssAPI.encodeForHTMLAttr(properties.get("jcr:description", "")) %>"<%=xs%>>
  <% if(StringUtils.isNotEmpty(pageKeywords)) { %>
  <meta name="keywords" content="<%= xssAPI.encodeForHTMLAttr(pageKeywords) %>"<%=xs%>>
  <% } %>
    
  <% if (favIcon != null) { %>
  <link rel="icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>
  <link rel="shortcut icon" type="image/vnd.microsoft.icon" href="<%= xssAPI.getValidHref(favIcon) %>"<%=xs%>>
  <% } %>
  
  <link href="<%=cssPath%>/main.css" type="text/css" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="HandheldFriendly" content="True">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="robots" content="noodp, noydir">
  <meta name="google" content="notranslate">
  <%-- Twitter Cards --%>    
  <meta name="twitter:title" content="<%=title%>">
  <meta name="twitter:description" content="<%=xssAPI.encodeForHTMLAttr(properties.get("jcr:description", ""))%>">
  <meta name="twitter:image" content="<%=domain + propertyImg%>">
  <meta name="twitter:url" content="<%=domain + WCMUtil.getURL(currentPage.getPath(), isAuthor)%>">
  <meta name="twitter:site" content="@USERNAME">
  <meta name="twitter:creator" content="@USERNAME">
  <%-- Facebook Open Graph Tags --%>
  <meta property="og:type" content="article" />
  <meta property="og:title" content="<%=title%>" />
  <meta property="og:description" content="<%=xssAPI.encodeForHTMLAttr(properties.get("jcr:description", ""))%>" />
  <meta property="og:image" content="<%=domain + propertyImg%>" />
  <meta property="og:url" content="<%=domain + WCMUtil.getURL(currentPage.getPath(), isAuthor)%>" />
  <meta property="og:site_name" content="<%=siteName%>" />
  
  <%-- href lang --%>
  <%
  Map<String, String> mapDomains = new HashMap<String, String>();
  mapDomains.put("/sg/","http://www.brandsworld.com.sg");
  mapDomains.put("/hk/","http://www.brandsworld.com.hk");
  mapDomains.put("/my/","http://www.brandsworld.com.my");
  mapDomains.put("/mm/","http://www.brandsworld.com.mm");
  mapDomains.put("/tw/","http://www.brands.com.tw");
  mapDomains.put("/th/","http://www.brandsworld.co.th");
  
  Page sitePage = currentPage.getAbsoluteParent(1);
  if (null != sitePage) {
	  Iterator<Page> it = sitePage.listChildren();
      while (it.hasNext()) {
    	  Page rootPage = (Page)it.next();
    	  String rootPageName = rootPage.getName();
          String equivalentPagePath = currentPage.getPath().replace("/" + site_rootPath + "/", "/" + rootPageName + "/");
          
          Iterator<Page> it2 = rootPage.listChildren();          
          while (it2.hasNext()) {
              Page rootPage2 = (Page)it2.next();              
              String rootPageName2 = rootPage2.getName();
              String currentPageLocale = "";
              if (currentPage.getDepth() == 4) {
            	  currentPageLocale = currentPage.getAbsoluteParent(3).getName();
                  equivalentPagePath = equivalentPagePath.replace("/" + currentPageLocale, "/" + rootPageName2);            
              } else {
                  currentPageLocale = currentPage.getAbsoluteParent(3).getName();
            	  equivalentPagePath = equivalentPagePath.replace("/" + currentPageLocale + "/", "/" + rootPageName2 + "/");
              }

              try {
                  if (null != pageManager.getPage(equivalentPagePath)) {
                      String equivalentDomain = mapDomains.get("/" + rootPageName + "/");
                      if (rootPageName2.equals("en")) {
                      %>
  <link rel="alternate" href="<%=equivalentDomain%><%=WCMUtil.getURL(equivalentPagePath, isAuthor)%>" hreflang="en" />
                      <%
                      } else {
                      %>
  <link rel="alternate" href="<%=equivalentDomain%><%=WCMUtil.getURL(equivalentPagePath, isAuthor)%>" hreflang="<%=rootPageName2%>" />
                      <%
                      }
                  }
              } 
              catch (Exception e){}
    	  }
      }
  }
  %>  

  <cq:include script="/libs/wcm/core/components/init/init.jsp"/>
  <cq:include path="clientcontext" resourceType="cq/personalization/components/clientcontext"/>
    
  <cq:include script="dtm.jsp" />
        
  <script>  
  var isMinified = <%=isPublish%>;
  </script>
    
  <%-- custom head content --%>
  <cq:include script="misc-head-content.jsp" />
</head>