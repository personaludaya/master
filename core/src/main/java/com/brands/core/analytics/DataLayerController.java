package com.brands.core.analytics;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.jcr.Node;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.utils.WCMUtil;
import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;

public class DataLayerController {
	private static final Logger LOG = LoggerFactory
			.getLogger(DataLayerController.class);
	private ResourceResolver resolver;
	private Page currentPage;
	private Map<String, String> templateSectionMap = new HashMap<String, String>();
	private final String CONST_NAME_SEPARATOR = ":";
	private final String CONST_NIL = "nil"; //for landing pages
	private final String PAGEPROPERTY_CONTENTCATEGORY = "page-contentcategory"; //the page property to get value for analytics:pageinfo:content-category
	
	//Analytics Site Section
	private final String SECTION_DEFAULT = "brands";
	private final String SECTION_ABOUTUS = "about-us";
	private final String SECTION_BEMAGAZINE = "be-magazine";
	private final String SECTION_GIFTBUNDLE = "gift-bundle";
	private final String SECTION_PRODUCT = "products";
	private final String SECTION_WHATSNEW = "whats-new";
	
	/**
	 * Analytics Content Category
	 * Update 10-Mar-2017: Content categories to be pulled from cq:tags. Content categories below will be deprecated
	 */
//	private final String CATEGORY_CAMPAIGN = "campaign";
//	private final String CATEGORY_CONTESTS = "contests";
//	private final String CATEGORY_EVENTS = "events";
//	private final String CATEGORY_INGREDIENTS = "ingredients";
//	private final String CATEGORY_MILESTONES = "milestones";
//	private final String CATEGORY_NEWSLISTING = "news listing";
//	private final String CATEGORY_SOCIALRESP = "social responsibility";
//	private final String CATEGORY_LISTING = "listing"; //for any content pages that is not ingredients and not a product under product listing
	
	private final String TEMPLATE_BEMAGAZINE = "/apps/brands/templates/bemagazine-page";
	private final String TEMPLATE_BUNDLE = "/apps/brands/templates/bundle-page";
	private final String TEMPLATE_PRODUCT = "/apps/brands/templates/product-page";
	
	public DataLayerController(Page currentPage, ResourceResolver resolver){
		this.resolver = resolver;
		this.currentPage = currentPage;
		//LOG.info("resolver : {} | currentPage : {}", resolver, currentPage);
		
		//populate mapping template-section
		templateSectionMap.put(TEMPLATE_BEMAGAZINE, SECTION_BEMAGAZINE);
		templateSectionMap.put(TEMPLATE_BUNDLE, SECTION_GIFTBUNDLE);
		templateSectionMap.put(TEMPLATE_PRODUCT, SECTION_PRODUCT);
	}
	
	/**
	 * Get Site Section for Analytics
	 * IDENTIFY by template
	 * - bemagazine, product, bundle
	 * ELSE CHECK by page path
	 * - content pages
	 * Use getPageInfoName to generate pageInfoName. Extra logic applies in there
	 * @return lowerCase
	 */
	public String getSiteSection(){
		String siteSection = "";
		//check template (identifiable templates: bemagazine, product, bundle)
		String template = currentPage.getProperties().get("cq:template", "");
		if(templateSectionMap.containsKey(template)){
			siteSection = templateSectionMap.get(template);
		} else {
			//use another method
			
			// DEFAULT for other content page
			siteSection = SECTION_DEFAULT;

			// for content page created under product
			List<String> prdtPossiblePathList = Arrays.asList("/" + SECTION_PRODUCT, SECTION_PRODUCT + "s/");
			if(isContainStr(currentPage.getPath(), prdtPossiblePathList)) {
				siteSection = SECTION_PRODUCT;
			}
			
			// for content page created under about us
			List<String> aboutusPossiblePathList = Arrays.asList("/about-us", "about-us/", "/aboutus", "aboutus/");
			if(isContainStr(currentPage.getPath(), aboutusPossiblePathList)) {
				siteSection = SECTION_ABOUTUS;
			}

			// for content page created under whats new
			List<String> whatsnewPossiblePathList = Arrays.asList("/whats-new", "whats-new/", "/whatsnew", "whatsnew/");
			if(isContainStr(currentPage.getPath(), whatsnewPossiblePathList)) {
				siteSection = SECTION_WHATSNEW;
			}
			
			//for content page: gift bundle (landing)
			List<String> giftbundlePathList = Arrays.asList("/gift-bundles", "gift-bundles/", "/gift-bundle", "gift-bundle/");
			if(isContainStr(currentPage.getPath(), giftbundlePathList)) {
				siteSection = SECTION_GIFTBUNDLE;
			}
			
			//for content page: be magazine (landing)
			List<String> bemagPossiblePathList = Arrays.asList("/article-listing", "article-listing/", "/articles-listing", "articles-listing/");
			if(isContainStr(currentPage.getPath(), bemagPossiblePathList)) {
				siteSection = SECTION_BEMAGAZINE;
			}			
		}
		
		return siteSection.toLowerCase();
	}
	
