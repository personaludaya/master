<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="java.util.*,
                com.brands.core.utils.*"%>
                
<%
String manufacturingProcessPath = properties.get("manufacturing-process-path", null);
%>

<c:set var="varManufacturingProcessPath" value="<%= manufacturingProcessPath %>"/>

<c:if test="${varManufacturingProcessPath != null}">
	<%
		Page rootPage = pageManager.getPage(manufacturingProcessPath);
	%>
	<c:set var="varRootPage" value="<%= rootPage %>"/>
	 
	<c:if test="${varRootPage != null}">
		<%
			 Page manufacturingProcessAdminRootPage = pageManager.getPage(manufacturingProcessPath);
	         Iterator<Page> iterManufacturingProcessPages = manufacturingProcessAdminRootPage.listChildren(new PageFilter(request));
	          
	         int countPosition = 0;
	         while (iterManufacturingProcessPages.hasNext()) {
	        	 Page iterManufacturingProcessPage = iterManufacturingProcessPages.next();
	        	 Node manufacturingProcessNode = WCMUtil.getNodePropertyValueByPage(iterManufacturingProcessPage, "manufacturing_proces") != null ? WCMUtil.getNodePropertyValueByPage(iterManufacturingProcessPage, "manufacturing_proces") : currentNode;
	        	 String processName = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-name_t");
	        	 String processCopy = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-copy_t");
	        	 String processImgPath = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-img-path");
	        	 String processImgAlt = WCMUtil.getNodePropertyValue(manufacturingProcessNode, "process-img-alt_t");
	        	 processImgAlt = processImgAlt == "" ? processName : processImgAlt;
	        	 
	        	 countPosition++;
	        	 
	        	 
	        	 
	        	 if (countPosition % 2 != 0) {
		%>
		<!-- Start Looping -->
		<c:set var="varProcessName" value="<%= processName %>"/>
		<c:set var="varProcessCopy" value="<%=processCopy%>" />
		<c:set var="varProcessImgPath" value="<%=processImgPath%>" />
		<c:set var="varProcessImgAlt" value="<%=processImgAlt%>" />
		
		<div class="manufacturing--process">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 img-first-col">
						<img class="img-responsive img-first"
							src="${varProcessImgPath}"
							alt="${varProcessImgAlt}" title="${varProcessImgAlt}" data-rjs="2">
					</div>
					<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
						<!-- campaign-text molecule start here-->
						<article class="campaign-text">
							<h2 class="text-left">${varProcessName}</h2>
							<p>${varProcessCopy}</p>
						</article>
					</div>
				</div>
			</div>
		</div>
		
		<!-- End looping -->
		<%  } else {
			%>
		<c:set var="varProcessName" value="<%= processName %>"/>
		<c:set var="varProcessCopy" value="<%=processCopy%>" />
		<c:set var="varProcessImgPath" value="<%=processImgPath%>" />
		<c:set var="varProcessImgAlt" value="<%=processImgAlt%>" />
		
			<div class="manufacturing--process">
              <div class="container-fluid">
                <div class="row">
                  <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 hidden-lg hidden-md hidden-sm">
                  <img class="img-responsive" src="${varProcessImgPath}" alt="${varProcessImgAlt}" title="${varProcessImgAlt}"></div>
                  <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                          <!-- campaign-text molecule start here-->
                          <article class="campaign-text">
                                <h2 class="text-left">${varProcessName}</h2>
                            <p>${varProcessCopy}</p>
                          </article>
                  </div>
                  <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 img-last-col hidden-xs"><img class="img-responsive img-last" src="${varProcessImgPath}" alt="${varProcessImgAlt}" title="${varProcessImgAlt}"></div>
                </div>
              </div>
            </div>
			
			<%
			
		}
		
	        	 } %>
	</c:if>
</c:if>