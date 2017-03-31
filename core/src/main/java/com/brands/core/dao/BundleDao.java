package com.brands.core.dao;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Bundle;
import com.day.cq.wcm.api.Page;

public interface BundleDao {

	public Bundle getBundlePageProperties(Page brandPage, Boolean isAuthor, SlingHttpServletRequest slingRequest);
}
