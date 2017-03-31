package com.brands.core.dao;

import java.util.Locale;
import java.util.Map;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Basic;
import com.brands.core.utils.WCMUtil;
import com.day.cq.wcm.api.Page;

public class BasicDaoImpl implements BasicDao{

	@Override
	public Basic getBasicPageProperties(Page brandPage, Boolean isAuthor,
			SlingHttpServletRequest slingRequest) {
		// TODO Auto-generated method stub
		
		 String basicOverview = WCMUtil.getPagePropertyValue(brandPage, "jcr:description");
		 String basicPageTitle = brandPage.getPageTitle();
		 Locale locale = brandPage.getLanguage(true);
		 Map<String, String> basicTagsKeywordsMap = WCMUtil.getTagMapList(brandPage, locale, "cq:tags");
		 
		 Basic basic = new Basic();
		 basic.setBasicOverview(basicOverview);
		 basic.setBasicPageTitle(basicPageTitle);
		 basic.setBasicTagsKeywordsMap(basicTagsKeywordsMap);
		 
		 return basic;
	}

}
