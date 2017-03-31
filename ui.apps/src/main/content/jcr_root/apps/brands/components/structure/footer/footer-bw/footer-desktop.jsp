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

//Modify path values for analytics
String sendMessagePath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "sendMessagePath"), isAuthor);
if(StringUtils.isNotEmpty(sendMessagePath)) sendMessagePath += "#"+ev5clickloc;
String joinBrandsPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "joinBrandsPath"), isAuthor);
if(StringUtils.isNotEmpty(joinBrandsPath)) joinBrandsPath += "#"+ev5clickloc;
String shopOnlinePath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "shopOnlinePath"), isAuthor);
String storeFinderPath = WCMUtil.getURL(WCMUtil.getNodePropertyValue(contactInfoNode, "storeFinderPath"), isAuthor);
if(StringUtils.isNotEmpty(storeFinderPath)) storeFinderPath += "#"+ev5clickloc;

%>

<c:set var="varContactUsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "contactUsLabel_t") %>"/>
<c:set var="varSendMessageLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "sendMessageLabel_t") %>"/>
<c:set var="varSendMessagePath" value="<%= sendMessagePath%>"/>
<c:set var="varOfficeAddressLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddressLabel_t") %>"/>
<c:set var="varOfficeAddress" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddress") %>"/>

<c:set var="varJoinBrandsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "joinBrandsLabel_t") %>"/>
<c:set var="varJoinBrandsPath" value="<%= joinBrandsPath %>"/>
<c:set var="varShopOnlineLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "shopOnlineLabel_t") %>"/>
<c:set var="varShopOnlinePath" value="<%= shopOnlinePath %>"/>
<c:set var="varStoreFinderLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "storeFinderLabel_t") %>"/>
<c:set var="varStoreFinderPath" value="<%= storeFinderPath %>"/>

<c:set var="varFollowUsLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "followUsLabel_t") %>"/>

<c:set var="varBtmrCtaPathsArr" value="<%= btmrCtaPathsArr  %>"/>

