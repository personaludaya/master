<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.sling.commons.json.*,
            org.apache.sling.commons.json.io.JSONWriter,
            	com.brands.core.models.*,
                	com.brands.core.controller.*,
                	com.day.cq.search.*,
                	com.day.cq.search.result.*,
                	com.day.cq.tagging.Tag,
					com.day.cq.tagging.TagManager,
					java.util.*" %>

<%@page contentType="application/json;charset=utf-8" %>
<%
String prdtPath = properties.get("path-to-product", "");
String[] contentSignpostPathArr = properties.get("content-signpost-paths", String[].class);
String contentSignpostsPostion = properties.get("content-singposts-position", "3");
int iContentSignpostsPostion = Integer.parseInt(contentSignpostsPostion);

String viewAllLabel = I18nUtil.getLabel("viewall", currentPage, slingRequest, null);
String hideAllLabel = I18nUtil.getLabel("hideall", currentPage, slingRequest, null);

String productCategoryComponentName = component.getProperties().get("jcr:title", "");

JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();

writer.key("ourProducts").array();

%>

<c:set var="varContentSignpostPathArr" value="<%= contentSignpostPathArr  %>"/>
<c:set var="varProductCategoryComponentName" value="<%= productCategoryComponentName  %>"/>

<%
		Map<String, String> searchMap = new HashMap<String, String> ();
	    searchMap.put("path", prdtPath);
	    searchMap.put("type", "cq:Page");
	    searchMap.put("1_property", "jcr:content/cq:template");
		searchMap.put("1_property.1_value", "/apps/brands/templates/product-page");
	    searchMap.put("p.limit", "-1");
	    List<Hit> hits = QueryUtil.searchGetHits(resourceResolver, searchMap);
	    
	    int prdtSignpostCount = 0;
	    int contentSignpostCount = 0;
	    
	    Map<String, String> sortProductCategoryMap = new HashMap<String, String> ();
	    
	    List<ArrayList<String>> namesAndNumbers = new ArrayList<ArrayList<String>>();
	    
	    for (Hit hit : hits) {
	    	Page filterProductPage = hit.getResource().adaptTo(Page.class);
			ProductController filterProductController = new ProductController();
			Product filterProduct = new Product();
			filterProduct = filterProductController.getProuctPageProperties(filterProductPage, isAuthor, slingRequest);
			
			Map<String, String> filterPrdtCategoryMapTags = filterProduct.getPrdCategoryMap();
			
			String filterPrdtCategoryTagName = "";
			if(filterPrdtCategoryMapTags != null && filterPrdtCategoryMapTags.size() > 0){
				for (Map.Entry<String, String> entry : filterPrdtCategoryMapTags.entrySet() ) {
	     		     filterPrdtCategoryTagName = entry.getValue();
				}
			}
			namesAndNumbers.add(new ArrayList<String>(Arrays.asList(filterPrdtCategoryTagName, filterProductPage.getPath())));
	    }
	    
	    Collections.sort(namesAndNumbers, new Comparator<ArrayList<String>>() {    
	        @Override
	        public int compare(ArrayList<String> o1, ArrayList<String> o2) {
	            return o1.get(0).compareTo(o2.get(0));
	        }               
		});
	    
	   String categoryName = "";
	   String tempCategoryName = "";
	   boolean _addContentSignpost = false;
	    
	    for (List<String> list : namesAndNumbers) {
			Object[] myArray = list.toArray();
			Page productPage = pageManager.getPage(myArray[1].toString());
			ProductController productController = new ProductController();
			Product product = new Product();
			product = productController.getProuctPageProperties(productPage, isAuthor, slingRequest);
			
			Map<String, String> prdtCategoryMapTags = product.getPrdCategoryMap();
			
			String prdtCategoryTagName = "";
			String prdtCatgoryTagID = "";
			for (Map.Entry<String, String> entry : prdtCategoryMapTags.entrySet() ) {
     		     prdtCategoryTagName = entry.getValue();
     		    prdtCatgoryTagID = WCMUtil.getTagKeyByTags(entry.getKey());
			}
			
				if (tempCategoryName != prdtCategoryTagName) {
					tempCategoryName = prdtCategoryTagName;
					prdtSignpostCount = 1;
				}
				else if (tempCategoryName == prdtCategoryTagName) {
					prdtSignpostCount++;
				}
			
				if (prdtSignpostCount % iContentSignpostsPostion == 0)
					_addContentSignpost = true;
				else
					_addContentSignpost = false;
			
			%>		
		
		<c:if test="${fn:length(varContentSignpostPathArr) > 0}">
			<%
			if (_addContentSignpost) {
				
				if (contentSignpostCount < contentSignpostPathArr.length) {
						Page contentSignpostPage = pageManager.getPage(contentSignpostPathArr[contentSignpostCount]);
						Node contentSignpostNode = WCMUtil.getNodePropertyValueByPage(contentSignpostPage, "signpost_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(contentSignpostPage, "signpost_admin_bw") : currentNode;
						String signpostTitle = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-title_t");
						String signpostCopy = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-copy_t");
						String signpostIconStyle = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-icon-style");
						String signpostIconPath = svgIconPath + "#" + signpostIconStyle; 
						
						String contSignBtn = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-text");
						String contSignBtnText = I18nUtil.getLabel(contSignBtn, contentSignpostPage, slingRequest, null);
						
						String contSignCta = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-text");
						String contSignCtaText = I18nUtil.getLabel(contSignCta, contentSignpostPage, slingRequest, null);
						
						String signpostBtnPath = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-path");
						signpostBtnPath = WCMUtil.getURL(signpostBtnPath, isAuthor);
						
						String contSignCtaPath = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-path");
						contSignCtaPath = WCMUtil.getURL(contSignCtaPath, isAuthor);
						
						String contSignCtaStyle = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-style");
						String contSignCtaIcon = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-icon");
						String contSignCtaIconPath =  svgIconPath + "#" + contSignCtaIcon;
						
						boolean signpostBtnOpenNewWin = false;
						signpostBtnOpenNewWin = WCMUtil.getNodePropertyValue(contentSignpostNode, "signpost-btn-open-new-win").equals("true");
				    	String signPostOpenInNewWindowString = "";
				
					 	if (signpostBtnOpenNewWin){
					 		signPostOpenInNewWindowString = " target='_blank'";
						}
					 	
					 	boolean contSignCtaOpenNewWin = false;
					 	contSignCtaOpenNewWin = WCMUtil.getNodePropertyValue(contentSignpostNode, "cta-open-new-win").equals("true");
				    	String contSignCtaOpenInNewWindowString = "";
				
					 	if (contSignCtaOpenNewWin){
					 		contSignCtaOpenInNewWindowString = " target='_blank'";
						}
					 	
				writer.object();
					writer.key("title").value(prdtCategoryTagName);
					writer.key("pos").value(contentSignpostsPostion);
						writer.key("tiles").array();
						 	writer.object(); 
								writer.key("type").value("ads");
								writer.key("title").value(signpostTitle);
								writer.key("content").value(signpostCopy);
								writer.key("icon").value(signpostIconPath);
								writer.key("cta").object();
									writer.key("link").object();
										writer.key("text").value(contSignCtaText);
										writer.key("url").value(contSignCtaPath);
										writer.key("icon").value(contSignCtaIconPath);
		                                writer.key("data-analytics").value("{\"event\":{\"eventInfo\":{\"eventType\":\"ecommerce\",\"eventName\":\"" + ANALYTICS_BODY + ":" + productCategoryComponentName + "\",\"eventAction\":\"" + contSignCta + "\",\"eventURL\":\"" + contSignCtaPath  + "\"}}}");
									writer.endObject();
									writer.key("button").object();
										writer.key("text").value(contSignBtnText);
										writer.key("url").value(signpostBtnPath);
		                                writer.key("data-analytics").value("{\"event\":{\"eventInfo\":{\"eventType\":\"ecommerce\",\"eventName\":\"" + ANALYTICS_BODY + ":" + productCategoryComponentName + "\",\"eventAction\":\"" + contSignBtn + "\",\"eventURL\":\"" + signpostBtnPath  + "\"}}}");
								writer.endObject();
							   writer.endObject();
							writer.endObject();
					
					  writer.endArray();
					writer.endObject();
					 	contentSignpostCount++;
					}
			}
				%>
				
	</c:if>			
	
	<%
	writer.object();
		writer.key("title").value(prdtCategoryTagName);
		writer.key("categoryid").value(prdtCatgoryTagID);
        writer.key("eccategoryid").value(product.getPrdEcommerceCatId());
	
		writer.key("tiles").array();
			
					writer.object(); 
						writer.key("type").value("product");
						writer.key("productid").value(productPage.getName());
                        writer.key("ecproductid").value(product.getPrdId());
                        writer.key("ecproducturl").value(product.getPrdEcommerceUrl());
						writer.key("title").value(product.getPrdPageTitle());
						writer.key("image").value(product.getPrdImgPath());
						writer.key("url").value(WCMUtil.getURL(productPage.getPath(), isAuthor));
                        writer.key("data-analytics").value("{\"event\":{\"eventInfo\":{\"eventType\":\"ecommerce\",\"eventName\":\"" + ANALYTICS_BODY + ":" + productCategoryComponentName + "\",\"eventAction\":\"buy\",\"eventURL\":\"" + product.getPrdEcommerceUrl()  + "\"}}, \"product\":{\"productInfo\":{\"productName\":\""+productPage.getName()+"\",\"productID\":\""+product.getPrdId()+"\"},\"category\":{\"primaryCategory\":\""+prdtCatgoryTagID+"\",\"primaryCategoryID\":\""+product.getPrdEcommerceCatId()+"\"}} }");						
                        writer.key("needs").array();
                        
						Map<String, String> prdtLifeStageMapTags = product.getPrdLifeStageMap();
						for (Map.Entry<String, String> entry : prdtLifeStageMapTags.entrySet() ) {
			     			String prdtLifeStageKey = WCMUtil.getTagKeyByTags(entry.getKey());
			     			String prdLifeStageValue = entry.getValue();
			     			String prdtLifeStageIcon = svgIconPath + "#" +  WCMUtil.getProductStageIcon(prdtLifeStageKey);
			     		
			     				writer.object();
			     					writer.key("name").value(prdLifeStageValue);
			     					writer.key("icon").value(prdtLifeStageIcon);
			     					writer.key("lifestageid").value(prdtLifeStageKey);
			     				writer.endObject();
			     				
						}
					writer.endArray();
				writer.endObject();
		writer.endArray();
	writer.endObject();

	%>
	
	 
	<%
       }
	    
	    writer.endArray();
	    
	    writer.key("labels").array();
	    writer.object();
	    writer.key("viewall").value(viewAllLabel);
	    writer.key("hideall").value(hideAllLabel);
	    writer.endObject();
	    writer.endArray();
	    
	    writer.endObject();
	%>