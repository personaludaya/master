package com.brands.core.dao;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.General;
import com.day.cq.wcm.api.Page;

public interface GeneralDao {

	public General getGeneralPageProperties(Page brandPage, Boolean isAuthor,
			SlingHttpServletRequest slingRequest);
}
