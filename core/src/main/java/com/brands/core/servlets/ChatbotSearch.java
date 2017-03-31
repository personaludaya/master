package com.brands.core.servlets;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.servlet.ServletException;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.servlets.HttpConstants;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.chatbot.controllers.ChatbotController;
import com.brands.core.chatbot.models.ChatbotResponse;
import com.brands.core.chatbot.models.ChatbotResultModel;
import com.brands.core.controller.FaqController;
import com.brands.core.utils.WCMUtil;
import com.day.cq.commons.jcr.JcrConstants;
import com.day.cq.search.QueryBuilder;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;
import com.google.gson.Gson;

/**
 * Servlet registered by Path. 
 * Used for returning results to User-Chatbot Dialogue
 * Differs from ChatbotSearchResults which will use selectors
 * If params contain "faq" will execute FAQ search instead (returns only FAQ results)
 * If params contain "compare" will execute compare search instead (returns products + compare url)
 * else execute normal chatbot search (returns products + chatbot-search url)
 * @author eugeneng
 *
 */
@SuppressWarnings("serial")
@SlingServlet(paths = {"/services/chatbot/search"},
				methods = { HttpConstants.METHOD_GET },
				extensions={"json"})
public class ChatbotSearch extends SlingAllMethodsServlet{
	private static final Logger LOG = LoggerFactory
			.getLogger(ChatbotSearch.class);
	private static final String RESOURCETYPE_COMPAREBAR = "brands/components/product/product-comparison-bar-bw";
	private static final String PROPERTY_MAXCOLS = "prdt-compare-max";
	private static final String PROPERTY_PRDTECURL = "prdt-ec-url";
	
	public static final String TRIGGER_FAQSEARCH = "faq";
	public static final String TRIGGER_COMPARESEARCH = "compare";
	public static final String TRIGGER_PRICESEARCH = "price";

	public static final String PARAM_MAXCOL = "maxCol"; //for comparison
	public static final String PARAM_COUNTRY = "ctry"; //mandatory 
	public static final String PARAM_LOCALE = "loc"; //mandatory
	public static final String PARAM_QUERY = "q[]"; //mandatory
	public static final String PARAM_SINGLE_QUERY = "q"; 

	@Reference
	private QueryBuilder builder;
	
