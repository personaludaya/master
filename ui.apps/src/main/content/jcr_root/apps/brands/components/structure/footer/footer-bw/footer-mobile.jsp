<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%
String ev5clickloc = "clickloc=footer";
String contactInfoConfigPath = pageProperties.getInherited("contactConfigPath", "");
Resource contactInfoRes = resourceResolver.resolve(contactInfoConfigPath + "/jcr:content/par/contactinfo_admin_bw");
Node contactInfoNode = null;
Resource customerCareRes = null;
Resource socialShareRes = null;
if(contactInfoRes != null){
	contactInfoNode = contactInfoRes.adaptTo(Node.class);
	customerCareRes = contactInfoRes.getChild("customer-care");
 	socialShareRes = contactInfoRes.getChild("socialShare");
}

String footerConfigPath = pageProperties.getInherited("footerConfigPath", "");
Resource footerRes = resourceResolver.resolve(footerConfigPath + "/jcr:content/par/footer_admin_bw");
Node footerNode = footerRes.adaptTo(Node.class);
Resource rLeftListRes = resourceResolver.resolve(footerConfigPath + "/jcr:content/par/footer_admin_bw/leftList");
Resource rRightListRes = resourceResolver.resolve(footerConfigPath + "/jcr:content/par/footer_admin_bw/rightList");
String[] btmrCtaPathsArr = WCMUtil.getNodePropertyValues(footerNode, "btmrCtaPaths");
String[] aboutBrandsPathArr = WCMUtil.getNodePropertyValues(footerNode, "aboutBrandsPaths");

//Modify paths for analytics
String contactUsPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "contactUsPath"));
if(StringUtils.isNotEmpty(contactUsPath)) contactUsPath += "#"+ev5clickloc;
String sendMessagePath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "sendMessagePath"), isAuthor);
if(StringUtils.isNotEmpty(sendMessagePath)) sendMessagePath += "#"+ev5clickloc;
String joinBrandsPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "joinBrandsPath"), isAuthor);
if(StringUtils.isNotEmpty(joinBrandsPath)) joinBrandsPath += "#"+ev5clickloc;
String shopOnlinePath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "shopOnlinePath"), isAuthor);
String storeFinderPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "storeFinderPath"), isAuthor);
if(StringUtils.isNotEmpty(storeFinderPath)) storeFinderPath += "#"+ev5clickloc;
%>

<c:set var="varContactUsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "contactUsLabel_t") %>"/>
<c:set var="varContactUsPath" value="<%= contactUsPath %>"/>
<c:set var="varSendMessageLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "sendMessageLabel_t") %>"/>
<c:set var="varSendMessagePath" value="<%= sendMessagePath %>"/>
<c:set var="varOfficeAddressLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddressLabel_t") %>"/>
<c:set var="varOfficeAddress" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddress") %>"/>

<c:set var="varJoinBrandsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "joinBrandsLabel_t") %>"/>
<c:set var="varJoinBrandsPath" value="<%= joinBrandsPath %>"/>
<c:set var="varShopOnlineLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "shopOnlineLabel_t") %>"/>
<c:set var="varShopOnlinePath" value="<%= shopOnlinePath %>"/>
<c:set var="varStoreFinderLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "storeFinderLabel_t") %>"/>
<c:set var="varStoreFinderPath" value="<%= storeFinderPath%>"/>

<c:set var="varFollowUsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "followUsLabel_t") %>"/>

<c:set var="varAboutBrandsPathArr" value="<%= WCMUtil.getNodePropertyValues(footerNode, "aboutBrandsPaths") %>"/>
<c:set var="varCallToOrderLabel" value="<%= WCMUtil.getNodePropertyValue(footerNode, "callToOrderLabel_t") %>"/>
<c:set var="varAboutBrandsLabel" value="<%= WCMUtil.getNodePropertyValue(footerNode, "aboutBrandsLabel_t") %>"/>
<c:set var="varBtmrCtaPathsArr" value="<%= btmrCtaPathsArr  %>"/>

