package com.brands.core.analytics;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.analytics.models.UserProfileModel;
import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;

public class FormController {
	private static final Logger LOG = LoggerFactory
			.getLogger(FormController.class);
	private ResourceResolver resolver;
	private Page currentPage;
	private QueryBuilder builder;
	
	private final String CONST_SEPARATOR = ":";

	private String transactionId = "";

	public FormController(){
		
	}
	
	public FormController(Page currentPage, ResourceResolver resolver){
		this.resolver = resolver;
		this.currentPage = currentPage;
		this.builder = resolver.adaptTo(QueryBuilder.class);
	}
	
	/**
	 * Main method used to get Form Name required for form analytics
	 * Based on the assumption that thank-you page's parent is always the form page itself
	 * Analytics form name has the format: <jcr:title>:<page-name>
	 * @param path
	 * @return
	 */
	public String getAnalyticsFormNameFromPath(String path){
		String formName = "";
		PageManager pageManager = resolver.adaptTo(PageManager.class);
		if(pageManager != null){
			Page formPage = pageManager.getPage(path);
			
			if(formPage != null){
				String pageTitle = formPage.getTitle().trim();
				String pageName = formPage.getName().trim();
				
				return pageTitle + this.CONST_SEPARATOR + pageName;
			}
		}		
		return formName;
	}
	
	/**
	 * Get the submitted form data from /content/usergenerated.
	 * Assumes that Action Configuration > Content Path uses the form's page name
	 * e.g. /content/usergenerated/brands/<locale>/<language>/<page-name>/<auto generated>/
	 * @return
	 */
	public UserProfileModel getUserProfileData(){
		UserProfileModel userProfile = new UserProfileModel();
		String searchPath = currentPage.getParent().getPath().replace("/content/", "/content/usergenerated/");
		//LOG.info("====-=-=-==--=-==--=-=-==-=-=-=-=-=-=-=-==-- user profile search path: {} | transactionId: {}", searchPath, transactionId);
		if(StringUtils.isNotEmpty(transactionId)){
			Map<String, String> map = new HashMap<String, String>();
			map.put("type", "sling:Folder");
			map.put("path", searchPath);
			map.put("nodename",transactionId);
			Query query = builder.createQuery(PredicateGroup.create(map), resolver.adaptTo(Session.class));
			SearchResult searchResult = query.getResult();
			List<Hit> searchResultList = searchResult.getHits();
			//expecting only 1 result at most
			if(searchResultList != null && searchResultList.size() > 0){
				Hit hit = searchResultList.get(0);
				try {
					Resource hitNode = hit.getResource();
					ValueMap vm = hitNode.getValueMap();
					if(vm.containsKey(UserProfileModel.CONST_COUNTRY)){
						userProfile.setCustomerCountryCode((String) vm.get(UserProfileModel.CONST_COUNTRY));
					}
					if(vm.containsKey(UserProfileModel.CONST_DOB)){
						String age = userProfile.getAgeFromDate((String) vm.get(UserProfileModel.CONST_DOB), userProfile.DATE_FORMAT_FORMS);
						userProfile.setCustomerAge(age);
					}
					if(vm.containsKey(UserProfileModel.CONST_GENDER)){
						userProfile.setCustomerGender((String) vm.get(UserProfileModel.CONST_GENDER));
					}
					if(vm.containsKey(UserProfileModel.CONST_MARKETINGEMAILS)){
						
					}
					
				} catch (RepositoryException e) {
					LOG.error("Failed to resolve node from Hit: ", e);
				}
			}
		} else {
			LOG.warn("Unable to get User Profile Data because transactionId is empty.");
		}
		return userProfile;
	}
	
	//========================================
	// Getters Setters
	//========================================
	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	
}
