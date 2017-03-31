package com.brands.core.dao;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Product;
import com.day.cq.wcm.api.Page;

public interface ProductDao {

	public Product getProuctPageProperties(Page productPage, Boolean isAuthor, SlingHttpServletRequest slingRequest);
}
