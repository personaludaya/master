<%@include file="/apps/brands/global/global.jsp" %>
<%
// GENERAL
String navigationType = properties.get("navigation-type", "");
String ctaText 			= properties.get("cta-text_t", "");
String ctaPath 			= properties.get("cta-path", "");

// SELF LINK
boolean ctaOpenNewWin 	= properties.get("cta-open-new-win", "").equals("true");
boolean ctaHideInDesktop 	= properties.get("cta-hide-in-desktop", "").equals("true");

// DISPLAY PANEL
int maxLink 			= properties.get("max-link", 7);
String c1type 			= properties.get("c1-type", "");
String c1CpHeader		= properties.get("c1-cp-header_t", "");
String c1ParentPath		= properties.get("c1-parent-path", "");
String c1MlHeader		= properties.get("c1-ml-header_t", "");
List<Node> c1ManualList	= WCMUtil.getMultiCompositePropertyNodeList(currentNode, "c1-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
String c1ImgPath		= properties.get("c1-img-path", "");
String c1Header			= properties.get("c1-header_t", "");
String c1Description	= properties.get("c1-description_t", "");
String c1ButtonText		= properties.get("c1-button-text_t", "");
String c1ButtonPath		= properties.get("c1-button-path", "");
boolean c1ButtonOpenNewWin = properties.get("c1-button-open-new-win", "").equals("true");

String c2type 			= properties.get("c2-type", "");
String c2CpHeader		= properties.get("c2-cp-header_t", "");
String c2ParentPath		= properties.get("c2-parent-path", "");
String c2MlHeader		= properties.get("c2-ml-header_t", "");
List<Node> c2ManualList	= WCMUtil.getMultiCompositePropertyNodeList(currentNode, "c2-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
String c2ImgPath		= properties.get("c2-img-path", "");
String c2Header			= properties.get("c2-header_t", "");
String c2Description	= properties.get("c2-description_t", "");
String c2ButtonText		= properties.get("c2-button-text_t", "");
String c2ButtonPath		= properties.get("c2-button-path", "");
boolean c2ButtonOpenNewWin = properties.get("c2-button-open-new-win", "").equals("true");

String c3type 			= properties.get("c3-type", "");
String c3CpHeader		= properties.get("c3-cp-header_t", "");
String c3ParentPath		= properties.get("c3-parent-path", "");
String c3MlHeader		= properties.get("c3-ml-header_t", "");
List<Node> c3ManualList	= WCMUtil.getMultiCompositePropertyNodeList(currentNode, "c3-manual-listing"); //cta-path, cta-anchor, cta-text_t, cta-open-new-win
String c3ImgPath		= properties.get("c3-img-path", "");
String c3Header			= properties.get("c3-header_t", "");
String c3Description	= properties.get("c3-description_t", "");
String c3ButtonText		= properties.get("c3-button-text_t", "");
String c3ButtonPath		= properties.get("c3-button-path", "");
boolean c3ButtonOpenNewWin = properties.get("c3-button-open-new-win", "").equals("true");

// CTA TEXT
if (ctaText.isEmpty()) {
	Page ctaPage = pageManager.getPage(ctaPath);
	if (ctaPage != null) {
		ctaText = WCMUtil.getNavTitle(ctaPage);
	}
}

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

<c:set var="varNavigationType" value="<%= navigationType  %>"/>
<c:set var="varCtaText" value="<%= ctaText  %>"/>
<c:set var="varCtaPath" value="<%= WCMUtil.getURL(ctaPath, isAuthor)  %>"/>
<c:set var="varCtaOpenNewWin" value="<%= ctaOpenNewWin  %>"/>
<c:set var="varHideInDesktop" value="<%= ctaHideInDesktop %>"/>

<c:set var="varMaxLink" value="<%= maxLink  %>"/>
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

<cq:include script="top-nav-admin-style.jsp" />

<br/>
<h4 style="color:white">Header - Top Navigation Configurations for <b style="color:#83FF00">${varCtaText}</b></h4>
<br/>

<table width="88%" align="center">
	<tr>
		<td width="20%">Navigation Type</td>
		<td>${varNavigationType}</td>
	</tr>
	<tr>
		<td>CTA Text</td>
		<td>${varCtaText}</td>
	</tr>
	<tr>
		<td>CTA Path</td>
		<td><a href="${varCtaPath}" target="_blank">${varCtaPath}</a></td>
	</tr>
	<c:if test = "${varNavigationType == 'self-link'}">
		<tr>
			<td>CTA - Open in new window?</td>
			<td>${varCtaOpenNewWin}</td>
		</tr>
		<tr>
			<td>CTA - Hide in desktop?</td>
			<td>${varHideInDesktop}</td>
		</tr>
	</c:if>
</table>
<br/>

<%-- Sub menu panel--%>
<c:if test = "${varNavigationType == 'display-panel'}">
	<div class="cq-submenu hidden-xs" id="submenu" style="display:block;">
		<div class="container-fluid">
	    	<div class="row" data-menu-id="menu1">
	    	
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
						            	%>
						            	<c:set var="varC1ChildPath" value="<%= childPath  %>"/>
						            	<c:set var="varC1ChildTitle" value="<%= childTitle  %>"/>
						            	<li><a href="${varC1ChildPath}">${varC1ChildTitle}</a></li>
						            	<%
										i++;						            	
						            	if (i > maxLink) break;
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
					        int limit = (c1ManualList.size() > maxLink) ? maxLink : c1ManualList.size();
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
				    	    		itemPath = itemPath + "#" + itemAnchor;
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
						            	%>
						            	<c:set var="varC2ChildPath" value="<%= childPath  %>"/>
						            	<c:set var="varC2ChildTitle" value="<%= childTitle  %>"/>
						            	<li><a href="${varC2ChildPath}">${varC2ChildTitle}</a></li>
						            	<%
										i++;						            	
						            	if (i > maxLink) break;
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
					        int limit = (c2ManualList.size() > maxLink) ? maxLink : c2ManualList.size();
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
				    	    		itemPath = itemPath + "#" + itemAnchor;
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
						            	%>
						            	<c:set var="varC3ChildPath" value="<%= childPath  %>"/>
						            	<c:set var="varC3ChildTitle" value="<%= childTitle  %>"/>
						            	<li><a href="${varC3ChildPath}">${varC3ChildTitle}</a></li>
						            	<%
										i++;						            	
						            	if (i > maxLink) break;
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
					        int limit = (c3ManualList.size() > maxLink) ? maxLink : c3ManualList.size();
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
				    	    		itemPath = itemPath + "#" + itemAnchor;
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
		</div>
	</div>
</c:if>

<hr/>