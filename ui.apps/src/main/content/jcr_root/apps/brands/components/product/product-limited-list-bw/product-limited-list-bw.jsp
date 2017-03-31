<%@include file="/apps/brands/global/global.jsp"%>
<%@page import="com.brands.core.models.Product,
				com.brands.core.controller.ProductController,
				org.apache.commons.lang3.StringUtils" %>

<%
String productPath = properties.get("path-to-product", "");
String defImgPath = properties.get("default-img-path", imgPath+"/product/starter-EOC@2x.png");

ProductController ctrl = new ProductController(productPath, isAuthor, slingRequest);
List<String> categoryList = new ArrayList<String>();
categoryList = ctrl.getAvailableCategories();

%>
<div class="country-specific-landing-wrapper">
	<%
	if(categoryList.size() > 0){
		for(String category : categoryList){
			%>
			<c:set var="varPrdtCategory" value="<%=category %>"/>
			<h3 class="text-left"><c:out value="${varPrdtCategory}"/></h3>
			<div class="container-fluid">
				<div class="row">
					<%
					List<Product> productList = new ArrayList<Product>();
					productList = ctrl.getPrdtByCategory(category, slingRequest);
					if(productList.size() > 0){
						for(Product product : productList){
							String prdImgPath = product.getPrdImgPath();
							if(StringUtils.isEmpty(prdImgPath)){
								prdImgPath = defImgPath;
							}
							%>
							<c:set var="varPrdtName" value="<%=product.getPrdPageTitle() %>"/>
							<c:set var="varPrdtPath" value="<%=product.getPrdPath() %>"/>
							<c:set var="varPrdtImgPath" value="<%=prdImgPath %>"/>
						
							<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
							<!-- product info overview start here-->
								<div class="product-info-overview">
									<a href="${varPrdtPath }"><img class="img-responsive"
										src="${varPrdtImgPath }"
										alt="${varPrdtName}"
										title="${varPrdtName}"></a><a href="${varPrdtPath }">
										<h4 class="text-left"><c:out value="${varPrdtName}"/></h4>
									</a>
									<div class="product-info-overview-detail">
										<ul class="product-benefits">
											<%-- No Product Benefits for Country Landing --%>
										</ul>
										<ul class="product-info-detail">
											<li><a class="btn btn-action btn-lg">buy now</a></li>
										</ul>
									</div>
								</div>
								<!-- product info overview end here-->
							</div>			
							<%
						}
					}
					%>
				</div>
			</div>	
			<%	
		}
		
	}
	%>		
</div>
