<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,com.brands.core.models.*,java.util.*" %>

<%

String pathToInstagram = properties.get("path-to-instagram", null);
String hashtag = properties.get("hashtag", null);
String hashtagCopy = properties.get("hashtag-copy_t", null);

%>

<c:set var="varPathToInstagram" value="pathToInstagram"/>
<c:if test="${varPathToInstagram != null}">

<%

if (pathToInstagram != null) {
Page pathToInstagramRootPage = pageManager.getPage(pathToInstagram);
Iterator<Page> iterInstagramPages = pathToInstagramRootPage.listChildren(new PageFilter(request));
       
int count = 0;        
List<Instagram> instagramList = new ArrayList<Instagram>();
while (iterInstagramPages.hasNext()) {
	 Page instagramPage = iterInstagramPages.next();
	 Node instagramNode = WCMUtil.getNodePropertyValueByPage(instagramPage, "instagram_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(instagramPage, "instagram_admin_bw") : currentNode;
	 String instagramImg = WCMUtil.getNodePropertyValue(instagramNode, "instagram-img");
	 String instagramUrl = WCMUtil.getNodePropertyValue(instagramNode, "instagram-url");
	 instagramUrl = WCMUtil.getURL(instagramUrl, isAuthor);
	 
	 if (count < 8) {
	   	 Instagram instagram = new Instagram();
	   	 instagram.setInstaImage(instagramImg);
	   	 instagram.setInstaUrl(instagramUrl);
	   	 instagramList.add(instagram);
	   	 count++;
	 } else
		 break;
}
%>

<c:set var="varHashtag" value="<%= hashtag %>"/>
<c:set var="varHashtagCopy" value="<%= hashtagCopy %>"/>

<div data-js-loader='["your-brands-story-container.js"]'></div>

<!-- your-brands-story-component start here-->
<div class="your-brands-story-component">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 col-lg-offset-1 col-md-offset-1 col-sm-offset-0 col-xs-offset-0">
						<div class="row no-margin-row">

                            <div class="col-lg-2 no-padding-col hidden-xs hidden-sm hidden-md">
                                <div class="row no-margin-row">

                                    <div class="col-lg-12 col-md-12 col-sm-6 col-xs-6 no-padding-col insta-feed-item hidden-xs hidden-sm hidden-md flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(0).getInstaImage()%>" data-mfp-src="<%= instagramList.get(0).getInstaUrl() %>">
                                        <%-- <img class="tile-row-1 flip-front" id="insta2" src="<%= instagramList.get(0).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(0).getInstaUrl() %>">
                                        <div class="tile-row-1 flip-back"></div> --%>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-6 col-xs-6 no-padding-col insta-feed-item hidden-xs hidden-sm hidden-md flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(1).getInstaImage()%>" data-mfp-src="<%= instagramList.get(1).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta3" src="<%= instagramList.get(1).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(1).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div> --%>
									</div>

								</div>
							</div>

							<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 no-padding-col">
								<div class="row no-margin-row">

									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col insta-feed-item">
										<div class="tile-row-1 flip-back show"></div>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col insta-feed-item flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(2).getInstaImage() %>" data-mfp-src="<%= instagramList.get(2).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta3" src="<%= instagramList.get(2).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(2).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div>  --%>
									</div>

								</div>
							</div>

                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 hidden-xs no-padding-col">
                                <div class="row no-margin-row">
                                
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col insta-feed-item flip-front tile-row-2 div-image" data-bg="<%= instagramList.get(3).getInstaImage() %>" data-mfp-src="<%= instagramList.get(3).getInstaUrl() %>">
										<%-- <img class="tile-row-2 flip-front" id="insta4" src="<%= instagramList.get(3).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(3).getInstaUrl() %>">
										<div class="tile-row-2 flip-back"></div> --%>		
									</div>
									
								</div>
							</div>

							<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 no-padding-col">
								<div class="row row no-margin-row">

									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col insta-feed-item flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(4).getInstaImage()%>" data-mfp-src="<%= instagramList.get(4).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta5" src="<%= instagramList.get(4).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(4).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div> --%>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6 no-padding-col insta-feed-item flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(5).getInstaImage()%>" data-mfp-src="<%= instagramList.get(5).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta6" src="<%= instagramList.get(5).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(5).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div> --%>
									</div>

								</div>
							</div>

							<div class="col-lg-2 no-padding-col hidden-xs hidden-sm hidden-md">
								<div class="row row no-margin-row">

									<div class="col-lg-12 col-md-12 col-sm-6 col-xs-6 no-padding-col insta-feed-item hidden-xs hidden-sm hidden-md flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(6).getInstaImage()%>" data-mfp-src="<%= instagramList.get(6).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta5" src="<%= instagramList.get(6).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(6).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div> --%>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-6 col-xs-6 no-padding-col insta-feed-item hidden-xs hidden-sm hidden-md flip-front tile-row-1 autofill div-image" data-bg="<%= instagramList.get(7).getInstaImage()%>" data-mfp-src="<%= instagramList.get(7).getInstaUrl() %>">
										<%-- <img class="tile-row-1 flip-front" id="insta6" src="<%= instagramList.get(7).getInstaImage() %>" alt="${varHashtag}" title="${varHashtag}" data-mfp-src="<%= instagramList.get(7).getInstaUrl() %>">
										<div class="tile-row-1 flip-back"></div> --%>
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- your-brands-story-component end here-->

<script type="text/javascript" src="<%= resource.getPath() %>.js.html"></script>
<% } %>
</c:if>
