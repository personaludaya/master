<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang.StringUtils" %>
<%
String topNavConfigPath = pageProperties.getInherited("top-nav-path", "");
String ev5clickloc = "clickloc=topnav";

NodeIterator topNavChildNodes = null;
Resource topNavRes = (topNavConfigPath.isEmpty()) ? null : resourceResolver.resolve(topNavConfigPath + "/jcr:content/par");
if (topNavRes != null) {
	Node topNavNode = topNavRes.adaptTo(Node.class);
	topNavChildNodes = topNavNode.getNodes();
}
int j = 1;
%>
<!-- submenu molecule start here-->
<div class="submenu hidden-xs" id="submenu">
	<div class="container-fluid">
	<%
	while(topNavChildNodes != null && topNavChildNodes.hasNext()){
		Node next = topNavChildNodes.nextNode();
	 	String resourceType = next.hasProperty("sling:resourceType") ? next.getProperty("sling:resourceType").getString() : "";
	    if(resourceType.equals("brands/components/admin/top-nav-admin-bw")){
	    	String navType = next.hasProperty("navigation-type") ? next.getProperty("navigation-type").getString() : "";
		    
	    	if (navType.equals("display-panel")) {
		    	// DISPLAY PANEL
		    	String maxLink 			= next.hasProperty("max-link") ? next.getProperty("max-link").getString() : "7";
		    	int maxCount 			= StringUtils.isNumeric(maxLink) ? Integer.parseInt(maxLink) : 7;
		    	String c1type 			= next.hasProperty("c1-type") ? next.getProperty("c1-type").getString() : "";
		    	String c1CpHeader		= next.hasProperty("c1-cp-header_t") ? next.getProperty("c1-cp-header_t").getString() : "";
		    	String c1ParentPath		= next.hasProperty("c1-parent-path") ? next.getProperty("c1-parent-path").getString() : "";
		    	String c1MlHeader		= next.hasProperty("c1-ml-header_t") ? next.getProperty("c1-ml-header_t").getString() : "";
		    	List<Node> c1ManualList	= WCMUtil.getMultiCompositePropertyNodeList(next, "c1-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
		    	String c1ImgPath		= next.hasProperty("c1-img-path") ? next.getProperty("c1-img-path").getString() : "";
		    	String c1Header			= next.hasProperty("c1-header_t") ? next.getProperty("c1-header_t").getString() : "";
		    	String c1Description	= next.hasProperty("c1-description_t") ? next.getProperty("c1-description_t").getString() : "";
		    	String c1ButtonText		= next.hasProperty("c1-button-text_t") ? next.getProperty("c1-button-text_t").getString() : "";
		    	String c1ButtonPath		= next.hasProperty("c1-button-path") ? next.getProperty("c1-button-path").getString() : "";
		    	if(StringUtils.isNotEmpty(c1ButtonPath)) c1ButtonPath+= "#"+ev5clickloc;
		    	boolean c1ButtonOpenNewWin = next.hasProperty("c1-button-open-new-win") ? next.getProperty("c1-button-open-new-win").getString().equals("true") : false;
		
		    	String c2type 			= next.hasProperty("c2-type") ? next.getProperty("c2-type").getString() : "";
		    	String c2CpHeader		= next.hasProperty("c2-cp-header_t") ? next.getProperty("c2-cp-header_t").getString() : "";
		    	String c2ParentPath		= next.hasProperty("c2-parent-path") ? next.getProperty("c2-parent-path").getString() : "";
		    	String c2MlHeader		= next.hasProperty("c2-ml-header_t") ? next.getProperty("c2-ml-header_t").getString() : "";
		    	List<Node> c2ManualList	= WCMUtil.getMultiCompositePropertyNodeList(next, "c2-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
		    	String c2ImgPath		= next.hasProperty("c2-img-path") ? next.getProperty("c2-img-path").getString() : "";
		    	String c2Header			= next.hasProperty("c2-header_t") ? next.getProperty("c2-header_t").getString() : "";
		    	String c2Description	= next.hasProperty("c2-description_t") ? next.getProperty("c2-description_t").getString() : "";
		    	String c2ButtonText		= next.hasProperty("c2-button-text_t") ? next.getProperty("c2-button-text_t").getString() : "";
		    	String c2ButtonPath		= next.hasProperty("c2-button-path") ? next.getProperty("c2-button-path").getString() : "";
		    	if(StringUtils.isNotEmpty(c2ButtonPath)) c2ButtonPath+= "#"+ev5clickloc;
		    	boolean c2ButtonOpenNewWin = next.hasProperty("c2-button-open-new-win") ? next.getProperty("c2-button-open-new-win").getString().equals("true") : false;
		
		    	String c3type 			= next.hasProperty("c3-type") ? next.getProperty("c3-type").getString() : "";
		    	String c3CpHeader		= next.hasProperty("c3-cp-header_t") ? next.getProperty("c3-cp-header_t").getString() : "";
		    	String c3ParentPath		= next.hasProperty("c3-parent-path") ? next.getProperty("c3-parent-path").getString() : "";
		    	String c3MlHeader		= next.hasProperty("c3-ml-header_t") ? next.getProperty("c3-ml-header_t").getString() : "";
		    	List<Node> c3ManualList	= WCMUtil.getMultiCompositePropertyNodeList(next, "c3-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
		    	String c3ImgPath		= next.hasProperty("c3-img-path") ? next.getProperty("c3-img-path").getString() : "";
		    	String c3Header			= next.hasProperty("c3-header_t") ? next.getProperty("c3-header_t").getString() : "";
		    	String c3Description	= next.hasProperty("c3-description_t") ? next.getProperty("c3-description_t").getString() : "";
		    	String c3ButtonText		= next.hasProperty("c3-button-text_t") ? next.getProperty("c3-button-text_t").getString() : "";
		    	String c3ButtonPath		= next.hasProperty("c3-button-path") ? next.getProperty("c3-button-path").getString() : "";
		    	if(StringUtils.isNotEmpty(c3ButtonPath)) c3ButtonPath+= "#"+ev5clickloc;
		    	boolean c3ButtonOpenNewWin = next.hasProperty("c3-button-open-new-win") ? next.getProperty("c3-button-open-new-win").getString().equals("true") : false;
		
		    	// Column Header
		    	if (c1CpHeader.isEmpty() && c1type.equals("child-pages")) {
		    		Page c1ParentPage = pageManager.getPage(c1ParentPath);
		    		if (c1ParentPage != null) {
		    			c1CpHeader = WCMUtil.getNavTitle(c1ParentPage);
		    		}
		    	}
		    	if (c2CpHeader.isEmpty() && c2type.equals("child-pages")) {
		    		Page c2ParentPage = pageManager.getPage(c2ParentPath);
		    		if (c2ParentPage != null) {
		    			c2CpHeader = WCMUtil.getNavTitle(c2ParentPage);
		    		}
		    	}
		    	if (c3CpHeader.isEmpty() && c3type.equals("child-pages")) {
		    		Page c3ParentPage = pageManager.getPage(c3ParentPath);
		    		if (c3ParentPage != null) {
		    			c3CpHeader = WCMUtil.getNavTitle(c3ParentPage);
		    		}
		    	}
		
		    	// Feature Banner Header Text
		    	if (c1Header.isEmpty() && !c1ButtonPath.isEmpty()) {
		    		Page buttonPage = pageManager.getPage(c1ButtonPath);
		    		if (buttonPage != null) {
		    			c1Header = buttonPage.getTitle();
		    		}
		    	}
		    	if (c2Header.isEmpty() && !c2ButtonPath.isEmpty()) {
		    		Page buttonPage = pageManager.getPage(c2ButtonPath);
		    		if (buttonPage != null) {
		    			c2Header = buttonPage.getTitle();
		    		}
		    	}
		    	if (c3Header.isEmpty() && !c3ButtonPath.isEmpty()) {
		    		Page buttonPage = pageManager.getPage(c3ButtonPath);
		    		if (buttonPage != null) {
		    			c3Header = buttonPage.getTitle();
		    		}
		    	}
		    	%>
		    	<c:set var="varNavType" value="<%= navType %>" />
		    	<c:set var="varMenuCounter" value="<%=j %>"/>
		    	<div class="row hide" data-menu-id="menu<c:out value="${varNavType == 'display-panel' ? varMenuCounter : '' }"/>">
		    	
				<c:set var="varC1type" value="<%= c1type  %>"/>
				<c:set var="varC1CpHeader" value="<%= c1CpHeader  %>"/>
				<c:set var="varC1ParentPath" value="<%= c1ParentPath  %>"/>
				<c:set var="varC1MlHeader" value="<%= c1MlHeader  %>"/>
				<c:set var="varC1ImgPath" value="<%= c1ImgPath  %>"/>
				<c:set var="varC1Header" value="<%= c1Header  %>"/>
				<c:set var="varC1Description" value="<%= c1Description  %>"/>
				<c:set var="varC1ButtonText" value="<%= c1ButtonText  %>"/>
				<c:set var="varC1ButtonPath" value="<%= WCMUtil.getURL(c1ButtonPath, isAuthor)  %>"/>
				<c:set var="varC1ButtonOpenNewWin" value="<%= c1ButtonOpenNewWin  %>"/>
				
				<c:set var="varC2type" value="<%= c2type  %>"/>
				<c:set var="varC2CpHeader" value="<%= c2CpHeader  %>"/>
				<c:set var="varC2ParentPath" value="<%= c2ParentPath  %>"/>
				<c:set var="varC2MlHeader" value="<%= c2MlHeader  %>"/>
				<c:set var="varC2ImgPath" value="<%= c2ImgPath  %>"/>
				<c:set var="varC2Header" value="<%= c2Header  %>"/>
				<c:set var="varC2Description" value="<%= c2Description  %>"/>
				<c:set var="varC2ButtonText" value="<%= c2ButtonText  %>"/>
				<c:set var="varC2ButtonPath" value="<%= WCMUtil.getURL(c2ButtonPath, isAuthor)  %>"/>
				<c:set var="varC2ButtonOpenNewWin" value="<%= c2ButtonOpenNewWin  %>"/>
				
				<c:set var="varC3type" value="<%= c3type  %>"/>
				<c:set var="varC3CpHeader" value="<%= c3CpHeader  %>"/>
				<c:set var="varC3ParentPath" value="<%= c3ParentPath  %>"/>
				<c:set var="varC3MlHeader" value="<%= c3MlHeader  %>"/>
				<c:set var="varC3ImgPath" value="<%= c3ImgPath  %>"/>
				<c:set var="varC3Header" value="<%= c3Header  %>"/>
				<c:set var="varC3Description" value="<%= c3Description  %>"/>
				<c:set var="varC3ButtonText" value="<%= c3ButtonText  %>"/>
				<c:set var="varC3ButtonPath" value="<%= WCMUtil.getURL(c3ButtonPath, isAuthor)  %>"/>
				<c:set var="varC3ButtonOpenNewWin" value="<%= c3ButtonOpenNewWin  %>"/>
				
	    		<%-- Column 1 --%>
	    		<div class="col-lg-4 col-md-4 col-sm-4">
				    <c:choose>
					    <c:when test="${varC1type == 'child-pages'}">
					        <div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC1CpHeader}</h4>
					          	<ul>
									<%
									if (!c1ParentPath.isEmpty()) {
										Page parentPage = pageManager.getPage(c1ParentPath);
										Iterator<Page> childIterator = parentPage.listChildren();
										int i = 1;
										while (childIterator.hasNext()) {
							            	Page child = childIterator.next();
							            	String childTitle = WCMUtil.getNavTitle(child);
							            	String childPath = WCMUtil.getURL(child, isAuthor);
							            	if(StringUtils.isNotEmpty(childPath)) childPath+="#"+ev5clickloc;
							            	%>
							            	<c:set var="varC1ChildPath" value="<%= childPath  %>"/>
							            	<c:set var="varC1ChildTitle" value="<%= childTitle  %>"/>
							            	<li><a href="${varC1ChildPath}">${varC1ChildTitle}</a></li>
							            	<%
											i++;						            	
							            	if (i > maxCount) break;
										}
									}
									%>
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC1type == 'manual-listing'}">
					    	<div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC1MlHeader}</h4>
					          	<ul>
					          	<% 
						        int limit = (c1ManualList.size() > maxCount) ? maxCount : c1ManualList.size();
						        for (int i = 0; i < limit; i++) {
						    		Node c1ManualListNode = c1ManualList.get(i);
						    		//cta-path, cta-anchor, cta-text_t, cta-open-new-win
						    	    String itemPath = WCMUtil.getNodePropertyValue(c1ManualListNode, "cta-path");
						    	    String itemText = WCMUtil.getNodePropertyValue(c1ManualListNode, "cta-text_t");
						    	    String itemAnchor= WCMUtil.getNodePropertyValue(c1ManualListNode, "cta-anchor");
						    	    boolean itemOpenNewWin = WCMUtil.getNodePropertyValue(c1ManualListNode, "cta-open-new-win").equals("true");
						    	    
						    	    if (itemText.isEmpty() && !itemPath.isEmpty()) {
						    	    	Page itemPage = pageManager.getPage(itemPath);
						    	    	itemText = (itemPage != null) ? WCMUtil.getNavTitle(itemPage) : "";
						    	    }
						    	    itemPath = WCMUtil.getURL(itemPath, isAuthor);

						    	    if (!itemAnchor.isEmpty()) {
					    	    		itemPath = itemPath + "#" + itemAnchor + ",clickloc=header";
						    	    } else {
						    	    	if(StringUtils.isNotEmpty(itemPath)) itemPath += "#"+ev5clickloc;
						    	    }
						    	%>
						    		<c:set var="varC1ItemText" value="<%= itemText  %>"/>
					            	<c:set var="varC1ItemPath" value="<%= itemPath  %>"/>
					            	<c:set var="varC1ItemOpenNewWin" value="<%= itemOpenNewWin  %>"/>
					            	<li><a href="${varC1ItemPath}" <c:out value="${varC1ItemOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC1ItemText}</a></li>
						    	<%
						    	}
						        %>	
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC1type == 'feature-banner'}">
					        <div class="submenu-box">
					        	<!-- submenu-box molecule start here-->
				         		<div class="row">
				            		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				              			<h4>${varC1Header}</h4>
				            		</div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><img class="img-responsive" src="${varC1ImgPath}"></div>
						            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						            	<p>${varC1Description}</p>
					    	        </div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><a class="btn btn-action btn-lg" href="${varC1ButtonPath}" <c:out value="${varC1ButtonOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC1ButtonText}</a></div>
					          	</div>
					          	<!-- submenu-box molecule end here-->
					        </div>
					    </c:when>
					</c:choose>
					</div>
					
					<%-- Column 2 --%>
		    		<div class="col-lg-4 col-md-4 col-sm-4">
				    <c:choose>
					    <c:when test="${varC2type == 'child-pages'}">
					        <div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC2CpHeader}</h4>
					          	<ul>
									<%
									if (!c2ParentPath.isEmpty()) {
										Page parentPage = pageManager.getPage(c2ParentPath);
										Iterator<Page> childIterator = parentPage.listChildren();
										int i = 1;
										while (childIterator.hasNext()) {
							            	Page child = childIterator.next();
							            	String childTitle = WCMUtil.getNavTitle(child);
							            	String childPath = WCMUtil.getURL(child, isAuthor);
							            	if(StringUtils.isNotEmpty(childPath)) childPath += "#"+ev5clickloc;
							            	%>
							            	<c:set var="varC2ChildPath" value="<%= childPath  %>"/>
							            	<c:set var="varC2ChildTitle" value="<%= childTitle  %>"/>
							            	<li><a href="${varC2ChildPath}">${varC2ChildTitle}</a></li>
							            	<%
											i++;						            	
							            	if (i > maxCount) break;
										}
									}
									%>
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC2type == 'manual-listing'}">
					    	<div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC2MlHeader}</h4>
					          	<ul>
					          	<% 
						        int limit = (c2ManualList.size() > maxCount) ? maxCount : c2ManualList.size();
						        for (int i = 0; i < limit; i++) {
						    		Node c2ManualListNode = c2ManualList.get(i);
						    		//cta-path, cta-anchor, cta-text_t, cta-open-new-win
						    	    String itemPath = WCMUtil.getNodePropertyValue(c2ManualListNode, "cta-path");
						    	    String itemText = WCMUtil.getNodePropertyValue(c2ManualListNode, "cta-text_t");
						    	    String itemAnchor= WCMUtil.getNodePropertyValue(c2ManualListNode, "cta-anchor");
						    	    boolean itemOpenNewWin = WCMUtil.getNodePropertyValue(c2ManualListNode, "cta-open-new-win").equals("true");
						    	    
						    	    if (itemText.isEmpty() && !itemPath.isEmpty()) {
						    	    	Page itemPage = pageManager.getPage(itemPath);
						    	    	itemText = (itemPage != null) ? WCMUtil.getNavTitle(itemPage) : "";
						    	    }
						    	    itemPath = WCMUtil.getURL(itemPath, isAuthor);

						    	    if (!itemAnchor.isEmpty()) {
					    	    		itemPath = itemPath + "#" + itemAnchor + "," + ev5clickloc;
						    	    } else {
						    	    	if(StringUtils.isNotEmpty(itemPath)) itemPath += "#"+ev5clickloc;
						    	    }
						    	%>
						    		<c:set var="varC2ItemText" value="<%= itemText  %>"/>
					            	<c:set var="varC2ItemPath" value="<%= itemPath  %>"/>
					            	<c:set var="varC2ItemOpenNewWin" value="<%= itemOpenNewWin  %>"/>
					            	<li><a href="${varC2ItemPath}" <c:out value="${varC2ItemOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC2ItemText}</a></li>
						    	<%
						    	}
						        %>	
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC2type == 'feature-banner'}">
					        <div class="submenu-box">
					        	<!-- submenu-box molecule start here-->
				         		<div class="row">
				            		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				              			<h4>${varC2Header}</h4>
				            		</div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><img class="img-responsive" src="${varC2ImgPath}"></div>
						            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						            	<p>${varC2Description}</p>
					    	        </div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><a class="btn btn-action btn-lg" href="${varC2ButtonPath}" <c:out value="${varC2ButtonOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC2ButtonText}</a></div>
					          	</div>
					          	<!-- submenu-box molecule end here-->
					        </div>
					    </c:when>
					</c:choose>
					</div>
				
					<%-- Column 3 --%>
		    		<div class="col-lg-4 col-md-4 col-sm-4">
				    <c:choose>
					    <c:when test="${varC3type == 'child-pages'}">
					        <div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC3CpHeader}</h4>
					          	<ul>
									<%
									if (!c3ParentPath.isEmpty()) {
										Page parentPage = pageManager.getPage(c3ParentPath);
										Iterator<Page> childIterator = parentPage.listChildren();
										int i = 1;
										while (childIterator.hasNext()) {
							            	Page child = childIterator.next();
							            	String childTitle = WCMUtil.getNavTitle(child);
							            	String childPath = WCMUtil.getURL(child, isAuthor);
							            	if(StringUtils.isNotEmpty(childPath)) childPath += ev5clickloc;
							            	%>
							            	<c:set var="varC3ChildPath" value="<%= childPath  %>"/>
							            	<c:set var="varC3ChildTitle" value="<%= childTitle  %>"/>
							            	<li><a href="${varC3ChildPath}">${varC3ChildTitle}</a></li>
							            	<%
											i++;						            	
							            	if (i > maxCount) break;
										}
									}
									%>
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC3type == 'manual-listing'}">
					    	<div class="links-group links-group-first">
				            	<h4 class="text-left secondary-color">${varC3MlHeader}</h4>
					          	<ul>
					          	<% 
						        int limit = (c3ManualList.size() > maxCount) ? maxCount : c3ManualList.size();
						        for (int i = 0; i < limit; i++) {
						    		Node c3ManualListNode = c3ManualList.get(i);
						    		//cta-path, cta-anchor, cta-text_t, cta-open-new-win
						    	    String itemPath = WCMUtil.getNodePropertyValue(c3ManualListNode, "cta-path");
						    	    String itemText = WCMUtil.getNodePropertyValue(c3ManualListNode, "cta-text_t");
						    	    String itemAnchor= WCMUtil.getNodePropertyValue(c3ManualListNode, "cta-anchor");
						    	    boolean itemOpenNewWin = WCMUtil.getNodePropertyValue(c3ManualListNode, "cta-open-new-win").equals("true");
						    	    
						    	    if (itemText.isEmpty() && !itemPath.isEmpty()) {
						    	    	Page itemPage = pageManager.getPage(itemPath);
						    	    	itemText = (itemPage != null) ? WCMUtil.getNavTitle(itemPage) : "";
						    	    }
						    	    itemPath = WCMUtil.getURL(itemPath, isAuthor);

						    	    if (!itemAnchor.isEmpty()) {
					    	    		itemPath = itemPath + "#" + itemAnchor + "," + ev5clickloc;
						    	    } else {
						    	    	if(StringUtils.isNotEmpty(itemPath)) itemPath += "#"+ev5clickloc;
						    	    }
						    	%>
						    		<c:set var="varC3ItemText" value="<%= itemText  %>"/>
					            	<c:set var="varC3ItemPath" value="<%= itemPath  %>"/>
					            	<c:set var="varC3ItemOpenNewWin" value="<%= itemOpenNewWin  %>"/>
					            	<li><a href="${varC3ItemPath}" <c:out value="${varC3ItemOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC3ItemText}</a></li>
						    	<%
						    	}
						        %>	
					          	</ul>
					        </div>
					    </c:when>
					    <c:when test="${varC3type == 'feature-banner'}">
					        <div class="submenu-box">
					        	<!-- submenu-box molecule start here-->
				         		<div class="row">
				            		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				              			<h4>${varC3Header}</h4>
				            		</div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><img class="img-responsive" src="${varC3ImgPath}"></div>
						            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						            	<p>${varC3Description}</p>
					    	        </div>
					            	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><a class="btn btn-action btn-lg" href="${varC3ButtonPath}" <c:out value="${varC3ButtonOpenNewWin == 'true' ? 'target=\"_blank\"' : '' }"/>>${varC3ButtonText}</a></div>
					          	</div>
					          	<!-- submenu-box molecule end here-->
					        </div>
					    </c:when>
					</c:choose>
					</div>
		      
		    	</div>
	
		    	<%	    	
		    	j++;
	    	}
	    }
	 }
	%>
	
  </div>
</div>
<!-- submenu molecule end here-->