	@Override
    protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response)
            throws ServletException, IOException {
		//sample url: /services/chatbot/search.json?ctry=sg&loc=en&q%5B%5D=chicken&q%5B%5D=gift-bundle
		ChatbotResponse chatbotResponse = new ChatbotResponse();
		String paramCountry = request.getParameter(PARAM_COUNTRY);
		String paramLocale = request.getParameter(PARAM_LOCALE);
		String paramSingleQuery = request.getParameter(PARAM_SINGLE_QUERY);
		paramSingleQuery = StringEscapeUtils.escapeHtml(paramSingleQuery);
		String[] searchParams = request.getParameterValues(PARAM_QUERY);
		
		//triggers
		boolean isFaqSearch = false;
		boolean isCompareSearch = false;
		boolean isPriceSearch = false;
		
		//convert single param 'q' into 'q[]'
		if(searchParams == null) {
			//check if single parameter (not array)
			if(StringUtils.isNotEmpty(paramSingleQuery)){
				String[] newSearchParams = new String[1];
				newSearchParams[0] = paramSingleQuery;
				searchParams = newSearchParams;
			}
		}
		if(searchParams!=null) {
			LOG.info("ChatbotSearch Servlet - {} searchParams: {}", searchParams.length,  searchParams);
			for(String searchParam : searchParams){
				if(searchParam.equals(TRIGGER_FAQSEARCH)) isFaqSearch = true;
				else if(searchParam.equals(TRIGGER_COMPARESEARCH)) isCompareSearch = true;
				else if(searchParam.equals(TRIGGER_PRICESEARCH)) isPriceSearch = true;
			}
		}
		
		//Start main chatbot controller
		ChatbotController ctrl = new ChatbotController(paramCountry, paramLocale);
		String siteRootPath = ctrl.getRootUrl();
		PageManager pageManager = request.getResourceResolver().adaptTo(PageManager.class);
		Page localePage = pageManager.getPage(siteRootPath);
		Page siteRootPage = null;
		if(localePage!= null) siteRootPage = localePage.getAbsoluteParent(3);
		
		
		//determine which controller to call
		if(isFaqSearch && siteRootPage != null){
			String faqAdminUrl = "";
			String faqPageUrl = "";
			try{
				faqAdminUrl = (String) siteRootPage.getProperties().get("cbfaq-src-path");
				faqPageUrl = (String) siteRootPage.getProperties().get("faq-path");
			}catch(Exception e){
				LOG.error("Error while trying to determine FAQ Admin Page Root Path");
				chatbotResponse.setMessage("Unable to retrieve FAQs");
			}
			
			FaqController faqCtrl = new FaqController(faqAdminUrl, faqPageUrl, searchParams[0]);
			Map<String, String> queryMap = ctrl.createQueryMap(faqCtrl.getRootUrl(), searchParams, false);
			chatbotResponse = faqCtrl.doChatbotFaqSearch(queryMap, builder, request.getResourceResolver());
			
			//set search url
			String searchUrl = "";
			if(chatbotResponse != null){
				searchUrl =faqCtrl.getFaqPageUrl();
			}
			chatbotResponse.setViewMoreUrl(searchUrl + "#" + ChatbotController.CONST_CHATBOT); 
		} else if(siteRootPage != null){
			//execute normal chatbot search
			Map<String, String> queryMap = ctrl.createQueryMap(ctrl.getRootUrl(), searchParams, true);
	        chatbotResponse = ctrl.doSearch(queryMap, builder, request.getResourceResolver());	        
	        
	        //set search url
	        String searchUrl = "";
	        String compareUrl = "";
			if(chatbotResponse!= null){
				//return compare url instead, if query param contains compare trigger
				if(isCompareSearch){
					//set results type to compare
					String maxCols = "";
			        List<Object> results = chatbotResponse.getResults();
			        for(Object result : results){
			        	ChatbotResultModel cbResult = (ChatbotResultModel) result;
			        	cbResult.setType(ChatbotResultModel.TYPE_COMPARE);
			        }
					try{
						compareUrl = (String) siteRootPage.getProperties().get("compare-path");
					}catch(Exception e){
						LOG.error("Error while trying to get Compare Path");
						chatbotResponse.setMessage("Unable to get comparison path");
					}
					
					//get params for compare url
					String productPagePath = siteRootPage.getProperties().get("products-path", String.class);
					if(StringUtils.isNotEmpty(productPagePath)){
						maxCols = getMaxColsFrmProductList(productPagePath, request.getResourceResolver());
					}
					
					//construct compareUrl : compare.html?maxCol=4&q=<id1>&q=id2
					searchUrl = generateCompareUrl(compareUrl, maxCols, searchParams);
				} else if(isPriceSearch){
					chatbotResponse = doPriceSearch(chatbotResponse, request.getResourceResolver());
				} else searchUrl = ctrl.getSearchPageUrl(ctrl.getRootUrl(), searchParams, request.getResourceResolver());
				
			}
	        chatbotResponse.setViewMoreUrl(WCMUtil.getURL(searchUrl)); 
		} else chatbotResponse.setMessage("Missing parameters needed to determine site root");

        //write response
		Gson gson = new Gson();
		response.setContentType("application/json");
		response.getWriter().write(gson.toJson(chatbotResponse));
    }	

	//================================================================================
    // Main Trigger Methods
    //================================================================================
	/**
	 * Trigger: Price Search
	 * keyword: price
	 * replace pageurl with ec page path configured in product page
	 * if cannot find prdt-ec-url, leave pageurl as it is.
	 * @param cbResponse
	 * @param resolver
	 * @return
	 */
	private ChatbotResponse doPriceSearch(ChatbotResponse cbResponse, ResourceResolver resolver){
		List<Object> resultList = cbResponse.getResults();
		for(Object resultObj : resultList){
			ChatbotResultModel result = (ChatbotResultModel) resultObj;
			if(result!= null){
				String resultUrl = result.getPageUrl();
				//remove any hashtags if present so that resolver can resolve the url
				String[] splitArr = resultUrl.split("#");
				if(splitArr != null && splitArr.length > 0) resultUrl = splitArr[0];
				Resource resultRes = resolver.resolve(resultUrl.replace(".html", StringUtils.EMPTY));
				if(resultRes != null){
					Resource contentRes = resultRes.getChild(JcrConstants.JCR_CONTENT);
					try {
						Node contentNode = contentRes.adaptTo(Node.class);
						if(contentNode!= null && contentNode.hasProperty(PROPERTY_PRDTECURL)){
							String ecUrl = contentNode.getProperty(PROPERTY_PRDTECURL).getString();
							result.setPageUrl(WCMUtil.getURL(ecUrl) + "#" + ChatbotController.CONST_CHATBOT);
							
							//update response everytime a change is made
							cbResponse.setResults(resultList);
						}
					} catch (RepositoryException e) {
						LOG.warn("Failed to get prdt-ec-url from resultRes ({}). Using page path instead.", resultRes.getPath());
					} catch (Exception e){
						LOG.error("Exception while trying to get prdt-ec-url from resultRes ({})", resultRes.getPath(), e);
					}
				}
			}
		}
		return cbResponse;
	}
	
	//================================================================================
    // Support Methods
    //================================================================================
	/**
	 * Used to get maxCols from Product Listing page
	 * maxCols will be used to construct compare url
	 * Defaults to 4
	 * @param productPagePath
	 * @param resolver
	 * @return
	 */
	private String getMaxColsFrmProductList(String productPath, ResourceResolver resolver){
		String maxCols = "4"; //default to 4
		try{
			Resource parRes = resolver.resolve(productPath+ "/jcr:content/par");
			Iterator<Resource> resIt = parRes.getChildren().iterator();
			while(resIt.hasNext()){
				//check for comparison bar component so can get maxCols
				Resource resNode = resIt.next();
				if(resNode.getResourceType().equals(RESOURCETYPE_COMPAREBAR)){
					Node compareBarNode = resNode.adaptTo(Node.class);
					if(compareBarNode.hasProperty(PROPERTY_MAXCOLS)){
						maxCols = compareBarNode.getProperty(PROPERTY_MAXCOLS).getString();
					}
				}
			}
		} catch(Exception e){
			LOG.warn("Failed to get max cols from product listing page. Using default value of 4.");
		}
		return maxCols;
	}
	
	/**
	 * Construct compareUrl with inputs
	 * E.g. /compare.html?maxCol=4&q=<id1>,id2
	 * @param comparePath
	 * @param maxCols
	 * @param searchParams
	 * @return
	 */
	private String generateCompareUrl(String comparePath, String maxCols, String[] searchParams){
		String compareUrl = WCMUtil.getURL(comparePath);
		//add hashtag chatbot for analytics
		//add maxCol
		compareUrl = compareUrl +"?" +  PARAM_MAXCOL + "=" + maxCols; //compare url

		//add product ids from searchParams
		if(searchParams.length > 0){
			compareUrl += "&" + PARAM_SINGLE_QUERY + "="; 
			for(String searchParam : searchParams){
				if(!searchParam.equals(TRIGGER_COMPARESEARCH)) compareUrl+= searchParam + ",";
			}
		}
		
		if(compareUrl.charAt(compareUrl.length() -1) == ','){
			compareUrl = compareUrl.substring(0, compareUrl.length() -1);
		}
		
		
		return compareUrl+ "#" + ChatbotController.CONST_CHATBOT;
	}
}
