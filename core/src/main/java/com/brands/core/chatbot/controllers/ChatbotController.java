package com.brands.core.chatbot.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.analytics.DataLayerController;
import com.brands.core.chatbot.models.ChatbotResponse;
import com.brands.core.chatbot.models.ChatbotResultModel;
import com.brands.core.servlets.ChatbotSearch;
import com.brands.core.utils.WCMUtil;
import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;
import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;

public class ChatbotController {
	private static final Logger LOG = LoggerFactory
			.getLogger(ChatbotController.class);
	public static final String PATH_BRANDS_CONTENT = "/content/brands";
	public static final String PROPERTY_CHATBOT_TAG = "chatbot-tags";
	private static final String PROPERTY_CHATBOT_SEARCHPAGEURL = "cb-searchpage-path";
	private static final String PROPERTY_PRODUCTID = "prdt-id";
	private static final String CONST_MULTIVALUESEP = ";"; //for analytics
	public static final String CONST_CHATBOT = "chatbot"; //for appending to url for analytics
	
	private static final String TEMPLATE_PRODUCT = "/apps/brands/templates/product-page";
	private static final String TEMPLATE_BUNDLE = "/apps/brands/templates/bundle-page";
	private static final String TEMPLATE_BEMAGAZINE = "/apps/brands/templates/bemagazine-page";
	private static final String TEMPLATE_ADMIN = "/apps/brands/templates/admin-page";
	
	private static final String TAG_INGREDIENTS = "ingredients";
	
	private static final String SLINGRESOURCE_TYPE_FAQADMIN = "brands/components/admin/faq-admin-bw";
	
	private static final String DEFAULT_SEARCH_PARAM = "chatbot"; //to use in generating search query
	
	private String country;
	private String languageCode;
	private String rootUrl;
	private Map<String, String>resultTypeMap = new HashMap<String, String>();
	private Map<String, String>typeLabelMap = new HashMap<String, String>();
	private List<String>currentQueryParamList = new ArrayList<String>(); //used to keep track of keywords used
	
	public ChatbotController(String country, String languageCode){
		this.country = country;
		this.languageCode = languageCode;
		this.rootUrl = PATH_BRANDS_CONTENT + "/" + country + "/" + languageCode;
		
		//init resultTypeMap
		resultTypeMap.put(TEMPLATE_PRODUCT, ChatbotResultModel.TYPE_PRODUCT);
		resultTypeMap.put(TEMPLATE_BUNDLE, ChatbotResultModel.TYPE_BUNDLE);
		resultTypeMap.put(TEMPLATE_BEMAGAZINE, ChatbotResultModel.TYPE_BEMAGAZINE);
		resultTypeMap.put(TAG_INGREDIENTS, ChatbotResultModel.TYPE_INGREDIENTS); //match by tag contains ingredients
		//resultTypeMap.put(SLINGRESOURCE_TYPE_FAQADMIN, ChatbotResultModel.TYPE_FAQ); //match by template=admin, has component slingresource type
	
		typeLabelMap.put(ChatbotResultModel.TYPE_PRODUCT, ChatbotResultModel.TYPELABEL_PRODUCT);
		typeLabelMap.put(ChatbotResultModel.TYPE_INGREDIENTS, ChatbotResultModel.TYPELABEL_INGREDIENT);
		typeLabelMap.put(ChatbotResultModel.TYPE_BEMAGAZINE, ChatbotResultModel.TYPELABEL_ARTICLE);
	}
	
	/**
	 * Perform search based on queryMap provided
	 * @param queryMap
	 * @param builder
	 * @param resolver
	 * @return
	 */
	public ChatbotResponse doSearch(Map<String, String> queryMap, QueryBuilder builder, ResourceResolver resolver){
		List<Object> chatbotResults = new ArrayList<Object>();		
		int resultCount = 0; //to keep track of valid results
		
		//create query 
		Query query = builder.createQuery(PredicateGroup.create(queryMap), resolver.adaptTo(Session.class));
		SearchResult searchResult = query.getResult();
		List<Hit> searchResultList = searchResult.getHits();
		LOG.info("================== Running search with params - path: {}", queryMap.get("path"));

		for(Hit hit : searchResultList){
			ChatbotResultModel result = generateChatbotResult(hit, resolver);			
			//filter invalid results
			//Results without a type are invalid
			if(StringUtils.isNotEmpty(result.getType())) {
				chatbotResults.add(result);
				resultCount++;
			}
		}
		ChatbotResponse chatbotResponse = new ChatbotResponse();
		chatbotResponse.setTotalResult(resultCount); 
        
        //return result
        chatbotResponse.setResults(chatbotResults);
        
        return chatbotResponse;
	}
	
