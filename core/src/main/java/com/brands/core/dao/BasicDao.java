package com.brands.core.dao;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Basic;
import com.day.cq.wcm.api.Page;

public interface BasicDao {
	
	public Basic getBasicPageProperties(Page brandPage, Boolean isAuthor, SlingHttpServletRequest slingRequest);

}
