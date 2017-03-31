package com.brands.core.controller;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.dao.BasicDaoImpl;
import com.brands.core.models.Basic;
import com.day.cq.wcm.api.Page;

public class BasicController {

	public Basic getBasicPageProperties(Page productPage, Boolean isAuthor,SlingHttpServletRequest slingRequest) {
		BasicDaoImpl basicDaoImpl = new BasicDaoImpl();
		Basic basic = new Basic();
		if(productPage !=null) basic= basicDaoImpl.getBasicPageProperties(productPage, isAuthor, slingRequest);
		return basic;
	}
}
