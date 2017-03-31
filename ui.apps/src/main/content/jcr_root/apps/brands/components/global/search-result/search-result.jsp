<%@include file="/apps/brands/global/global.jsp" %><%
%><%@ page import="com.brands.core.utils.*,
                com.brands.search.*,
                com.day.cq.tagging.TagManager,
				com.day.cq.commons.date.DateUtil,
				org.apache.commons.lang.StringEscapeUtils,
                java.text.MessageFormat,
                java.util.*" %><%
%><%
final String SHOW_ALL_RESULTS			= "results";
final int 	 SEARCH_RESULTS_PER_PAGE	= 100;
final int 	 NUM_OF_PAGINATION 			= 4;

//i18n
String numberOfSearchResultsLabel = I18nUtil.getLabel("numberofsearchresults", currentPage, slingRequest, null);

String defImgPath = properties.get("search-default-img-path", null);

//properties
String searchPath = currentPage.getAbsoluteParent(3).getPath();
String[] searchInPaths = {searchPath};

//init com.day.cq.wcm.foundation.Search object and this will getParameter("q") 
Search search = new Search(slingRequest, searchInPaths);
search.setHitsPerPage(SEARCH_RESULTS_PER_PAGE);

//String escapedQuery = StringEscapeUtils.escapeEcmaScript(search.getQuery());
String escapedQuery = StringEscapeUtils.escapeHtml(search.getQuery());
pageContext.setAttribute("escapedQuery", escapedQuery);
pageContext.setAttribute("search", search);
TagManager tm = resourceResolver.adaptTo(TagManager.class);

Search.Result result = search.getResult();
int searchResultNo = 0;

try{
    if (result != null) {
		searchResultNo = (int)result.getTotalMatches();
    	if (searchResultNo > SEARCH_RESULTS_PER_PAGE) {
  			searchResultNo = SEARCH_RESULTS_PER_PAGE;
    	}
    }
} catch(Exception e) {
}
pageContext.setAttribute("result", result);

numberOfSearchResultsLabel = numberOfSearchResultsLabel.replace("##number##", Integer.toString(searchResultNo));
numberOfSearchResultsLabel = numberOfSearchResultsLabel.replace("##query##", escapedQuery);
%>

<c:set var="varResult" value="${result}"/>
<c:set var="varSearchResultNo" value="<%= searchResultNo %>"/>
<c:set var="varSearchQuery" value="<%= escapedQuery %>"/>
<c:set var="varNmberOfSearchResultsLabel" value="<%= numberOfSearchResultsLabel %>"/>

<c:choose> 
  <c:when test="${varSearchResultNo == 0}">
  
	<!-- search-result-container component start here-->
	<div class="search-result-count">${varNmberOfSearchResultsLabel}</div>
	<!-- search-result-container component end here-->
  
  </c:when>
  <c:otherwise>  	
  	<c:if test="${varResult != null }">
  	  <c:if test="${not empty result.hits}">

	<!-- search-result-container component start here-->
	<div class="search-result-count">${varNmberOfSearchResultsLabel}</div>
    <div class="background-container secondary-background-color">
      <div class="container-fluid">
		<% 
		String hitLastCss = "";
		
		for (Search.Hit ahit : result.getHits()) {
			Page hitPage = ahit.getResource().adaptTo(Page.class);
			
	        String resultImgPath = "";
	        String resultTitle = "";
	        String resultPrimaryTag = "";
	        String resultUrl = "";
	        String resultDescription = "";
			
			if (hitPage != null) {
				resultImgPath = WCMUtil.getPagePropertyValue(hitPage, "img-path");
				resultTitle = hitPage.getPageTitle();
				resultPrimaryTag = WCMUtil.getPrimaryTag(hitPage, site_locale, "cq:tags");
				resultUrl = WCMUtil.getURL(hitPage.getPath(), isAuthor);
				resultDescription = hitPage.getDescription();
				
                if (StringUtil.isEmpty(resultImgPath)) {
                    resultImgPath = defImgPath;
                }
		%>
		
		<c:set var="varResultImgPath" value="<%= resultImgPath %>"/>
		<c:set var="varResultTitle" value="<%= resultTitle %>"/>
		<c:set var="varResultPrimaryTag" value="<%= resultPrimaryTag %>"/>
		<c:set var="varResultUrl" value="<%= resultUrl %>"/>
		<c:set var="varResultDescription" value="<%= resultDescription %>"/>
		
		<!-- search-result-item molecule start here-->
        <div class="search-result-item">
          <div class="row">
            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 hidden-xs">
              <img class="img-responsive" src="${varResultImgPath}" alt="${varResultTitle}" title="${varResultTitle}">
            </div>
            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
              <c:if test="${not empty varResultPrimaryTag}">
              <a class="btn btn-form"><h5 class="search-item-title text-left">${varResultPrimaryTag}</h5></a>
              </c:if>
              <a href="${varResultUrl}"><h4 class="search-item-title2 text-left">${varResultTitle}</h4></a>
              <p>${varResultDescription}</p>
            </div>
          </div>
        </div>
        <!-- search-result-item molecule end here-->                    
        <%  
        	}
        }
        %>    
      </div>
    </div>
    <!-- search-result-container component end here-->
  	  
  	  </c:if>
  	</c:if>
  </c:otherwise>
</c:choose>

<%
//for analytics::datalayer
request.setAttribute("varSearchResultNo", searchResultNo);
request.setAttribute("varSearchQuery", escapedQuery);
request.setAttribute("varSearchPrimaryCategory", "Internal Search");
%>