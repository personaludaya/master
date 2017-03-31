package com.brands.core.controller;

import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.dao.BundleDaoImpl;
import com.brands.core.models.Bundle;
import com.day.cq.wcm.api.Page;

public class BundleController {

	public Bundle getBundlePageProperties(Page brandPage, Boolean isAuthor,SlingHttpServletRequest slingRequest) {
		BundleDaoImpl bundleDaoImpl = new BundleDaoImpl();
		return bundleDaoImpl.getBundlePageProperties(brandPage, isAuthor, slingRequest);
	}
}
