package com.brands.core.dao;

import com.brands.core.models.ProductIngredient;
import java.util.*;

import com.day.cq.wcm.api.PageManager;
import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;

import com.brands.core.models.Product;
import com.brands.core.utils.I18nUtil;
import com.brands.core.utils.WCMUtil;
import com.day.cq.wcm.api.Page;

import javax.jcr.Node;

public class ProductDaoImpl implements ProductDao{

	@Override
	public Product getProuctPageProperties(Page productPage, Boolean isAuthor,SlingHttpServletRequest slingRequest) {
		// TODO Auto-generated method stub

		String prdPath = productPage.getPath();
		
		String prdRetailPrice = WCMUtil.getPagePropertyValue(productPage, "prdt-retail-price");
		String prdSpecialPrice = WCMUtil.getPagePropertyValue(productPage, "prdt-special-price");
		
		String prdRetailPriceTitle = WCMUtil.getPagePropertyValue(productPage, "prdt-retail-price-title");
		prdRetailPriceTitle = I18nUtil.getLabel(prdRetailPriceTitle, productPage, slingRequest, null);
		
		String prdSpecialPriceTitle = WCMUtil.getPagePropertyValue(productPage, "prdt-special-price-title");
		prdSpecialPriceTitle = I18nUtil.getLabel(prdSpecialPriceTitle, productPage, slingRequest, null);
		
		String prdPriceCurrency = WCMUtil.getPagePropertyValue(productPage, "prdt-price-currency");
		
		String prdECommerceUrl = WCMUtil.getPagePropertyValue(productPage, "prdt-ec-url");
		prdECommerceUrl = prdECommerceUrl == null ? "" : WCMUtil.getURL(prdECommerceUrl, isAuthor);
		
		String prdEcommerceCatId = WCMUtil.getPagePropertyValue(productPage, "prdt-ec-category-id");
		
		String prdPageTitle = productPage.getPageTitle();
		String prdImgPath = WCMUtil.getPagePropertyValue(productPage, "prdt-img-path");
		String prdImgAltText = WCMUtil.getPagePropertyValue(productPage, "prdt-img-alt_t");
		prdImgAltText = StringUtils.isEmpty(prdImgAltText) ? prdPageTitle : prdImgAltText;
		
		Locale locale = productPage.getLanguage(true);
		Map<String, String> prdLifeStageMap = WCMUtil.getTagMapList(productPage, locale, "prdt-life-stage");
		
		Map<String, String> prdCategoryMap = WCMUtil.getTagMapList(productPage, locale, "prdt-category");
		
		String prdDropletImgPath = WCMUtil.getPagePropertyValue(productPage,"prdt-droplet-img-path");
		
		boolean prdHideProductPrice = false;
		prdHideProductPrice = WCMUtil.getPagePropertyValue(productPage,"hide-prdt-price").equals("true");
		
		String prdBottleImgPath = WCMUtil.getPagePropertyValue(productPage, "prdt-bottle-img-path");
		String prdImgBottleImgAltText = WCMUtil.getPagePropertyValue(productPage, "prdt-bottle-img-alt_t");
		prdImgBottleImgAltText = StringUtils.isEmpty(prdImgBottleImgAltText) ? productPage.getPageTitle() : prdImgBottleImgAltText;
		
		String prdId = WCMUtil.getPagePropertyValue(productPage, "prdt-id");
		
		List<Node> ingredientConfigNodeList	= WCMUtil.getMultiCompositePropertyNodeList(productPage, "ingredient-text-config");
		List<ProductIngredient> prdIngredientList = new ArrayList<ProductIngredient>();

		for (Node configNode : ingredientConfigNodeList) {
			ProductIngredient prdIngr = new ProductIngredient();

			String ingrConfigPath = WCMUtil.getNodePropertyValue(configNode, "ingredient-page-path");
			String ingrConfigTxt = WCMUtil.getNodePropertyValue(configNode, "ingredient-text_t");
			String ingrConfigVol = WCMUtil.getNodePropertyValue(configNode, "ingredient-volume_t");

			if (StringUtils.isNotEmpty(ingrConfigPath)) {
				prdIngr.setIngredientPagePath(ingrConfigPath);
			}

			if (StringUtils.isNotEmpty(ingrConfigTxt)) {
				prdIngr.setIngredientTxt(ingrConfigTxt);
			}

			if (StringUtils.isNotEmpty(ingrConfigVol)) {
				prdIngr.setIngredientVolume(ingrConfigVol);
			}

			prdIngredientList.add(prdIngr);
		}

		//String[] prdIngredientPathList = WCMUtil.getPagePropertyValues(productPage, "ingredient-paths");
		Map<String, String> prdNutritionalInfo = WCMUtil.getTagMapList(productPage, locale, "nutritional-info");

		String prdPackageImgPath = WCMUtil.getPagePropertyValue(productPage, "prdt-pkg-img-path");
		String prdPackageImgAltTxt = WCMUtil.getPagePropertyValue(productPage, "prdt-pkg-img-alt_t");
		prdPackageImgAltTxt = StringUtils.isEmpty(prdPackageImgAltTxt) ? productPage.getPageTitle() : prdPackageImgAltTxt;

		Product product = new Product();
		product.setPrdPath(prdPath);
		product.setPrdRetailPrice(prdRetailPrice);
		product.setPrdSpecialPrice(prdSpecialPrice);
		product.setPrdRetailPriceTitle(prdRetailPriceTitle);
		product.setPrdSpecialPriceTitle(prdSpecialPriceTitle);
		product.setPrdPriceCurrency(prdPriceCurrency);
		product.setPrdEcommerceUrl(prdECommerceUrl);
		product.setPrdEcommerceCatId(prdEcommerceCatId);
		product.setPrdPageTitle(prdPageTitle);
		product.setPrdImgPath(prdImgPath);
		product.setPrdImgAltText(prdImgAltText);
		product.setPrdLifeStageMap(prdLifeStageMap);
		product.setPrdIngredientsList(prdIngredientList);
		product.setPrdNutritionalInformationMap(prdNutritionalInfo);
		product.setPrdDropletImgPath(prdDropletImgPath);
		product.setPrdHideProductPrice(prdHideProductPrice);
		product.setPrdImgBottleImgPath(prdBottleImgPath);
		product.setPrdImgBottleImgAltText(prdImgBottleImgAltText);
		product.setPrdPackageImgPath(prdPackageImgPath);
		product.setPrdPackageImgAltText(prdPackageImgAltTxt);
		product.setPrdCategoryMap(prdCategoryMap);
		product.setPrdId(prdId);
		return product;
	}

}
