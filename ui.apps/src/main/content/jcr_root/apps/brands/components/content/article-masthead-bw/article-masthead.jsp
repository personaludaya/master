<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils"%>

<%
Locale article_locale = currentPage.getLanguage(true);
String pageTitle = currentPage.getPageTitle();
String publishedDate = pageProperties.get("published-date", "");
publishedDate = StringUtil.formatDate(publishedDate, article_locale);
%>

<c:set var="varPageTitle" value="<%= pageTitle  %>"/>
<c:set var="varPublishedDate" value="<%= publishedDate  %>"/>

<h1 class="secondary-color text-center h1-small">${varPageTitle}</h1>
<h5 class="secondary-color">${varPublishedDate}</h5>