<%@include file="/apps/brands/global/global.jsp" %>
<%
String contactUsLabel = properties.get("contactUsLabel_t", "");
String contactUsPath = WCMUtil.getURL(properties.get("contactUsPath", ""), isAuthor);
String sendMessageLabel = properties.get("sendMessageLabel_t", "");
String sendMessagePath = WCMUtil.getURL(properties.get("sendMessagePath", ""), isAuthor);
String desktopDiallable = properties.get("desktopDialable", "false");
String operatingHours = properties.get("operatingHours_t", "");
String officeAddressLabel = properties.get("officeAddressLabel_t", "");
String officeAddress = properties.get("officeAddress", "");

String joinBrandsLabel = properties.get("joinBrandsLabel_t", "");
String joinBrandsPath = WCMUtil.getURL(properties.get("joinBrandsPath", ""));
String shopOnlineLabel = properties.get("shopOnlineLabel_t", "");
String shopOnlinePath = WCMUtil.getURL(properties.get("shopOnlinePath", ""));
String storeFinderLabel = properties.get("storeFinderLabel_t", "");
String storeFinderPath = WCMUtil.getURL(properties.get("storeFinderPath", ""));

//customer care
List<Node> customerCareList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "customer-care");

//social 
String followUsLabel = properties.get("followUsLabel_t", "");
List<Node> socialMediaList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "socialShare");

%>
<c:set var="varContactUsLabel" value="<%= contactUsLabel  %>"/>
<c:set var="varContactUsPath" value="<%= contactUsPath  %>"/>
<c:set var="varSendMessageLabel" value="<%= sendMessageLabel  %>"/>
<c:set var="varSendMessagePath" value="<%= sendMessagePath  %>"/>
<c:set var="varDesktopDiallable" value="<%= desktopDiallable  %>"/>
<c:set var="varOperatingHours" value="<%= operatingHours  %>"/>
<c:set var="varOfficeAddressLabel" value="<%= officeAddressLabel  %>"/>
<c:set var="varOfficeAddress" value="<%= officeAddress  %>"/>

<c:set var="varJoinBrandsLabel" value="<%= joinBrandsLabel  %>"/>
<c:set var="varJoinBrandsPath" value="<%= joinBrandsPath  %>"/>
<c:set var="varShopOnlineLabel" value="<%= shopOnlineLabel  %>"/>
<c:set var="varShopOnlinePath" value="<%= shopOnlinePath  %>"/>
<c:set var="varStoreFinderLabel" value="<%= storeFinderLabel  %>"/>
<c:set var="varStoreFinderPath" value="<%= storeFinderPath  %>"/>

<c:set var="varFollowUsLabel" value="<%= followUsLabel  %>"/>

<h4 style = "color:white">Contact Info Configurations</h4>
<table>
	<tr>
		<td>Contact Us</td>
		<td><a href = "${varContactUsPath }">${ varContactUsLabel}</a></td>
	</tr>
	<tr>
		<td>Send Message</td>
		<td><a href = "${varSendMessagePath }">${ varSendMessageLabel}</a></td>
	</tr>
	<tr>
		<td>Customer Care</td>
		<td>
			<%
			if(customerCareList != null){
				for (int i = 0; i < customerCareList.size(); i++) {
					Node customerCareNode = customerCareList.get(i);
				    String careLabel = WCMUtil.getNodePropertyValue(customerCareNode, "customer-care-label_t");
				    String careLine = WCMUtil.getNodePropertyValue(customerCareNode, "customer-care-line");
				    String careNote = WCMUtil.getNodePropertyValue(customerCareNode, "customer-care-note_t");
				
				    %>
				    <ul>
				    <li>Label: <%= careLabel%></li>
				    <li>Line number: <%= careLine%></li>
				    <li>Note: <%= careNote%></li>
				    </ul>
				    <%
					
				}
			}
			%>
		</td>
	</tr>
	<tr>
		<td>Operating Hours</td>
		<td>${ varOperatingHours}</td>
	</tr>
	<tr>
		<td>Office Address Label</td>
		<td>${ varOfficeAddressLabel}</td>
	</tr>
	<tr>
		<td>Office Address</td>
		<td>${ varOfficeAddress}</td>
	</tr>
	<tr>
		<td>Join Brands</td>
		<td><a href = "${varJoinBrandsPath }">${ varJoinBrandsLabel}</a></td>
	</tr>
	<tr>
		<td>Shop Online</td>
		<td><a href = "${varShopOnlinePath }">${ varShopOnlineLabel}</a></td>
	</tr>
	<tr>
		<td>Store Finder</td>
		<td><a href = "${varStoreFinderPath }">${ varStoreFinderPath}</a></td>
	</tr>
	<tr>
		<td>Follow Us Label</td>
		<td>${ varFollowUsLabel}</td>
	</tr>
	<tr>
		<td>Facebook URL</td>
		<td>
		<%
		if(socialMediaList != null){
			for (int i = 0; i < socialMediaList.size(); i++) {
				Node socialMediaNode = socialMediaList.get(i);
			    String socialIcon = WCMUtil.getNodePropertyValue(socialMediaNode, "social-icon");
			    String socialLabel = WCMUtil.getNodePropertyValue(socialMediaNode, "social-name_t");
			    String socialUrl = WCMUtil.getNodePropertyValue(socialMediaNode, "social-url");
			
			    %>
			    <ul>
			    <li>Icon:
			    	<c:set var="varSocialIcon" value="<%= socialIcon  %>"/>
			    	<c:if test="${not empty varSocialIcon}">
				    <svg class="brands-icon icon-white">
	                  <use href="<%=imgPath%>/icons/symbol-defs.svg#<%=socialIcon %>" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#<%= socialIcon%>"></use>
	                </svg>
	                </c:if>
                </li>
			    <li>Label: <a href="<%= socialUrl%>"><%= socialLabel%></a></li>
			    </ul>
			    <%
				
			}
		}
		%>
		</td>
	</tr>
	
</table>