<div class="row footer hidden-lg hidden-md">
  <div class="col-xs-12 footer-wrapper">
    <div class="row">
      <div class="col-xs-6 call-to-order">
      		<%
			if(customerCareRes != null){
				//possible to render multiple customer care sections by adding while loop
				Iterator<Resource> customerCareIt = customerCareRes.listChildren();
				Resource customerCareItemRes = customerCareIt.next();
				Node customerCareItemNode = customerCareItemRes.adaptTo(Node.class);
				String ccLabel = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-label_t");
				String ccLine = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-line");
				String ccNote = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-note_t");
	
				%>
				<c:set var="varCcLabel" value="<%= ccLabel %>"/>
				<c:set var="varCcLine" value="<%= ccLine.replaceAll(" ", "").trim() %>"/>
				<c:set var="varCcNote" value="<%= ccNote %>"/>
				<a href="tel:${varCcLine }" class="btn btn-default full-width btn-lg">
				<% 
			}
	        %>
          <svg class="brands-icon icon-white pull-left toolbar">
            <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-call" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-call"></use>
          </svg><span>${varCallToOrderLabel }</span>
          </a>
      </div>
      <div class="col-xs-6 shop-online"><a target="_blank" data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"footer:footer","eventURL": "${varShopOnlinePath}","eventAction": "online store"}}}' href="${varShopOnlinePath }" class="btn btn-default full-width btn-lg">
          <svg class="brands-icon icon-white pull-left toolbar">
            <use target="_blank" href="<%=imgPath%>/icons/symbol-defs.svg#icon-trolley" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-trolley"></use>
          </svg><span>${varShopOnlineLabel }</span></a></div>
    </div>
    <div class="row">
      <div class="col-xs-5 col-xs-offset-1"><a href="${varContactUsPath }" class="btn btn-link">${varContactUsLabel }</a></div>
      <div class="col-xs-5"><a href="${varStoreFinderPath }" class="btn btn-link">${varStoreFinderLabel }</a></div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <h3 class="text-center">${varAboutBrandsLabel }</h3>
        <c:if test="${fn:length(varAboutBrandsPathArr) > 0}">
	        <ul class="about-brands-links">
	          <%
	          for(String path: aboutBrandsPathArr){
	        	  Page brandsPage = pageManager.getPage(path);
	        	  String brandsPagePath = WCMUtil.getURL(path, isAuthor);
	        	  if(StringUtils.isNotEmpty(brandsPagePath)) brandsPagePath += "#"+ev5clickloc;
	        	  %>
	        	  <c:set var="varBrandsPagePath" value="<%= brandsPagePath %>"/>
	        	  <c:set var="varBrandsPageTitle" value="<%= WCMUtil.getNavTitle(brandsPage) %>"/>
	        	  <li><a href="${ varBrandsPagePath}">${varBrandsPageTitle }</a></li>
	        	  <%
	          }
	          %>
	        </ul>
        </c:if>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="follow-us">
          <ul>
            <%
			if(socialShareRes != null){
				Iterator<Resource> socialShareIt = socialShareRes.listChildren();
				while(socialShareIt.hasNext()){
					Resource socialItemRes = socialShareIt.next();
					Node socialItemNode = socialItemRes.adaptTo(Node.class);
					String socialIcon = WCMUtil.getNodePropertyValue(socialItemNode, "social-icon");
					String socialLabel = WCMUtil.getNodePropertyValue(socialItemNode, "social-name_t");
					String socialPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(socialItemNode, "social-url"), isAuthor);
					%>
					<c:set var="varSocialIcon" value="<%= socialIcon %>"/>
					<c:set var="varSocialLabel" value="<%= socialLabel %>"/>
					<c:set var="varSocialPath" value="<%= socialPath %>"/>
					
					<c:if test="${not empty varSocialPath }">
                   		<li><a href="${ varSocialPath}" target="_blank" data-analytics='{ "event":{ "eventInfo":{ "eventType": "social_follow", "eventName": "${varSocialLabel}", "eventURL": "${varSocialPath}"}}}'>
	                        <svg class="brands-icon icon-white">
	                           <use href="<%=imgPath%>/icons/symbol-defs.svg#${varSocialIcon}" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#${varSocialIcon}"></use>
	                        </svg></a>
                    	</li>
                   	</c:if>
					<% 
				}
			}
		    %>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
      	<a href = "${varJoinBrandsPath }">
	        <div class="join-brands-worldclub">
	          <div class="join-brands-worldclub-wrapper">
	            <ul>
	              <li>
	                <svg class="brands-icon icon-white">
	                  <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-membership" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-membership"></use>
	                </svg>
	              </li>
	              <li>
	                <p>${varJoinBrandsLabel }</p>
	              </li>
	            </ul>
	          </div>
	        </div>
        </a>
      </div>
    </div>
  </div>
</div>