	/**
	 * Get Content Category for Analytics
	 * Use getPageInfoName to generate pageInfoName. Extra logic applies in there
	 * Logic Update 10-Mar-2017: Content categories to be pulled from cq:tags. No need for hardcoding of categories
	 * @return lowerCase
	 */
	public String getContentCategory(){
		String contentCategory = "";
		
		ValueMap propertyMap = currentPage.getProperties();
		if(propertyMap.containsKey(PAGEPROPERTY_CONTENTCATEGORY)){
			String[] contentCategoryTags = propertyMap.get(PAGEPROPERTY_CONTENTCATEGORY, String[].class);
			if(contentCategoryTags != null && contentCategoryTags.length > 0) {
				TagManager tagManager  = this.getResolver().adaptTo(TagManager.class);
				//get the tag object
				Tag contentCategoryTag = tagManager.resolve(contentCategoryTags[0]);
				//get the name of the tag
				if(contentCategoryTag != null) contentCategory = contentCategoryTag.getName();
			}
		}
		return contentCategory;
	}
		
	/**
	 * Get Content Title for Analytics
	 * Use getPageInfoName to generate pageInfoName. Extra logic applies in there
	 * - return page name
	 * @return lowerCase
	 */
	public String getContentTitle(){
		String contentTitle = "";
		contentTitle = currentPage.getName();		
		return contentTitle.toLowerCase();
	}

	public String getContentPostDate() {
		String contentPostDateStr = "";

		try {
			Node currentNode = currentPage.adaptTo(Node.class);
			Node contentNode = currentNode.getNode("jcr:content");
			// get created date at content page level
			contentPostDateStr = WCMUtil.getNodePropertyValue(contentNode, "jcr:created").toString();

			if(StringUtils.isNotEmpty(contentPostDateStr)) {
				SimpleDateFormat oldFmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX", Locale.ENGLISH);
				SimpleDateFormat newFmt = new SimpleDateFormat("yyyMMdd", Locale.ENGLISH);
				Date createdDate = oldFmt.parse(contentPostDateStr);
				contentPostDateStr = newFmt.format(createdDate);
			}

		} catch (Exception e) {
			LOG.error(e.getMessage());
		}

		return contentPostDateStr;
	}
	
	/**
	 * Convenient method to generate PageInfoName for Analytics
	 * - determines if page isLandingPage 
	 * - set content title as "nil" if isLandingPage
	 * @return siteSection:category:contentTitle
	 */
	public String getPageInfoName(){
		String siteSection = this.getSiteSection().replace(" ", "-");
		String category = this.getContentCategory().replace(" ", "-");
		String contentTitle = this.getContentTitle();
		
		if(isOrphanPage()) {
			//set content title nil if is orphan page
			contentTitle = this.CONST_NIL;
			siteSection = SECTION_DEFAULT;
			if(StringUtils.isEmpty(category)) {
				category = currentPage.getName();		
			}
		} else {
			if(StringUtils.isEmpty(category)) siteSection = SECTION_DEFAULT;
			if(isLandingPage()) contentTitle = this.CONST_NIL;
		}
		//for isolated cases where contentCategory = contentTitle, set contentTitle NIL
		if(contentTitle.equalsIgnoreCase(category)) contentTitle = this.CONST_NIL;
		
		return siteSection + this.CONST_NAME_SEPARATOR + category + this.CONST_NAME_SEPARATOR + contentTitle;
	}
	
	/**
	 * Check if it's a Landing Page (e.g. content/brands/sg/en/products)
	 * - content category same as page name
	 * - has child pages
	 * @return
	 */
	public boolean isLandingPage(){
		boolean isLandingPage = false;
		//if category same as current page name: possibly landing page
		if(this.getContentCategory().equalsIgnoreCase(currentPage.getName())){
			isLandingPage = true;
			if(currentPage != null){
				boolean hasChildPages = currentPage.listChildren().hasNext();
				//if has child pages, confirm landing page
				if(hasChildPages) isLandingPage = true;
				else isLandingPage = false;
			}
		}
		return isLandingPage;
	}
	
	/**
	 * Check if it's orphan page 
	 * - pages directly under Language page : page.getDepth() (content (1) > brands > sg > en > page)
	 * - page has no child pages
	 * @return
	 */
	public boolean isOrphanPage(){
		if(currentPage.getDepth() == 5){
			Iterator<Page> childPageIt = currentPage.listChildren();
			if(!childPageIt.hasNext()){
				return true;
			}
		}
		return false;
	}
	
	public ResourceResolver getResolver() {
		return resolver;
	}

	public void setResolver(ResourceResolver resolver) {
		this.resolver = resolver;
	}

	public Page getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Page currentPage) {
		this.currentPage = currentPage;
	}

	public static Boolean isContainStr(String toSearch, List<String> toFindList) {
		Boolean hasMatched = false;

		for(String toFind : toFindList) {
			hasMatched = toSearch.toLowerCase().contains(toFind.toLowerCase());

			if(hasMatched) {
				break;
			}
		}

		return hasMatched;
	}
	
}
