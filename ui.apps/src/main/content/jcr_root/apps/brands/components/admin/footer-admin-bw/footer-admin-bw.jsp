<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%
List<Node> rightSideItemLeftList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "leftList");
List<Node> rightSideItemRightList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "rightList");
String[] btmrCtaPathsArr = properties.get("btmrCtaPaths", String[].class);

//Mobile view props
String callToOrderLabel = properties.get("callToOrderLabel_t", "");
String aboutBrandsLabel = properties.get("aboutBrandsLabel_t", "");
String[] aboutBrandsPathArr = properties.get("aboutBrandsPaths", String[].class);
%>
<%-- Mobile view c tags --%>
<c:set var="varCallToOrderLabel" value="<%= callToOrderLabel  %>"/>
<c:set var="varAboutBrandsLabel" value="<%= aboutBrandsLabel  %>"/>

<h4 style = "color:white">Mobile Configurations</h4>
<table>
	<tr>
		<td>Mobile configurations</td>
	</tr>
	<tr>
		<td>Call To Order Label</td>
		<td>${ varCallToOrderLabel}</td>
	</tr>
	<tr>
		<td>About Brands Label</td>
		<td>${varAboutBrandsLabel }</td>
	</tr>
	<tr>
		<td>Paths below "About Brands"</td>
		<td>
		<%
		if(aboutBrandsPathArr != null){
			for (int j = 0; j < aboutBrandsPathArr.length ; j++) {
				Page brandsPage = pageManager.getPage(aboutBrandsPathArr[j]);
		    %>
		        <c:set var="varBrandsPagePath" value="<%= WCMUtil.getNavTitle(brandsPage)  %>"/>
		        <li><a href="<%=WCMUtil.getURL(brandsPage)%>">${ varBrandsPagePath}</a></li>
		            
		    <% }
		}%>
		</td>
	</tr>
</table>
<hr>
<h4 style = "color:white">Right-side Footer Configurations</h4>
<h4 style = "color:white">Instructions:</h4>
<ul>
	<li>Admin Component for configuring the Footer properties</li>
	<li>To render horizontal rules (sections) in right side of footer, please add a new "Section Start" and "Section End" element item in dialog.</li>
	<li>Any items between these 2 "Section" elements will be considered as a single section</li>
</ul>
<hr>
<h3 style="color:white">Extra CTA Links</h3>
<ul>
	<%
	if(btmrCtaPathsArr != null){
		for (int j = 0; j < btmrCtaPathsArr.length ; j++) {
			Page btmRightLinkPage = pageManager.getPage(btmrCtaPathsArr[j]);
	    %>
	        <c:set var="varBtmRightLinkLabel" value="<%= WCMUtil.getNavTitle(btmRightLinkPage)  %>"/>
	        <li><a href="<%=WCMUtil.getURL(btmRightLinkPage)%>">${ varBtmRightLinkLabel}</a></li>
	            
	    <% }
	}%>
</ul>
<hr>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	<h3 style="color:white">Left List</h3>
	<hr>
	<%
	for (int i = 0; i < rightSideItemLeftList.size(); i++) {
		Node leftSideItemNode = rightSideItemLeftList.get(i);
	    String itemType = WCMUtil.getNodePropertyValue(leftSideItemNode, "item-type");
	    String itemValue = WCMUtil.getNodePropertyValue(leftSideItemNode, "item-value");
	    String itemAnchor = WCMUtil.getNodePropertyValue(leftSideItemNode, "item-anchor");
	    String itemAltName = WCMUtil.getNodePropertyValue(leftSideItemNode, "item-altname");
	    String ctaNewtab = WCMUtil.getNodePropertyValue(leftSideItemNode, "cta-newtab");
		String itemTarget = "";
		if(StringUtils.isNotEmpty(ctaNewtab)){
			itemTarget = "_blank";
		}
			
		if(itemType.equalsIgnoreCase("header")){
			//get value as string
			%>
			<c:set var="varleftSideHeader" value="<%= itemValue  %>"/>
			<h4 style = "color:white">${varleftSideHeader }</h4>
			<%
		} else if(itemType.equalsIgnoreCase("section-start")){
			%><hr><ul><%
		} else if(itemType.equalsIgnoreCase("cta")){
			//get value as path -> page
			Page ctaPage = pageManager.getPage(itemValue);
			itemValue = WCMUtil.getURL(itemValue);
			if(StringUtils.isNotEmpty(itemAnchor)) itemValue = itemValue + "#"+ itemAnchor;
			if(StringUtils.isBlank(itemAltName)){
				itemAltName = WCMUtil.getNavTitle(ctaPage);
			}
			%>
			<c:set var="varLeftSideCtaItemLabel" value="<%= itemAltName  %>"/>
			<c:set var="varLeftSideCtaItemValue" value="<%= itemValue  %>"/>
			<c:set var="varLeftSideCtaTarget" value="<%= itemTarget  %>"/>
			
			<li><a href="${varLeftSideCtaItemValue }" target="${varLeftSideCtaTarget }">${varLeftSideCtaItemLabel }</a></li>
			<%
		} else if(itemType.equalsIgnoreCase("section-end")){
			%></ul><hr><%
		}
	}
	%>
</div>

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	<h3 style="color:white">Right List</h3>
	<hr>
	<%
	for (int i = 0; i < rightSideItemRightList.size(); i++) {
		Node rightSideItemNode = rightSideItemRightList.get(i);
	    String itemType = WCMUtil.getNodePropertyValue(rightSideItemNode, "item-type");
	    String itemValue = WCMUtil.getNodePropertyValue(rightSideItemNode, "item-value");
	    String itemAnchor = WCMUtil.getNodePropertyValue(rightSideItemNode, "item-anchor");
	    String itemAltName = WCMUtil.getNodePropertyValue(rightSideItemNode, "item-altname");
	    String ctaNewtab = WCMUtil.getNodePropertyValue(rightSideItemNode, "cta-newtab");
		String itemTarget = "";
		if(StringUtils.isNotEmpty(ctaNewtab)){
			itemTarget = "_blank";
		}
	    
		if(itemType.equalsIgnoreCase("header")){
			//get value as string
			%>
			<c:set var="varRightSideHeader" value="<%= itemValue  %>"/>
			<h4 style = "color:white">${varRightSideHeader }</h4>
			<%
		} else if(itemType.equalsIgnoreCase("section-start")){
			%><hr><ul><%
		} else if(itemType.equalsIgnoreCase("cta")){
			//get value as path -> page
			Page ctaPage = pageManager.getPage(itemValue);
			itemValue = WCMUtil.getURL(itemValue);
			itemValue = itemValue + "#"+ itemAnchor;
			if(StringUtils.isBlank(itemAltName)){
				itemAltName = WCMUtil.getNavTitle(ctaPage);
			}
			%>
			<c:set var="varRightSideCtaItemLabel" value="<%= itemAltName  %>"/>
			<c:set var="varRightSideCtaItemValue" value="<%= itemValue  %>"/>
			<c:set var="varRightSideCtaTarget" value="<%= itemTarget  %>"/>
			<li><a href="${varRightSideCtaItemValue }" target="${varRightSideCtaTarget }">${varRightSideCtaItemLabel }</a></li>
			<%
		} else if(itemType.equalsIgnoreCase("section-end")){
			%></ul><hr><%
		}
	}
	%>
</div>
<hr>



