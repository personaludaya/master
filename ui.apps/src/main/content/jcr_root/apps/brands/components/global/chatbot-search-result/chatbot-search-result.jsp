<%@include file="/apps/brands/global/global.jsp"%>
<%
%><%@ page
	import="com.brands.core.utils.*,
				org.apache.commons.lang.StringEscapeUtils,
				org.apache.commons.lang3.StringUtils,
				org.apache.commons.lang.WordUtils,
                java.util.*,
                com.day.cq.search.QueryBuilder,
                com.brands.core.chatbot.controllers.*,
                com.brands.core.chatbot.models.*,
                com.brands.core.servlets.ChatbotSearch"%>
<%
%>
<%
	String paramCountry = request.getParameter(ChatbotSearch.PARAM_COUNTRY);
	String paramLocale = request.getParameter(ChatbotSearch.PARAM_LOCALE);
	String paramSingleQuery = request.getParameter(ChatbotSearch.PARAM_SINGLE_QUERY);
	String[] searchParams = request.getParameterValues(ChatbotSearch.PARAM_QUERY);
	
	//convert single param 'q' into 'q[]'
	if(searchParams == null) {
		//check if single parameter (not array)
		if(StringUtils.isNotEmpty(paramSingleQuery)){
			String[] newSearchParams = new String[1];
			newSearchParams[0] = paramSingleQuery;
			searchParams = newSearchParams;
		}
	}

	//i18n
	String numberOfSearchResultsLabel = I18nUtil.getLabel(
			"numberofsearchresults", currentPage, slingRequest, null);

	String defImgPath = properties.get("search-default-img-path", "");

	//properties
	String searchPath = currentPage.getAbsoluteParent(3).getPath();

	//Init chatbot search
	ChatbotController ctrl = new ChatbotController(site_name, site_language);
	Map<String, String> queryMap = ctrl.createQueryMap(
			searchPath, searchParams, true);
	ChatbotResponse chatbotResponse = ctrl.doSearch(queryMap,
			resourceResolver.adaptTo(QueryBuilder.class),
			resourceResolver);
	int chatbotResultCount = 0;
	if(chatbotResponse != null) {
		chatbotResultCount = chatbotResponse.getTotalResult();
	}

	String escapedQuery = "";
	String displayQueryString = "";
	if(searchParams != null){
		for(String param : searchParams){
			String temp = StringEscapeUtils.escapeHtml(param);
			escapedQuery += temp + ";";
			temp = temp.replace("-", " ");
			temp = WordUtils.capitalizeFully(temp);
			displayQueryString += temp + ",";
		}
		if(displayQueryString.charAt(displayQueryString.length()-1) == ",".charAt(0)){
			//remove the last comma
			displayQueryString = displayQueryString.substring(0, displayQueryString.length()-1);
			escapedQuery = escapedQuery.substring(0, escapedQuery.length() -1);
		}
	}
	pageContext.setAttribute("escapedQuery", escapedQuery);
	//pageContext.setAttribute("search", search);
	String analyticsSubCat = ctrl.getAnalyticsSubCategory();
	pageContext.setAttribute("result", Integer.toString(chatbotResultCount));
	numberOfSearchResultsLabel = numberOfSearchResultsLabel.replace("##number##", Integer.toString(chatbotResultCount));
	numberOfSearchResultsLabel = numberOfSearchResultsLabel.replace("##query##", displayQueryString);
%>
<c:set var="varChatbotResponse" value="<%=chatbotResponse%>" />
<c:set var="varSearchQuery" value="<%= escapedQuery %>"/>
<c:set var="varNmberOfSearchResultsLabel" value="<%= numberOfSearchResultsLabel %>"/>

<div class="section-container search-result-container">
	<div class="search-result-count">${varNmberOfSearchResultsLabel}</div>
	<div class="background-container secondary-background-color">
		<div class="container-fluid">
			<%
			if(chatbotResponse.getResults() != null){
				for(Object resultObjModel : chatbotResponse.getResults()){
					ChatbotResultModel resultModel = (ChatbotResultModel) resultObjModel;
					if(StringUtils.isEmpty(resultModel.getPageImg())){
						resultModel.setPageImg(defImgPath);
					}
					%>
					<!-- search-result-item molecule start here-->
					<div class="search-result-item">
						<c:set var="varChatbotResult" value="<%=resultModel%>" />
						<div class="row">
							<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 hidden-xs">
								<img class="img-responsive"
									src="${varChatbotResult.pageImg }" alt title>
							</div>
							<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
								<c:set var="varProductType" value="<%=WordUtils.capitalizeFully(resultModel.getType())%>" />
								<button class="btn btn-form">
									<h5 class="search-item-title text-left">${varProductType }</h5>
								</button>
								<c:set var="varChatbotResultUrl" value="<%=WCMUtil.getURL(resultModel.getPageUrl())%>" />
								<a href="${varChatbotResultUrl }">
									<h4 class="search-item-title2 text-left">${varChatbotResult.pageTitle }</h4>
								</a>
								<p>${varChatbotResult.pageDescr }</p>
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
</div>

<%
	//for analytics::datalayer
	request.setAttribute("varSearchResultNo", Integer.toString(chatbotResultCount));
	request.setAttribute("varSearchQuery", escapedQuery);
	request.setAttribute("varSearchPrimaryCategory", "Chatbot");
	request.setAttribute("varSearchSubCategory", analyticsSubCat);
%>