<div class="row hidden-xs hidden-sm footer">
  <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div class="row inherit-height">
      <div class="col-lg-12 col-md-12 col-sm-12 inherit-height">
        <div class="footer-wrapper">
          <div class="row">
            <div class="col-lg-7 col-md-7 col-sm-7 footer-left-col">
              <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                  <h4 class="text-left">${varContactUsLabel}</h4>
                  <ul class="contact-us">
                    <li>
                      <svg class="brands-icon icon-white pull-left">
                        <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-email-secondary" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-email-secondary"></use>
                      </svg><span><a href = "${varSendMessagePath} ">${varSendMessageLabel} <c:if test="${not empty varSendMessageLabel}">&rsaquo;</c:if></a></span>
                    </li>
                    <li>
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
							<c:set var="varCcLine" value="<%= ccLine %>"/>
							<c:set var="varCcNote" value="<%= ccNote %>"/>
							
							<c:if test="${not empty varCcLine || varCCLabel}">
                           		<svg class="brands-icon icon-white pull-left">
	                    			<use href="<%=imgPath%>/icons/symbol-defs.svg#icon-call" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-call"></use>
	                    		</svg>
                           	</c:if>
                           	<span>${varCcLabel}</span>
                           	<h4 class="text-left">${varCcLine}</h4>
                           	<c:if test="${not empty varCcLine}">
                           		<p>${varCcNote}</p>
                           	</c:if>
							<% 
						}
	                    %>
                    </li>
                    <li>
                      <c:if test="${not empty varOfficeAddressLabel }">
                      	<svg class="brands-icon icon-white pull-left">
                        	<use href="<%=imgPath%>/icons/symbol-defs.svg#icon-building" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-building"></use>
                      	</svg>
                      </c:if>
                      
                      <span>${varOfficeAddressLabel }</span>
                      <p>
                         ${varOfficeAddress }</p>
                    </li>
                  </ul>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                  <ul class="others">
                  	 <c:if test="${not empty varJoinBrandsLabel }">
	                    <li>
	                      <div class="row">
	                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	                         	<c:if test="${not empty varJoinBrandsPath }"><a href = "${varJoinBrandsPath }"></c:if>
	                          	<div class="join-brands-worldclub">
		                            <svg class="brands-icon icon-white pull-left">
		                              <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-membership" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-membership"></use>
		                            </svg>
		                            <div class="join-brands-worldclub-wrapper">
		                              <p>${varJoinBrandsLabel }</p>
		                            </div>
	                          	</div>
	                          	<c:if test="${not empty varJoinBrandsPath }"></a></c:if>	                          
	                        </div>
	                      </div>
	                    </li>
                   </c:if>
                   
                    <li>
                    	<c:if test="${not empty varShopOnlineLabel && not empty varShopOnlinePath}">
                    		<div class="row">
		                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><a data-analytics='{"event":{"eventInfo":{"eventType":"ecommerce","eventName":"footer:footer","eventURL": "${varShopOnlinePath}","eventAction": "online store"}}}' target="_blank" class="btn btn-default btn-lg" href="${varShopOnlinePath }">
		                            <svg class="brands-icon icon-white">
		                              <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-trolley" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-trolley"></use>
		                            </svg>${varShopOnlineLabel }</a></div>
		                     </div>
                   		</c:if>
                   		<c:if test="${not empty varStoreFinderLabel && not empty varStoreFinderPath }">
                   			<div class="row">
		                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		                          <div class="view-all-wrapper text-left"><a href="${varStoreFinderPath }" class="view-all">${varStoreFinderLabel }
		                              <svg class="brands-icon icon-white link-icon-small">
		                                <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-right" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-right"></use>
		                              </svg></a></div>
		                        </div>
		                      </div>
                   		</c:if>
                      
                    
                      <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                          <div class="follow-us">
                            <c:if test="${not empty varFollowUsLabel }"><p>${varFollowUsLabel }</p></c:if>
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
		                            		<li><a href="${ varSocialPath}" target="_blank" data-analytics='{"event":{"eventInfo":{"eventType":"social_follow","eventName":"${varSocialLabel}","eventURL": "${varSocialPath}"}}}'>
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
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-lg-5 col-md-5 col-sm-5 about-brands">
              <div class="row">
                <div class="col-lg-5 col-md-5 col-sm-5 col-lg-offset-1 col-md-offset-1 col-sm-offset-1">
					<%
					if(rLeftListRes != null){
						Iterator<Resource> leftListIt = rLeftListRes.listChildren();
						while(leftListIt.hasNext()){
							Resource leftListItemRes = leftListIt.next();
							Node leftListItemNode = leftListItemRes.adaptTo(Node.class);
							String itemType = WCMUtil.getNodePropertyValue(leftListItemNode, "item-type");
							String itemValue = WCMUtil.getNodePropertyValue(leftListItemNode, "item-value");
							String itemAnchor = WCMUtil.getNodePropertyValue(leftListItemNode, "item-anchor");
						    String itemAltName = WCMUtil.getNodePropertyValue(leftListItemNode, "item-altname");
							String ctaNewtab = WCMUtil.getNodePropertyValue(leftListItemNode, "cta-newtab");
							String itemTarget = "";
							if(StringUtils.isNotEmpty(ctaNewtab)){
								itemTarget = "target='_blank'";
							}
							if(itemType.equalsIgnoreCase("header")){
								%>
								<c:set var="varLeftListHeader" value="<%= itemValue  %>"/>
								<h5 class="text-left">${varLeftListHeader }</h5>
								<%
							} else if(itemType.equalsIgnoreCase("section-start")){
								%><ul class="border-bottom"><%
							} else if(itemType.equalsIgnoreCase("cta")){
								Page ctaPage = pageManager.getPage(itemValue);
								itemValue = WCMUtil.getURL(itemValue, isAuthor);
								if(StringUtils.isNotEmpty(itemAnchor)) itemValue = itemValue + "#"+ itemAnchor + "," + ev5clickloc;
								else itemValue += "#"+ev5clickloc;
								if(StringUtils.isBlank(itemAltName)){
									itemAltName = WCMUtil.getNavTitle(ctaPage);
								}
								%>
								<c:set var="varLeftListItemLabel" value="<%= itemAltName %>"/>
								<c:set var="varLeftListItemVal" value="<%= itemValue  %>"/>
								<c:set var="varLeftSideCtaTarget" value="<%= itemTarget  %>"/>
								<li> <a href="${varLeftListItemVal }" ${varLeftSideCtaTarget }>${varLeftListItemLabel }</a></li>
								<%
							} else if(itemType.equalsIgnoreCase("section-end")){
								%></ul><%
							}
						}
					}
					%>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                  	<%
                  	if(rRightListRes != null){
						Iterator<Resource> rightListIt = rRightListRes.listChildren();
						while(rightListIt.hasNext()){
							Resource rightListItemRes = rightListIt.next();
							Node rightListItemNode = rightListItemRes.adaptTo(Node.class);
							String itemType = WCMUtil.getNodePropertyValue(rightListItemNode, "item-type");
							String itemValue = WCMUtil.getNodePropertyValue(rightListItemNode, "item-value");
							String itemAnchor = WCMUtil.getNodePropertyValue(rightListItemNode, "item-anchor");
						    String itemAltName = WCMUtil.getNodePropertyValue(rightListItemNode, "item-altname");
							String ctaNewtab = WCMUtil.getNodePropertyValue(rightListItemNode, "cta-newtab");
							String itemTarget = "";
							if(StringUtils.isNotEmpty(ctaNewtab)){
								itemTarget = "target='_blank'";
							}
							if(itemType.equalsIgnoreCase("header")){
								%>
								<c:set var="varRightListHeader" value="<%= itemValue  %>"/>
								<h5 class="text-left">${varRightListHeader }</h5>
								<%
							} else if(itemType.equalsIgnoreCase("section-start")){
								%><ul class="border-bottom"><%
							} else if(itemType.equalsIgnoreCase("cta")){
								Page ctaPage = pageManager.getPage(itemValue);
								itemValue = WCMUtil.getURL(itemValue, isAuthor);
								if(StringUtils.isNotEmpty(itemAnchor)) itemValue = itemValue + "#"+ itemAnchor + "," + ev5clickloc;
								else itemValue += "#"+ev5clickloc;
								if(StringUtils.isBlank(itemAltName)){
									itemAltName = WCMUtil.getNavTitle(ctaPage);
								}
								%>
								<c:set var="varRightListItemLabel" value="<%= itemAltName %>"/>
								<c:set var="varRightListItemVal" value="<%= itemValue  %>"/>
								<c:set var="varRightSideCtaTarget" value="<%= itemTarget  %>"/>
								<li> <a href="${varRightListItemVal }" ${varRightSideCtaTarget }>${varRightListItemLabel }</a></li>
								<%
							} else if(itemType.equalsIgnoreCase("section-end")){
								Page ctaPage = pageManager.getPage(itemValue);
								%></ul><%
							}
						}
                  	}
					%>
                </div>
              </div>
              <div class="row footer-links">
                <div class="col-lg-11 col-md-11 col-sm-11 col-lg-offset-1 col-md-offset-1 col-sm-offset-1">
                  <c:if test="${fn:length(varBtmrCtaPathsArr) > 0}">
                  <div class="row no-margin-row">
                  	<%
						for (int j = 0; j < btmrCtaPathsArr.length ; j++) {
							Page btmRightLinkPage = pageManager.getPage(btmrCtaPathsArr[j]);
							String btmPagePath = WCMUtil.getURL(btmRightLinkPage, isAuthor);
							if(StringUtils.isNotEmpty(btmPagePath)) btmPagePath+="#"+ev5clickloc;
                    %>
                      		<c:set var="varBtmRightLinkLabel" value="<%= WCMUtil.getNavTitle(btmRightLinkPage)  %>"/>
	                        <div class="col-lg-4 col-md-4 col-sm-4 no-padding-col"><a href="<%=btmPagePath%>">${ varBtmRightLinkLabel}</a></div>
	                        
	                <% } %>
                  </div>
                  </c:if>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>