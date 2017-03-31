package com.brands.core.dao;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.General;
import com.brands.core.utils.WCMUtil;
import com.day.cq.wcm.api.Page;

public class GeneralDaoImpl implements GeneralDao{

	@Override
	public General getGeneralPageProperties(Page brandPage, Boolean isAuthor,
			SlingHttpServletRequest slingRequest) {
		// TODO Auto-generated method stub
		
		String genPageImgPath = WCMUtil.getPagePropertyValue(brandPage, "img-path");
		String genPageMobileImgPath = WCMUtil.getPagePropertyValue(brandPage, "img-mobile-path");
	    String genImgAltText = WCMUtil.getPagePropertyValue(brandPage, "img-alt_t");
	    genImgAltText = StringUtils.isEmpty(genImgAltText) ? brandPage.getPageTitle() : genImgAltText;
	    
	    General general = new General();
	    general.setGenPageImgPath(genPageImgPath);
	    general.setGenPageImgMobilePath(genPageMobileImgPath);
	    general.setGenPageImgAltText(genImgAltText);
	    
		return general;
	}

}
