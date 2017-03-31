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
String productCategoryComponentName = component.getProperties().get("jcr:title", "");
String filterPara = request.getParameter("filter");

%>
<c:set var="varFilterPara" value="<%= filterPara %>"/>
<c:if test="${varFilterPara != null}">
<%
String[] filterArr = filterPara.split(",");

List<String> filterList = new ArrayList<String>();
filterList = Arrays.asList(filterArr); 

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
	    
	    int prdtSignpostCount = 1;
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
			for (Map.Entry<String, String> entry : filterPrdtCategoryMapTags.entrySet() ) {
     		     filterPrdtCategoryTagName = entry.getValue();
			}
			
			namesAndNumbers.add(new ArrayList<String>(Arrays.asList(filterPrdtCategoryTagName, filterProductPage.getPath())));
	    }
	    
	  //sorted by category
	    Collections.sort(namesAndNumbers, new Comparator<ArrayList<String>>() {    
	        @Override
	        public int compare(ArrayList<String> o1, ArrayList<String> o2) {
	            return o1.get(0).compareTo(o2.get(0));
	        }               
		});
	    
	  
	    List<ArrayList<String>> bestMatchList = new ArrayList<ArrayList<String>>();
	    int bestMatchCount = 0;
	    for (List<String> list : namesAndNumbers) {
	    	Object[] bestMatchArr = list.toArray();
			Page bestMatchPage = pageManager.getPage(bestMatchArr[1].toString());
			ProductController bestProductController = new ProductController();
			Product bestProduct = new Product();
			bestProduct = bestProductController.getProuctPageProperties(bestMatchPage, isAuthor, slingRequest);
			
			Map<String, String> bestPrdtLifeStageMapTags = bestProduct.getPrdLifeStageMap();
			for (Map.Entry<String, String> entry : bestPrdtLifeStageMapTags.entrySet() ) {
				String bestTempKey = WCMUtil.getTagKeyByTags(entry.getKey());
				if (filterList.contains(bestTempKey)) {
					bestMatchCount++;
				}
			}
			
			if (bestMatchCount != 0) {
				bestMatchList.add(new ArrayList<String>(Arrays.asList(Integer.toString(bestMatchCount), bestMatchPage.getPath())));
				bestMatchCount = 0;
			}
	    }
	  
	  
	    Collections.sort(bestMatchList, new Comparator<ArrayList<String>>() {    
	        @Override
	        public int compare(ArrayList<String> o1, ArrayList<String> o2) {
	            return o2.get(0).compareTo(o1.get(0));
	        }               
		});

	    
	   String categoryName = "";
	   String tempCategoryName = "";
	    
	    for (List<String> list : bestMatchList) {
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
			

			Boolean validate = false;
			Map<String, String> prdtLifeStageMapTags = product.getPrdLifeStageMap();
			for (Map.Entry<String, String> entry : prdtLifeStageMapTags.entrySet() ) {
				String tempKey = WCMUtil.getTagKeyByTags(entry.getKey());
				if (filterList.contains(tempKey)) {
					validate = true;
					break;
				}
			}
			
	if (validate) {
		String prodCategoryName = myArray[0].toString().equals("2") ? I18nUtil.getLabel("bestmatch", productPage, slingRequest, null) : prdtCategoryTagName;
		prdtCatgoryTagID = myArray[0].toString().equals("2") ? "bestmatch" : prdtCatgoryTagID;
		writer.object();
		writer.key("title").value(prodCategoryName);
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
	}		

  }
	    
	    writer.endArray();
	    writer.endObject();
	%>
</c:if>