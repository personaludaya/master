<%--
  Top Bar Header component
  Consists of: Country selector, Language Selector
  ==============================================================================
  Requirements:
  1. Country Selector: When the end-user selects another country from the list, the system will redirect them to the specific BW locale homepage
  2. Language Selector: The field will be featured when the site have more than 1 lanaguage

--%>
<%@include file="/apps/brands/global/global.jsp" %>
<% 
//String rootPath = ConfigUtil.getProperty(resource, globalProperties, "brands.rootpath");
String rootPath = pageProperties.getInherited("root-path", "");
Page rootPage = null;
Page countryRootPage = null;
Iterator<Page> countryPages = null;
Iterator<Page> languagePages = null;
HashMap<String, String> countryPageMap = new HashMap<String, String>();
HashMap<String, String> languagePageMap = new HashMap<String, String>();
String selectedPageTitle = "";
String selectPagePath = "";
String selectedLanguageTitle = "";

//country
if (!StringUtil.isEmpty(rootPath)) {
	rootPage = pageManager.getPage(rootPath);
	if (rootPage != null)
		countryPages = rootPage.listChildren(new PageFilter(request));
}
if (countryPages != null) {
	while (countryPages.hasNext()) {
		Page countryPage = countryPages.next();
		String countryTitle = countryPage.getTitle();
		String countryPagePath = WCMUtil.getURL(countryPage.getPath(), isAuthor);
		countryPagePath = WCMUtil.getURL(countryPagePath, isAuthor);
		countryPageMap.put(countryPagePath, countryTitle);
	}
}

// selected country
Iterator cpm = countryPageMap.entrySet().iterator();
while (cpm.hasNext()) {
    Map.Entry pair = (Map.Entry)cpm.next();
    String countryPagePath = pair.getKey().toString();
    countryPagePath = countryPagePath.replace(".html", "");
    if (currentPage.getPath().startsWith(countryPagePath)) {
    	selectedPageTitle = pair.getValue().toString();
    	selectPagePath = countryPagePath;
		break;	
	}
}

// language
if (!StringUtil.isEmpty(selectPagePath)) {
	countryRootPage = pageManager.getPage(selectPagePath);
	if (countryRootPage != null)
		languagePages = countryRootPage.listChildren(new PageFilter(request));
}
if (languagePages != null) {
	if (languagePages.hasNext()) {
		while (languagePages.hasNext()) {
			Page languagePage = languagePages.next();
			String languageTitle = languagePage.getTitle();
			String languagePagePath = WCMUtil.getURL(languagePage.getPath(), isAuthor);
			languagePagePath = WCMUtil.getURL(languagePagePath, isAuthor);
			languagePageMap.put(languagePagePath, languageTitle);
		}
	}
}

//selected language
Iterator lpm = languagePageMap.entrySet().iterator();
while (lpm.hasNext()) {
    Map.Entry pair = (Map.Entry)lpm.next();
    String languagePagePath = pair.getKey().toString();
    languagePagePath = languagePagePath.replace(".html", "");
    if (currentPage.getPath().startsWith(languagePagePath)) {
    	selectedLanguageTitle = pair.getValue().toString();
		break;	
	}
}
%>
<c:set var="varSelectedPageTitle" value="<%= selectedPageTitle %>" />
<c:set var="varSelectedLanguageTitle" value="<%= selectedLanguageTitle %>" />
<c:set var="varCountryPageMap" value="<%= countryPageMap %>" />
<c:set var="varLanguagePageMap" value="<%= languagePageMap %>" />

<li>
	<div class="btn-group select-country"><a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${varSelectedPageTitle}<span class="caret"></span></a>
    	<ul class="dropdown-menu">
    		<c:forEach var="countryMap" items="${varCountryPageMap}">
				<li><a href="${countryMap.key}">${countryMap.value}</a></li>
			</c:forEach>
    	</ul>
  	</div>
</li>

<c:if test="${fn:length(varLanguagePageMap) > 1 }">
<li>
	<div class="btn-group select-language"><a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${varSelectedLanguageTitle}<span class="caret"></span></a>
    	<ul class="dropdown-menu">
      		<c:forEach var="languageMap" items="${varLanguagePageMap}">
				<li><a href="${languageMap.key}">${languageMap.value}</a></li>
			</c:forEach>
    	</ul>
  	</div>
</li>
</c:if>