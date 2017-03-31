package com.brands.core.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.Property;
import javax.jcr.PropertyIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.Value;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.chatbot.controllers.ChatbotController;
import com.brands.core.chatbot.models.ChatbotResponse;
import com.brands.core.models.Faq;
import com.brands.core.utils.WCMUtil;
import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;

public class FaqController {
	private static final Logger LOG = LoggerFactory
			.getLogger(ChatbotController.class);

	private String rootUrl;
	private String faqPageUrl;
	private String faqQuery;
	
	/**
	 * Constructor
	 * @param faqRootUrl - faq root admin page url
	 * @param faqPageUrl - site faq page
	 * @param faqQuery - faq search param
	 */
	public FaqController(String faqRootUrl, String faqPageUrl, String faqQuery){
		this.rootUrl = faqRootUrl;
		this.faqPageUrl = WCMUtil.getURL(faqPageUrl);
		this.faqQuery = StringEscapeUtils.escapeHtml(faqQuery);
	}
	
	/**
	 * Do search on FAQ pages.
	 * Returns a match if:
	 * 
	 * 1) FAQ admin component's question has query words
	 * @param queryMap
	 * @param builder
	 * @param resolver
	 */
	public ChatbotResponse doChatbotFaqSearch(Map<String, String> queryMap, QueryBuilder builder, ResourceResolver resolver){
		List<Object>faqResults = new ArrayList<Object>();
		int resultCount = 0; //to keep track of valid results
		
		//create query 
		Query query = builder.createQuery(PredicateGroup.create(queryMap), resolver.adaptTo(Session.class));
		SearchResult searchResult = query.getResult();
		List<Hit> searchResultList = searchResult.getHits();
		LOG.info("================== Running faq search with params - path: {}. Initial Search result count: {}", queryMap.get("path"), searchResultList.size());
	
		for(Hit hit : searchResultList){
			Faq result = generateFaqResult(hit, resolver);
			String searchResultQns = result.getTitle();
			searchResultQns = this.processFaqString(searchResultQns);
			String queryString = this.processFaqString(this.getFaqQuery());
			//LOG.info("--=-=-=-=--=-=-=-Do match search query: {} | search result title: {}", queryString, searchResultQns);

			/**
			 * if faq query does not match faq question, don't include
			 * filter invalid results. reject faqs without Questions
			 */
			if(StringUtils.isNotBlank(result.getTitle()) &&
					queryString.equalsIgnoreCase(searchResultQns)){
				faqResults.add(result);
				resultCount++;
			}
		}
		ChatbotResponse chatbotResponse = new ChatbotResponse();
		chatbotResponse.setResults(faqResults);
		chatbotResponse.setTotalResult(resultCount); 
		
		return chatbotResponse;
	}
	
	/**
	 * Process a Hit into FAQ model
	 * Similar to ChatbotController.generateChatbotResults()
	 * @param hit
	 * @param resolver
	 * @return
	 */
	public Faq generateFaqResult(Hit hit, ResourceResolver resolver){
		Faq faqModel = new Faq();
		try {
			Node hitNode = hit.getNode();
			Node hitNodeParent = hitNode.getParent(); 
			//Resource hitPageResource = resolver.resolve(hitNodeParent.getPath());
			//Page hitPage = hitPageResource.adaptTo(Page.class);
			
			String faqQns = "";
			String faqAns = "";
			if(hitNodeParent.hasNode("jcr:content/par/faq_admin_bw")){				
				Node faqAdminNode = hitNodeParent.getNode("jcr:content/par/faq_admin_bw");
				PropertyIterator propIt = faqAdminNode.getProperties();
				
				Property faqBulletsProp = null;
				while(propIt.hasNext()){
					Property prop = propIt.nextProperty();
					if(prop!=null){
						//get faq bullets
						if(prop.getName().equals("faq-ans-bullets_t")){
							faqBulletsProp = prop;
							//break;
						}
						if(prop.getName().equals("faq-ans_t")){
							//get faq answer
							faqAns = prop.getString();
							//break;
						}
						if(prop.getName().equals("faq-qns_t")){
							//get faq question
							faqQns = prop.getString();
							//break;
						}
					}
				}
				
				List<String>faqBullets = new ArrayList<String>();
				if(faqBulletsProp != null){
					Value[] valArr = faqBulletsProp.getValues();
					if(valArr != null){
						for(Value val : valArr){
							String valStr = val.getString();
							faqBullets.add(valStr);
						}
						faqModel.setBulletList(faqBullets);
					}
				}
	
				faqModel.setTitle(faqQns);
				faqModel.setContent(faqAns);
			}
			
			return faqModel;
		} catch (RepositoryException e) {
			try {
				LOG.error("Repository error encountered when getting faq data for: ", hit.getPath(), e);
			} catch (RepositoryException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return faqModel;
		} catch (Exception e){
			LOG.error("Generic error encountered when generating chatbot (faq) result: ", e);
			return faqModel;
		}
	}
	
	/**
	 * Process strings so that AEM content and search query can match
	 * Remove question marks
	 * Replace ’ with '
	 * Replace high ASCII characters with empty space
	 * trim
	 * @return
	 */
	public String processFaqString(String faqString){
		if(StringUtils.isNotBlank(faqString)){
			//trim to remove initial leading/trailing spaces
			faqString = faqString.trim();
			faqString = StringEscapeUtils.unescapeHtml(faqString);
			
			//remove question marks
			if(faqString.charAt(faqString.length()-1) == '?') faqString = faqString.substring(0, faqString.length() -1);
			
			//replace apostrophes with single quote
			faqString = faqString.replaceAll("’", "'");
			//replace â as ' due to encoding error when passed over url (try to avoid uncomment this because other languages will use this character)
		    //faqString = faqString.replaceAll("â", "'");
			
			//replace high ASCII characters with empty space
			faqString = faqString.replaceAll("[^\\x00-\\x7f]", StringUtils.EMPTY);
			
			//trim
			faqString = faqString.trim();
		}
		return faqString;
	}
	
	/**
	 * Returns the root admin page url
	 * @return
	 */
	public String getRootUrl() {
		return rootUrl;
	}
	public void setRootUrl(String rootUrl) {
		this.rootUrl = rootUrl;
	}
	public String getFaqPageUrl() {
		return faqPageUrl;
	}

	public void setFaqPageUrl(String faqPageUrl) {
		this.faqPageUrl = faqPageUrl;
	}

	public String getFaqQuery() {
		return faqQuery;
	}

	public void setFaqQuery(String faqQuery) {
		this.faqQuery = faqQuery;
	}
}
