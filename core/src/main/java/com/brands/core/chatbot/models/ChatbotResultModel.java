package com.brands.core.chatbot.models;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatbotResultModel{
	public static final String TYPE_PRODUCT = "product";
	public static final String TYPE_BUNDLE = "bundle";
	public static final String TYPE_BEMAGAZINE = "be-magazine";
	public static final String TYPE_INGREDIENTS = "ingredient";
	public static final String TYPE_FAQ = "faq";
	public static final String TYPE_COMPARE = "compare";
	
	public static final String TYPELABEL_PRODUCT = "Product";
	public static final String TYPELABEL_INGREDIENT = "Ingredient";
	public static final String TYPELABEL_ARTICLE = "Article"; //for bemagazine
		
	private String productid;
	private String type;
	private String typeLabel; //append to name to render the type
	private String pagetitle;
	private String pagedescr;
	private String pageimg;
	private String pageurl;
	private List<String>keywords;

	public String getProductId() {
		return productid;
	}
	public void setProductId(String productId) {
		this.productid = productId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTypeLabel() {
		return typeLabel;
	}
	public void setTypeLabel(String typeLabel) {
		this.typeLabel = typeLabel;
	}
	/**
	 * getNavTitle
	 * @return
	 */
	public String getPageTitle() {
		return pagetitle;
	}
	public void setPageTitle(String pageTitle) {
		this.pagetitle = pageTitle;
	}
	/**
	 * jcr:description
	 * @return
	 */
	public String getPageDescr() {
		return pagedescr;
	}
	public void setPageDescr(String pageDescr) {
		this.pagedescr = pageDescr;
	}
	/**
	 * prdt-img-path
	 * @return
	 */
	public String getPageImg() {
		return pageimg;
	}
	public void setPageImg(String pageImg) {
		this.pageimg = pageImg;
	}
	/**
	 * Page.getPath()
	 * @return
	 */
	public String getPageUrl() {
		return pageurl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageurl = pageUrl;
	}
	/**
	 * To clarify
	 * @return
	 */
	public List<String> getKeywords() {
		return keywords;
	}
	public void setKeywords(List<String> keywords) {
		this.keywords = keywords;
	}
}
