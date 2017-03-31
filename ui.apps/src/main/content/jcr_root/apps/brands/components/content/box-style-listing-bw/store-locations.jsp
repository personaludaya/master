<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="java.util.*,
                com.brands.core.utils.*"%>

<%
  String listingPath = properties.get("listing-path", null);
  String opt = properties.get("opt", null); 
%>
<c:set var="varListingPath" value="<%= listingPath %>"/>
<c:set var="varOpt" value="<%= opt %>"/>

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
          Page storeLocationAdminRootPage = pageManager.getPage(listingPath);
          Iterator<Page> iterStoreLocationPages = storeLocationAdminRootPage.listChildren(new PageFilter(request));
           
          while (iterStoreLocationPages.hasNext()) {
        	  Page storeLocationPage = iterStoreLocationPages.next();
        	  Node storeLocationNode = WCMUtil.getNodePropertyValueByPage(storeLocationPage, "store_location_admin") != null ? WCMUtil.getNodePropertyValueByPage(storeLocationPage, "store_location_admin") : currentNode;
        	  String storeLocationImgPath = WCMUtil.getNodePropertyValue(storeLocationNode, "img-path");
        	  String title = WCMUtil.getNodePropertyValue(storeLocationNode, "title_t");
        	  String storeLocationImgAlt = WCMUtil.getNodePropertyValue(storeLocationNode, "img-alt_t");
        	  storeLocationImgAlt = storeLocationImgAlt == "" ? title : storeLocationImgAlt;
        	  String storeLocationCtaPath = WCMUtil.getNodePropertyValue(storeLocationNode, "cta-path");
        	  storeLocationCtaPath = WCMUtil.getURL(storeLocationCtaPath, isAuthor);
        	  boolean storeLocationCtaOpenNewWin = false;
        	  storeLocationCtaOpenNewWin = WCMUtil.getNodePropertyValue(storeLocationNode, "cta-open-new-win").equals("true");
        	  String openInNewWindowString = "";

        	 	if (storeLocationCtaOpenNewWin){
        	 		openInNewWindowString = " target='_blank'";
        		}
       	  %>
          	<c:set var="varStrLocationImgPath" value="<%= storeLocationImgPath %>"/>
          	<c:set var="varStrLocationImgAlt" value="<%= storeLocationImgAlt %>"/>
          	<c:set var="varStoreLocationCtaPath" value="<%= storeLocationCtaPath  %>"/>
			<c:set var="varOpenInNewWindowString" value="<%= openInNewWindowString  %>"/>
			<c:set var="varTitle" value="<%= title  %>"/>
			
             <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 no-padding-col">
              <div class="store-location-item">
                <div class="row no-margin-row">
                   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col">
                    <div class="image-wrapper">
                      <img class="img-responsive" src="${varStrLocationImgPath}" alt="${varStrLocationImgAlt}" data-rjs="2">
                    </div>
                   </div>
                   
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col">
                      <div class="content-wrapper">
                      	<p> 
                      		<a href="${varStoreLocationCtaPath}" ${varOpenInNewWindowString} title="${varTitle}"/>
                      			<c:out value="${varTitle}"/>
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