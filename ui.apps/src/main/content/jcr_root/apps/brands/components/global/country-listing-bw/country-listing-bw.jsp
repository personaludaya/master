<%@include file="/apps/brands/global/global.jsp"%>
<%
%>
<%
	List<String> countryList = new ArrayList<String>();
	Page brandsRootPage = currentPage.getAbsoluteParent(1); //e.g. /content/brands
	if(brandsRootPage != null){
		Iterator<Page> countryIt = brandsRootPage.listChildren();
		while(countryIt.hasNext()){
			Page countryPage = countryIt.next();
			String countryName = WCMUtil.getNavTitle(countryPage);
			String pageName = countryPage.getName();
			// country page name will not have more than 2 characters (i.e. sg, my, tw)
			if(pageName.length() < 3) countryList.add(countryName);
		}
	}
	
%>
<div class="global-landing-wrapper">
	<div class="container-fluid">
		<div class="row">
<%
			for(String country: countryList){
			%>
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
				<div class="global-landing-item">
					

					<c:set var="varCountryName" value="<%=country.toLowerCase() %>" />
					<c:set var="varCountryTitle" value="<%= country %>" />
					<div class="image-wrapper">
						<img class="img-responsive full-width"
							src="<%=imgPath%>/others/${varCountryName }-country.png" alt
							title>
					</div>
					<div class="content-wrapper">
						<p>
							<a>${varCountryTitle }</a>
						</p>
					</div>	
				</div>
			</div>
			<%
			}
%>
		</div>
	</div>
</div>