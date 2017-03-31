<%@include file="/apps/brands/global/global.jsp" %>

<%
boolean hideBreadCrumbs = false;
hideBreadCrumbs = pageProperties.get("hide-breadcrumbs", "").equals("true");

int homepgIdx = 4;
int currentPageLevel = currentPage.getDepth();
String homepgPath = "";
if (currentPageLevel > 3) {
    homepgPath = currentPage.getAbsoluteParent(3).getPath();
    homepgPath = WCMUtil.getURL(homepgPath, isAuthor);
}
%>
<c:set var="varHideBreadCrumbs" value="<%= hideBreadCrumbs %>"/>
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
<c:set var="varCurrentPageLevel" value="<%= currentPageLevel  %>"/>
<c:set var="varHomepgPath" value="<%= homepgPath %>"/>

<c:if test="${varHideBreadCrumbs == 'false'}">
	<ul class="breadcrumb hidden-xs">
	   <li><a href="${varHomepgPath}">
	       <svg class="brands-icon icon-breadcrumb icon-white icon-center">
	         <use href="${varSvgIconPath}#icon-home" xlink:href="${varSvgIconPath}#icon-home"></use>
	       </svg></a></li>
	   <li>
	     <svg class="brands-icon icon-breadcrumb icon-white icon-center">
	       <use href="${varSvgIconPath}#icon-arrow-right" xlink:href="${varSvgIconPath}#icon-arrow-right"></use>
	     </svg>
	   </li>
	   
	    <% 
	    for (int i=homepgIdx; i<currentPageLevel; i++) {
	    	boolean hideArrow = false;
	        Page thisPage = currentPage.getAbsoluteParent(i);
	        try {
	            String hideInBC = thisPage.getProperties().get("hide-page-in-breadcrumbs", "");
	            if (!StringUtil.isEmpty(hideInBC)) {
	                continue;
	                
	            }
	        } catch (Exception e) {}
		   
		    String title = WCMUtil.getNavTitle(thisPage);
	        String link = WCMUtil.getURL(thisPage, isAuthor);
	       
	        if (currentPageLevel-1 == i)
	        	hideArrow = true;
	    %>
	    
	   <c:set var="varTitle" value="<%= title %>"/>
	   <c:set var="varLink" value="<%= link %>"/>
	   <c:set var="varHideArrow" value="<%= hideArrow %>"/>
	   
	   <li>
	   	<a href="${varLink}" title>${varTitle}</a>
	   </li>
	   
	   <c:if test="${varHideArrow == 'false'}">
	   <li>
	     <svg class="brands-icon icon-breadcrumb icon-white icon-center">
	       <use href="${varSvgIconPath}#icon-arrow-right" xlink:href="${varSvgIconPath}#icon-arrow-right"></use>
	     </svg>
	   </li>
	   </c:if>
	   
	   <%  } %>
	</ul>
</c:if>

 
