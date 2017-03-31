package com.brands.core.dao;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Bundle;
import com.brands.core.utils.I18nUtil;
import com.brands.core.utils.WCMUtil;
import com.day.cq.wcm.api.Page;

public class BundleDaoImpl implements BundleDao{

	@Override
	public Bundle getBundlePageProperties(Page brandPage, Boolean isAuthor,
			SlingHttpServletRequest slingRequest) {
		// TODO Auto-generated method stub
		
		String bundlePageTitle = brandPage.getPageTitle();
		String bundleImgPath = WCMUtil.getPagePropertyValue(brandPage, "bundle-img-path");
		String bundleImgAltText = WCMUtil.getPagePropertyValue(brandPage, "bundle-img-alt_t");
		bundleImgAltText = StringUtils.isEmpty(bundleImgAltText) ? bundlePageTitle : bundleImgAltText;
		
		String[] bundlePrdtPathsArr = WCMUtil.getPagePropertyValues(brandPage, "bundle-prdt-paths");
		String bundlePriceCurrency = WCMUtil.getPagePropertyValue(brandPage, "bundle-price-currency");
		boolean bundleHdiePrice = false;
		bundleHdiePrice = WCMUtil.getPagePropertyValue(brandPage, "hide-bundle-price").equals("true");
		String bundleEcCtaText = WCMUtil.getPagePropertyValue(brandPage, "bundle-ec-cta-text");
		
		String bundlePrdtId = WCMUtil.getPagePropertyValue(brandPage, "prdt-id");
		String bundleEcommerceUrl = WCMUtil.getPagePropertyValue(brandPage, "prdt-ec-url");
		bundleEcommerceUrl = WCMUtil.getURL(bundleEcommerceUrl, isAuthor);
		String bundleRetailPrice = WCMUtil.getPagePropertyValue(brandPage, "prdt-retail-price");
		String bundleSpecialPrice = WCMUtil.getPagePropertyValue(brandPage, "prdt-special-price");
		
		String bundleRetailPriceTitle = WCMUtil.getPagePropertyValue(brandPage, "prdt-retail-price-title");
		bundleRetailPriceTitle = I18nUtil.getLabel(bundleRetailPriceTitle, brandPage, slingRequest, null);
		
		String bundleSpecialPriceTitle = WCMUtil.getPagePropertyValue(brandPage, "prdt-special-price-title");
		bundleSpecialPriceTitle = I18nUtil.getLabel(bundleSpecialPriceTitle, brandPage, slingRequest, null);
		
		Bundle bundle = new Bundle();
		bundle.setBundlePageTitle(bundlePageTitle);
		bundle.setBundleImgPath(bundleImgPath);
		bundle.setBundleImgAltText(bundleImgAltText);
		bundle.setBundlePrdtPathsArr(bundlePrdtPathsArr);
		bundle.setBundlePriceCurrency(bundlePriceCurrency);
		bundle.setBundleHidePrdtPrice(bundleHdiePrice);
		bundle.setBundleCtaTextToEcommerce(bundleEcCtaText);
		bundle.setBundlePrdtId(bundlePrdtId);
		bundle.setBundleEcommerceUrl(bundleEcommerceUrl);
		bundle.setBundleRetailPrice(bundleRetailPrice);
		bundle.setBundleSpecialPrice(bundleSpecialPrice);
		bundle.setBundleRetailPriceTitle(bundleRetailPriceTitle);
		bundle.setBundleSpecialPriceTitle(bundleSpecialPriceTitle);
		
		return bundle;
	}

}
