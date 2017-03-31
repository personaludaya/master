<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
Locale bemag_locale = currentPage.getLanguage(true);
String pageTitle = currentPage.getPageTitle();
String publishedDate = pageProperties.get("published-date", "");
publishedDate = StringUtil.formatDate(publishedDate, bemag_locale);
String publishedBy = pageProperties.get("published-by", "");

String path = WCMUtil.getURL(currentPage.getPath(), isAuthor);
Locale locale = currentPage.getLanguage(true);
Map<String, String> basicTagsKeywordsMap = WCMUtil.getTagMapList(currentPage, locale, "cq:tags");

BasicController basicController = new BasicController();
Basic basic = new Basic();
basic = basicController.getBasicPageProperties(currentPage, isAuthor, slingRequest);
Map<String, String> beMagazineBasicMapTags = basic.getBasicTagsKeywordsMap();

boolean hideCategory = properties.get("hide-category", "").equals("true");

for (Map.Entry<String, String> entry : beMagazineBasicMapTags.entrySet() ) {
	String beMagazineKey = entry.getKey();
	String[] beMagazineKeys = beMagazineKey.split("/");
	beMagazineKey = beMagazineKeys[beMagazineKeys.length-1];
%>
<c:set var="varBeMagazineValue" value="<%= entry.getValue() %>"/>
<%
} 
%>

<c:set var="varPageTitle" value="<%= pageTitle %>"/>
<c:set var="varPublishedDate" value="<%= publishedDate %>"/>
<c:set var="varPublishedBy" value="<%= publishedBy %>"/>
<c:set var="varPath" value="<%= path %>"/>
<c:set var="varHideCategory" value="<%= hideCategory %>"/>

<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 col-lg-offset-2 col-md-offset-2 col-sm-offset-2 col-xs-offset-0">
  <c:if test="${varHideCategory == 'false'}">
    <c:if test="${varBeMagazineValue != null}">
  	<a href="${varPath}" class="btn btn-default btn-magazine-category">${varBeMagazineValue}</a>
    </c:if>
  </c:if>
  <h1 class="secondary-color text-left">${varPageTitle}</h1>
  <div class="row">
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
      <p class="pull-left">${varPublishedBy}</p>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
      <p class="pull-right">${varPublishedDate}</p>
    </div>
  </div>
</div>