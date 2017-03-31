<%@include file="/apps/brands/global/global.jsp" %>

<%
  String listingPath = properties.get("listing-path", null);
  String opt = properties.get("opt", null); 
%>
<c:set var="varListingPath" value="<%= listingPath %>"/>
<c:set var="varOpt" value="<%= opt %>"/>

<c:if test="${varOpt == 'ingredients'}">
	<c:set var="varIngredientsFullWidth" value="class=full-width"/>
</c:if>


<c:if test="${varListingPath != null}">
  <div class="store-location-wrapper">
    <div class="container-fluid">
      <div class="row no-margin-row">
      <%
        Page rootPage = pageManager.getPage(listingPath);
      %>
      <c:set var="rootPage" value="<%= rootPage %>"/>
      <c:if test="${rootPage != null}">
          <!-- Start Looping -->
          <%
          Page ingredientsAdminRootPage = pageManager.getPage(listingPath);
          Iterator<Page> iterIngredientsPages = ingredientsAdminRootPage.listChildren(new PageFilter(request));
           
          while (iterIngredientsPages.hasNext()) {
        	  Page ingredientsPage = iterIngredientsPages.next();
        	  String ingredientPagePath = WCMUtil.getURL(ingredientsPage.getPath(), isAuthor);
        	  ingredientPagePath = WCMUtil.getURL(ingredientPagePath, isAuthor);
        	  String ingredientsImgPath = WCMUtil.getPagePropertyValue(ingredientsPage, "img-path");
        	  String ingredientsImgAlt = WCMUtil.getPagePropertyValue(ingredientsPage, "img-alt_t");
        	  ingredientsImgAlt = ingredientsImgAlt == "" ? currentPage.getPageTitle() : ingredientsImgAlt;
       	  %>
       	    <c:set var="varIngredientPagePath" value="<%= ingredientPagePath  %>"/>
          	<c:set var="varIngredientsTitle" value="<%= ingredientsPage.getTitle() %>"/>
          	<c:set var="varIngredientsImgPath" value="<%= ingredientsImgPath %>"/>
          	<c:set var="varIngredientsImgAlt" value="<%= ingredientsImgAlt %>"/>

             <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 no-padding-col">
              <div class="store-location-item">
                <div class="row no-margin-row">
                   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col">
                    <div class="image-wrapper">
                      <img ${varIngredientsFullWidth} src="${varIngredientsImgPath}" alt="${varIngredientsImgAlt}" data-rjs="2">
                    </div>
                   </div>
                   
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col">
                      <div class="content-wrapper">
                      	<p> 
                      		<a href="${varIngredientPagePath}" title="${varIngredientsTitle}">
                      			<c:out value="${varIngredientsTitle}"/>
                      		</a>
                      	</p>
                      </div>
                    </div>
                    
                </div>
              </div>
            </div>  
           <%
            }
           %>       
          <!-- end looping -->
      </c:if>
      
      
      </div>
    </div>
  </div>
</c:if>