	/**
	 * Creates a Map of parameters for passing to search
	 * @param queryPath
	 * @param queryParams
	 * @param searchTag - true: search tag | false: ignore tags (currently for FAQ)
	 * @return
	 */
	public Map<String, String> createQueryMap(String queryPath, String[] queryParams, boolean searchTag){
		Map<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("type", "cq:PageContent");
		queryMap.put("path", queryPath);
		if(searchTag){
			//TODO remove this if don't want any results by default
			queryMap.put("1_property", PROPERTY_CHATBOT_TAG);
			
			//reset currentQueryParamList
			currentQueryParamList.clear();
			if(queryParams != null){
				int propValueCount = 1;
				for(String param : queryParams){
					//LOG.info("====================adding queryParam: {}", param);
					param = StringEscapeUtils.escapeHtml(param);
					currentQueryParamList.add(param);
					queryMap.put("1_property."+propValueCount+"_value", "%"+param+"%");
					propValueCount++;
				}
			} else {
				queryMap.put("1_property.1_value", "%"+DEFAULT_SEARCH_PARAM+"%");
			}
			queryMap.put("1_property.operation", "like");
		}
		queryMap.put("p.limit", "0"); //no limit to results	
		
		return queryMap;
	}
	
	/**
	 * Process a Hit into ChatbotResultModel
	 * @param hit
	 * @param resolver
	 * @return
	 */
	private ChatbotResultModel generateChatbotResult(Hit hit, ResourceResolver resolver){
		ChatbotResultModel model = new ChatbotResultModel();
		try {
			ValueMap map = hit.getProperties();
			Node hitNode = hit.getNode();
			Node hitNodeParent = hitNode.getParent(); 
			Resource hitPageResource = resolver.resolve(hitNodeParent.getPath());
			Page hitPage = hitPageResource.adaptTo(Page.class);
			String pageTemplate = hitPage.getProperties().get("cq:template", "");
			String pageTitle = hitPage.getPageTitle();
			//String pageDescr = processDataString(map.get(JcrConstants.JCR_DESCRIPTION));
			String metaDescr = processDataString(map.get("meta-description")); 
			String pageImg = processDataString(map.get("prdt-img-path")); //only for product page templates
			if(StringUtils.isBlank(pageImg)){
				pageImg = processDataString(map.get("img-path")); //to handle generic content pages img
			}
			String pageUrl = hitPage.getPath();
			
			//get productId from product page templates
			String productId = "";
			if(pageTemplate.equals(TEMPLATE_PRODUCT)){
				productId = (String) hitPage.getProperties().get(PROPERTY_PRODUCTID);
			}
			
			//get keywords which matched queryParam
			List<String> keywords = new ArrayList<String>();
			String[] chatbotTags = map.get(PROPERTY_CHATBOT_TAG, String[].class);
			boolean isValidResult = false;
			for(int i = 0; i < chatbotTags.length; i++){
				chatbotTags[i] = getCategoryFromTag(chatbotTags[i], resolver); 
				String tag = chatbotTags[i];
				for(String queryParam : currentQueryParamList){
					//LOG.info("====================== matching chatbotTag: {} | query: {}", tag, queryParam);
					if(tag.equalsIgnoreCase(queryParam)){
						//prevent duplicates
						if(!keywords.contains(queryParam)){
							keywords.add(queryParam);
						}
						isValidResult = true;
					} 
				}
			}
			//return immediately as invalid result
			if(!isValidResult) return model;
			
			if(StringUtils.isNotEmpty(productId)) model.setProductId(productId);
			model.setType(getResultType(hitPage, chatbotTags));
			model.setPageTitle(pageTitle);
			//model.setPageDescr(pageDescr);
			if(typeLabelMap.containsKey(model.getType())){
				model.setTypeLabel(typeLabelMap.get(model.getType()));
			} else {
				model.setTypeLabel("");
			}
			model.setPageDescr(metaDescr);
			model.setPageImg(pageImg);
			model.setPageUrl(WCMUtil.getURL(pageUrl) + "#" + CONST_CHATBOT);
			model.setKeywords(keywords);
			
			return model;
		} catch (RepositoryException e) {
			e.printStackTrace();
			return model;
		} catch (Exception e){
			LOG.error("Generic error encountered when generating chatbot result: ", e);
			return model;
		}
	}
	
