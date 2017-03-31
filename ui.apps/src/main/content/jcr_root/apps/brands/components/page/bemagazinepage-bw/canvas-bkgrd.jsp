<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String pageBkgrdImg	  = properties.get("page-bkgrd-img-path", "brands-campaign-bg-img.jpg");
String pageBkgrdStyle = properties.get("page-bkgrd-style", "background-cover-image");
String dataSpeed = properties.get("data-speed", "normal");
String disabledParallax = properties.get("disabledparallax","false");      
int startLevel = 2;
int currentPageLevel = currentPage.getDepth();
%>

<c:set var="varPageBkgrdImg" value="<%= pageBkgrdImg  %>"/>
<c:set var="varPageBkgrdStyle" value="<%= pageBkgrdStyle  %>"/>

<div class="section-container">
	<div class="background-container <c:out value="${varPageBkgrdStyle}"/>" style="background-image: url(<%=imgPath%>/template/<%=pageBkgrdImg%>)" data-rjs="2" data-top="background-position: center 0px" data-top-bottom="background-position: center -250px" <%if(!disabledParallax.equals("true")){%>data-speed="<%=dataSpeed%>"<%}%>>
		<div class="hero-canvas"></div>
	    <cq:include script="header.jsp" />
	    <%-- breadcrumbs --%>    
	    <cq:include path="breadcrumbs-bw" resourceType="brands/components/global/breadcrumbs-bw"/>
	    
	    <div class="section-container be-magazine-detail">
	      <div class="container-fluid">
	        <div class="row">
	    	  <cq:include path="article-masthead-bw" resourceType="brands/components/content/article-masthead-bw"/>
	    	</div>
	    	<div class="row">
	          <div class="col-lg-2 col-md-2 col-sm-2 hidden-xs">
	            <div class="category-wrapper">
	              <!--<h3 class="secondary-color text-left">Articles</h3>-->
	              <!--<p>by Brand's</p>-->
	            </div>
	          </div>
	          <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
				<% 
				if (isAuthor) { %>
				<h3 class="secondary-color">WRAPPER-PAR</h3>
				<%
				} %>    
	    		<cq:include path="wrapperpar" resourceType="foundation/components/parsys"/>
	    	  </div>
	        </div>
	    </div>
	</div>
</div>