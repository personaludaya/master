package com.brands.core.utils;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.ResourceBundle;
import java.util.Locale;
import java.text.DateFormatSymbols;
import javax.jcr.Node;
import com.day.cq.i18n.I18n;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.i18n.ResourceBundleProvider;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class I18nUtil {
	private static final Logger LOG = LoggerFactory.getLogger(I18nUtil.class);
	private static final String I18N_ROOT_PATH = "/content/admin/<locale>/i18n/";
	private static final String JCR_TITLE = "jcr:content/jcr:title";
	private static final String FORMSDROPDOWNLIST_ROOT_PATH = "/content/admin/<locale>/forms/";
	
	//private static final Logger log = LoggerFactory.getLogger(I18nUtil.class);
	
	// example call
	// String label = I18nUtil.getLabel("key", currentPage, sling, new String[] {"first", "second"});
	// String label = I18nUtil.getLabel("key", currentPage, sling, null);
	public static String getLabel(String key, 
			Page currentPage, 
			SlingScriptHelper sling,
			String[] placeholders) {
		
		String label = "";
		
		try {
			ResourceBundleProvider rbp = sling.getService(ResourceBundleProvider.class);
			Locale pageLocale = currentPage.getLanguage(false);
			ResourceBundle resourceBundle = rbp.getResourceBundle(pageLocale);
			I18n i18n = new I18n(resourceBundle);
			
			if (key == null) return label;
			if (currentPage == null) return label;
			
			label = getLabelFromContent(currentPage, pageLocale, key);
			
			// else get from i18n folder under /apps/xxx/components/i18n
			if (i18n != null && StringUtil.isEmpty(label)) {
				label = i18n.get(key);
				if (placeholders != null) {
					// for placeholders, the placeholders will be {0}, {1}, {2} etc
					for (int i=0;i<placeholders.length;i++) {
						String placeholderNum = "{" + i + "}";
						label = label.replace(placeholderNum, placeholders[i]);
					}
				} 
			}
		}
		catch (Exception e) {
			LOG.error(e.getMessage());
		}
		
		return label;
	}
	
	// example call
	// String label = I18nUtil.getLabel("key", currentPage, slingRequest, new String[] {"first", "second"});
	// String label = I18nUtil.getLabel("key", currentPage, slingRequest, null);
	public static String getLabel(String key, 
						Page currentPage, 
						SlingHttpServletRequest slingRequest, 
						String[] placeholders) {
		
		String label = "";
		
		try {
			Locale pageLocale = currentPage.getLanguage(false);
			ResourceBundle resourceBundle = slingRequest.getResourceBundle(pageLocale);
			I18n i18n = new I18n(resourceBundle);

			if (key == null) return label;
			if (currentPage == null) return label;

			//label = getLabelFromContent(currentPage, pageLocale, key);
			
			// else get from i18n folder under /apps/xxx/components/i18n
			if (i18n != null && StringUtil.isEmpty(label)) {
				label = i18n.get(key);
				if (placeholders != null) {
					// for placeholders, the placeholders will be {0}, {1}, {2} etc
					for (int i=0;i<placeholders.length;i++) {
						String placeholderNum = "{" + i + "}";
						label = label.replace(placeholderNum, placeholders[i]);
					}
				} 
			}
		} 
		catch (Exception e) {
			LOG.error(e.getMessage());
		}
		
		return label;
	}

	/*
	public static String getLabel(String key, 
			Page currentPage, 
			SlingHttpServletRequest slingRequest, 
			String placeholder) {
		Locale pageLocale = currentPage.getLanguage(false);
		ResourceBundle resourceBundle = slingRequest.getResourceBundle(pageLocale);
		I18n i18n = new I18n(resourceBundle);
		
		String label = "";
		if (key == null) return label;
		if (currentPage == null) return label;
		
		label = getLabelFromContent(currentPage, pageLocale, key);
		
		if (i18n != null && StringUtil.isEmpty(label)) {
			label = i18n.get(key, placeholder);
		}
		
		return label;
	}*/
	
	private static String getLabelFromContent(Page currentPage, Locale pageLocale, String key) {
		String label = "";
		
		try {
	 		// try and resolve from content path
			PageManager pageManager = currentPage.getPageManager();
			String pageLanguageCode = pageLocale.getLanguage();
			String langRootPath = I18N_ROOT_PATH.replaceAll("<locale>", pageLanguageCode);
			
			
			if (pageManager != null) {
				Page langRootPage = pageManager.getPage(langRootPath);
				if (langRootPage != null) {
					Node langRootNode = langRootPage.adaptTo(Node.class);
					try {
						Node thisI18nNode = langRootNode.getNode(key);
						if (thisI18nNode != null) {
							label = WCMUtil.getNodePropertyValue(thisI18nNode, JCR_TITLE);
						}
					} catch (Exception e) {
						LOG.error(e.getMessage());
					}
				}
			}
		}
		catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return label;
	}
	
	public static Map<String, String> getFormDropDownList(Page currentPage, String key) {
		Map<String, String> dropDownListMap = new LinkedHashMap<String, String>();
		PageManager pageManager = currentPage.getPageManager();
		String pageLanguageCode = WCMUtil.getLanguageCode(currentPage.getPath());
		String langRootPath = FORMSDROPDOWNLIST_ROOT_PATH.replaceAll("<locale>", pageLanguageCode);
		if (pageManager != null) {
			Page langRootPage = pageManager.getPage(langRootPath);
			if (null != langRootPage) {
				Page keyPage = pageManager.getPage(langRootPath + key);
				LOG.info("keyPage: " + keyPage.getPath());
				if (null != keyPage) {
					Iterator<Page> it = keyPage.listChildren();
					while (it.hasNext()){
						Page childPage = (Page) it.next();
						dropDownListMap.put(childPage.getName(), childPage.getTitle());
					}
				}
			}
		}
		return dropDownListMap;
	}
	
	// date = dd/mm/yyyy
	public static String convertDate(String date, String dateFormatKey, Page currentPage, SlingHttpServletRequest slingRequest) {
		String returnString = "";
		String langCode = WCMUtil.getLanguageCode(currentPage.getPath());
		if (!StringUtil.isEmpty(date)) {
			String[] dateSplit = date.split("/");

			// convert month int into string if "en"
			try {
				String monthVal = dateSplit[1];
				if ("en".equals(langCode)) {
					DateFormatSymbols dfs = new DateFormatSymbols();
					String[] months = dfs.getMonths();
					dateSplit[1] = months[Integer.parseInt(monthVal)-1];
				}
			} catch (Exception e) {
				LOG.error(e.getMessage());
			}
			
			returnString = getLabel(dateFormatKey, currentPage, slingRequest, dateSplit);
		}
		return returnString;
	}
}
