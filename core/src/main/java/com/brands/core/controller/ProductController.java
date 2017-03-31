package com.brands.core.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.brands.core.dao.ProductDaoImpl;
import com.brands.core.models.Product;
import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;

public class ProductController {
	private List<String> categoryList = new ArrayList<String>(); //cache
	private List<Product> productList = new ArrayList<Product>(); //cache
	private static final Logger LOG = LoggerFactory
			.getLogger(ProductController.class);
	
	//Constructors
	public ProductController(){}
	public ProductController(String productRootPath, Boolean isAuthor, SlingHttpServletRequest slingRequest){
		getProducts(productRootPath, isAuthor, slingRequest);
	}

	public Product getProuctPageProperties(Page productPage, Boolean isAuthor,SlingHttpServletRequest slingRequest) {
		ProductDaoImpl productDaoImpl = new ProductDaoImpl();
		return productDaoImpl.getProuctPageProperties(productPage, isAuthor, slingRequest);
	}

	public List<Product> getProducts(){
		return productList;
	}
	
	/**
	 * Invoked when Controller is constructed to pre-load products
	 * @param productRootPath
	 * @param isAuthor
	 * @param slingRequest
	 * @return
	 */
	private List<Product> getProducts(String productRootPath, Boolean isAuthor, SlingHttpServletRequest slingRequest){
		if(productList.isEmpty()){
			PageManager pageManager = slingRequest.getResourceResolver().adaptTo(PageManager.class);
			try{
				Page productRootPage = pageManager.getPage(productRootPath);
				if(productRootPage != null){
					ProductController ctrl = new ProductController();
					Iterator<Page> childList = productRootPage.listChildren();
					while(childList.hasNext()){
						Page productPage = childList.next();
						if(productPage.getProperties().get("cq:template", "").equals("/apps/brands/templates/product-page")){
							Product product = ctrl.getProuctPageProperties(productPage, isAuthor, slingRequest);
							if(product!= null) productList.add(product);
							
							//conveniently populate categoryList
							//check if list contains category
							Map<String, String> map = product.getPrdCategoryMap();
							Iterator<String> keysetIt = map.keySet().iterator();
							while(keysetIt.hasNext()) {
								String categoryTag = keysetIt.next().toString();
								String category = this.getCategoryFromTag(categoryTag, slingRequest);
								if(!categoryList.contains(category)) {
									categoryList.add(category);
								}
							}							
						}
					}
				}
			} catch(Exception e){
				LOG.error("Error trying to get products from path {}: ", productRootPath, e);
			}
		}
		return productList;
	}
	
	/**
	 * Util method to get Title from CategoryTag. Returns empty string if no tag configured
	 * @param tag
	 * @param slingRequest
	 * @return
	 */
	private String getCategoryFromTag(String tag, SlingHttpServletRequest slingRequest){
		String category = "";
		if(StringUtils.isNotBlank(tag)){
			TagManager tagManager = slingRequest.getResourceResolver().adaptTo(TagManager.class);
			if(tagManager != null){
				Tag categoryTag = tagManager.resolve(tag);
				if(categoryTag != null) {
					category = categoryTag.getTitle();
				}
			} else LOG.error("Failed to resolve TagManager");
		}		
		return category;
	}
	
	/**
	 * Get Available Category List
	 * @return
	 */
	public List<String> getAvailableCategories(){
		return categoryList;
	}
	
	/**
	 * Get Product List by Category
	 * @param category
	 * @param slingRequest
	 * @return
	 */
	public List<Product> getPrdtByCategory(String category, SlingHttpServletRequest slingRequest){
		List<Product> prdtByCatList = new ArrayList<Product>();
		if(!productList.isEmpty()){
			for(Product pdt : productList){
				if(pdt!= null){
					Map<String, String> map = pdt.getPrdCategoryMap();
					Iterator<String> keysetIt = map.keySet().iterator();
					while(keysetIt.hasNext()) {
						String categoryTag = keysetIt.next().toString();
						String prdtCat = this.getCategoryFromTag(categoryTag, slingRequest);
						if(prdtCat.equalsIgnoreCase(category)) prdtByCatList.add(pdt);
					}
				}
			}
		}
		return prdtByCatList;
		
	}
}

