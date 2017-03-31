<%@include file="/apps/brands/global/global.jsp"%>
<%
String contactInfoConfigPath = pageProperties.getInherited("contactConfigPath", "");
Resource contactInfoRes = resourceResolver.resolve(contactInfoConfigPath + "/jcr:content/par/contactinfo_admin_bw");
Node contactInfoNode = null;
Resource customerCareRes = null;
if(contactInfoRes != null){
	contactInfoNode = contactInfoRes.adaptTo(Node.class);
	customerCareRes = contactInfoRes.getChild("customer-care");
}
%>
<c:set var="varOfficeAddressLabel" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddressLabel_t") %>"/>
<c:set var="varOfficeAddress" value="<%= WCMUtil.getNodePropertyValue(contactInfoNode, "officeAddress") %>"/>

<div class="section-container contact-footer-container">
	<div
		class="background-container primary-background-color border-secondary-color">
		<div class="container-fluid">
			<div class="row">
				<%
				if(customerCareRes != null){
					//possible to render multiple customer care sections by adding while loop
					Iterator<Resource> customerCareIt = customerCareRes.listChildren();
					while(customerCareIt.hasNext()){
						Resource customerCareItemRes = customerCareIt.next();
						Node customerCareItemNode = customerCareItemRes.adaptTo(Node.class);
						String ccLabel = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-label_t");
						String ccLine = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-line");
						String ccNote = WCMUtil.getNodePropertyValue(customerCareItemNode, "customer-care-note_t");

						%>
						<c:set var="varCcLabel" value="<%= ccLabel %>"/>
						<c:set var="varCcLine" value="<%= ccLine %>"/>
						<c:set var="varCcNote" value="<%= ccNote %>"/>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
							<c:if test="${not empty varCcLine || varCCLabel}">
	                          	<svg class="brands-icon icon-center">
		                  			<use
										href="<%=imgPath%>/icons/symbol-defs.svg#icon-call"
										xlink:href="/clientlib-site/images/icons/symbol-defs.svg#icon-call"></use>
	                			</svg>
	                        </c:if>
	                        <h4>${varCcLabel }</h4>
	                        <h4>${varCcLine}</h4>
	                        <c:if test="${not empty varCcLine}">
	                        	<p>${varCcNote}</p>
	                        </c:if>
                        </div>
						<% 
					}
				}
                %>
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                	<c:if test="${not empty varOfficeAddressLabel }">
                  		<svg class="brands-icon icon-center">
                		<use
							href="<%=imgPath%>/icons/symbol-defs.svg#icon-building"
							xlink:href="/clientlib-site/images/icons/symbol-defs.svg#icon-building"></use>
                		</svg>
                    </c:if>
                   	<h4>${varOfficeAddressLabel }</h4>
                   	<p class="office-address">${varOfficeAddress }</p>
				</div>
			</div>
		</div>
	</div>
</div>