	/**
	 * Determine the resultType from a Hit Page
	 * Possible types:
	 * product - page template: /apps/brands/templates/product-page
	 * bundle - page template: /apps/brands/templates/bundle-page
	 * be-magazine - page template: /apps/brands/templates/bemagazine-page
	 * faq - page template = admin-page; contains bw-faq-admin component (removed)
	 * ingredients - chatbot-tag contains ingredients
	 * 
	 * @param page
	 * @param chatbotTags
	 * @return
	 */
	public String getResultType(Page page, String[] chatbotTags){
		String resultType = "";
		String templateType = page.getProperties().get("cq:template", "");
		
		//try get resultType based on template
		resultType = (String)resultTypeMap.get(templateType);
		if(StringUtils.isNotEmpty(resultType)){
			return resultType;
		} 
		//try get resultType based on tag
		if(StringUtils.isEmpty(resultType)){
			if(chatbotTags != null && chatbotTags.length > 0){
				for(String tag: chatbotTags){
					if(tag.equalsIgnoreCase(TAG_INGREDIENTS)){
						return resultTypeMap.get(TAG_INGREDIENTS);
					}
				}
			}
		}
		return resultType;
	}
	
	/**
	 * Handle null and empty string. Trims string.
	 * @param data
	 * @return
	 */
	public static String processDataString(Object data){
		if(data != null){
			String dataStr = data.toString();
			if(StringUtils.isBlank(dataStr)){
				return StringUtils.EMPTY;
			} else {
				return dataStr.trim();
			}
		} else return StringUtils.EMPTY;
	}
	
	/**
	 * Gets the Chatbot Search Page Url that is configured in Home Page
	 * @param path (any page path) - used to find the root page
	 * @param queryMap 
	 * @param resolver
	 * @return
	 */
	public String getSearchPageUrl(String path, String[] queryMap, ResourceResolver resolver){
		String searchPagePath = "";
		String queryPrefix = ChatbotSearch.PARAM_QUERY; //i.e. q[]
		//url encode query param for search page url construction later
		try {
			queryPrefix = URLEncoder.encode(queryPrefix, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			LOG.warn("Failed to encode queryPrefix : {}" + queryPrefix);
		}
		queryPrefix = queryPrefix + "=";
		if(StringUtils.isNotBlank(path) && queryMap!= null && queryMap.length > 0){
			PageManager pageManager = resolver.adaptTo(PageManager.class);
			Page randomPage = pageManager.getPage(path);
			Page homePage = randomPage.getAbsoluteParent(3);
			ValueMap map = homePage.getProperties();
			searchPagePath = (String) map.get(PROPERTY_CHATBOT_SEARCHPAGEURL);
			
			//construct search page url with query param
			if(StringUtils.isNotEmpty(searchPagePath)){
				searchPagePath+=".html" + "?";
				for(String query : queryMap){
					searchPagePath+=queryPrefix+query+"&";
				}

				if(searchPagePath.charAt(searchPagePath.length()-1) == "&".charAt(0)){
					//remove the last character "&"
					searchPagePath = searchPagePath.substring(0, searchPagePath.length() -1);
				}
			}
		}
		return searchPagePath +"#" + ChatbotController.CONST_CHATBOT;
	}
	
	/**
	 * Return chatbot phrases as subcategory
	 * Exclude faq, compare and price triggers
	 * Concatenate query with ";"
	 * @return
	 */
	public String getAnalyticsSubCategory(){
		String subCat = "";
		List<String> queryList = this.getCurrentQueryParamList();
		List<String> paramExcludeList = Arrays.asList(ChatbotSearch.TRIGGER_COMPARESEARCH, ChatbotSearch.TRIGGER_FAQSEARCH, ChatbotSearch.TRIGGER_PRICESEARCH);
		for(String query : queryList){
			if(!DataLayerController.isContainStr(query, paramExcludeList)){
				subCat+=query + CONST_MULTIVALUESEP;
			}
		}
		if(StringUtils.isNotEmpty(subCat)){
			if(subCat.charAt(subCat.length() -1 )==';'){
				subCat = subCat.substring(0, subCat.length()-1);
			}
		}
		return subCat.trim();
	}
	
	/**
	 * Util method to get Title from CategoryTag. Returns empty string if no tag configured
	 * @param tag
	 * @param slingRequest
	 * @return
	 */
	private String getCategoryFromTag(String tag, ResourceResolver resolver){
		String category = "";
		if(StringUtils.isNotBlank(tag)){
			TagManager tagManager = resolver.adaptTo(TagManager.class);
			if(tagManager != null){
				Tag categoryTag = tagManager.resolve(tag);
				if(categoryTag != null) {
					category = categoryTag.getName();
				}
			} else LOG.error("Failed to resolve TagManager");
		}		
		return category;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getLanguageCode() {
		return languageCode;
	}

	public void setLanguageCode(String languageCode) {
		this.languageCode = languageCode;
	}

	public String getRootUrl() {
		return rootUrl;
	}

	public void setRootUrl(String rootUrl) {
		this.rootUrl = rootUrl;
	}

	public List<String> getCurrentQueryParamList() {
		return currentQueryParamList;
	}
	
}
