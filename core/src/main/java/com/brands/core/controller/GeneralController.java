package com.brands.core.controller;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.dao.GeneralDaoImpl;
import com.brands.core.models.General;
import com.day.cq.wcm.api.Page;

public class GeneralController {

	public General getGeneralPageProperties(Page brandPage, Boolean isAuthor,SlingHttpServletRequest slingRequest) {
		GeneralDaoImpl generalDaoImpl = new GeneralDaoImpl();
		General general = new General();
		if(brandPage != null) general = generalDaoImpl.getGeneralPageProperties(brandPage, isAuthor, slingRequest);
		return general;
	}
}
