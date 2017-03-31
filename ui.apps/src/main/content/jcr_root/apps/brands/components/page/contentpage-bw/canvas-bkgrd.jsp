<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String pageSectionStyle = properties.get("page-section-style", "");
String pageBkgrdImg	  = properties.get("page-bkgrd-img-path", "brands-campaign-bg-img.jpg");
String pageBkgrdStyle = properties.get("page-bkgrd-style", "background-cover-image");
String dataSpeed = properties.get("data-speed", "normal");
String disabledParallax = properties.get("disabledparallax","false");
%>

<c:set var="varPageSectionStyle" value="<%= pageSectionStyle  %>"/>
<c:set var="varPageBkgrdImg" value="<%= pageBkgrdImg  %>"/>
<c:set var="varPageBkgrdStyle" value="<%= pageBkgrdStyle  %>"/>

<div class="section-container <c:out value="${varPageSectionStyle}"/>">
	<div class="background-container <c:out value="${varPageBkgrdStyle}"/>" style="background-image: url(<%=imgPath%>/template/<%=pageBkgrdImg%>)" data-rjs="2" data-top="background-position: center 0px" data-top-bottom="background-position: center -250px" <%if(!disabledParallax.equals("true")){%>data-speed="<%=dataSpeed%>"<%}%>>
		<div class="hero-canvas"></div>
	    <cq:include script="header.jsp" />
	    <%-- breadcrumbs --%>    
        <cq:include path="breadcrumbs-bw" resourceType="brands/components/global/breadcrumbs-bw"/>
	    
	    <% 
		if (isAuthor) { %>
		<h3 class="secondary-color">WRAPPER-PAR</h3>
		<%
		} %>    
	    <cq:include path="wrapperpar" resourceType="foundation/components/parsys"/>
	</div>
</div>