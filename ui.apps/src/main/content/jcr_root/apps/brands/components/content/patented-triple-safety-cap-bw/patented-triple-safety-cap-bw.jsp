<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,com.brands.core.models.*,com.brands.core.controller.*"%>

<%
String title = properties.get("title_t", "");
String introCopy = properties.get("intro-copy_t", "");
List<Node> patentedContentList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "patented-content");
String recapCopy = properties.get("recap-copy_t", "");

String ctaStyle = properties.get("cta-style", "");
String ctaType = properties.get("cta-type", "");
String ctaIconStyle = properties.get("cta-icon-style","");
String ctaPath = properties.get("cta-path",null);
ctaPath = ctaPath == null ? "" : WCMUtil.getURL(ctaPath, isAuthor);
String ctaText = properties.get("cta-text",null);
ctaText = I18nUtil.getLabel(ctaText, currentPage, slingRequest, null);
String ctaIcon = properties.get("cta-icon",null);

%>
<c:set var="varTitle" value="<%= title  %>"/>
<c:set var="varIntroCopy" value="<%= introCopy  %>"/>
<c:set var="varRecapCopy" value="<%= recapCopy  %>"/>
<c:set var="varPatentedContentList" value="<%= patentedContentList  %>"/>


<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win", "").equals("true")  %>"/>
<c:if test="${ctaOpenNewWin == 'true'}">
	<c:set var="ctaOpenNewWinTarget" value="target=_blank"/>
</c:if>
<c:set var="varCtaStyle" value="<%= ctaStyle %>"/>
<c:set var="varCtaIconStyle" value="<%= ctaIconStyle %>"/>
<c:set var="varCtaType" value="<%= ctaType.toLowerCase() %>"/>
<c:set var="varCtaTypeClass" value=""/>
<c:set var="varCtaPath" value="<%= ctaPath %>"/>
<c:set var="varCtaText" value="<%= ctaText %>"/>
<c:set var="varCtaIcon" value="<%= ctaIcon %>"/>

<c:choose>
    <c:when test="${varCtaType == 'button' }">
       <c:set var="varCtaTypeClass" value="btn btn-action btn-lg"/>
    </c:when>
    <c:when test="${varCtaType == 'link'}">
       <c:set var="varCtaTypeClass" value="view-all"/>
    </c:when>
    <c:otherwise>
	   <c:set var="varCtaTypeClass" value=""/>
    </c:otherwise>
</c:choose>

<h2>${varTitle}</h2>
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<p class="info-content">${varIntroCopy}</p>
			
			<div class="row">
				<!-- Start patent looping -->
				<%
				 for (int i = 0; i < patentedContentList.size(); i++) {
					 Node patendedContentNode = patentedContentList.get(i);
		         	 String ptContentImgPath = WCMUtil.getNodePropertyValue(patendedContentNode, "img-path");
		         	 String ptImgAlt = WCMUtil.getNodePropertyValue(patendedContentNode, "img-alt_t");
		         	 ptImgAlt = ptImgAlt == "" ? currentPage.getPageTitle() : ptImgAlt;
		         	 String ptContentTitle = WCMUtil.getNodePropertyValue(patendedContentNode, "title_t");
		         	 String ptCopy = WCMUtil.getNodePropertyValue(patendedContentNode, "copy_t");
				%>
				
				<c:set var="varPtContentImgPath" value="<%= ptContentImgPath %>"/>
				<c:set var="varPtImgAlt" value="<%= ptImgAlt %>"/>
				<c:set var="varPtContentTitle" value="<%= ptContentTitle %>"/>
				<c:set var="varPtCopy" value="<%= ptCopy %>"/>
				
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
					<div class="patented-triple-safety-cap-item">
						<img class="img-responsive" src="${varPtContentImgPath}" alt="${varPtImgAlt}" title="${varPtImgAlt}" data-rjs="2"/>
						<div class="info-content">
	                      <h4> ${varPtContentTitle}</h4>
	                      <p>${varPtCopy}</p>
	                    </div>
					</div>
				</div>
				<% } %>
				<!-- End patent looping -->
					
			</div>
		</div>
		
		 <div class="row">
           <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
             <p class="info-content">${varRecapCopy}</p>
           </div>
         </div>
             
         <c:if test="${varCtaPath != null and varCtaPath !=''}">
            <div class="row">
	            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	              <div class="view-all-wrapper text-center"><a href="${varCtaPath}" ${ctaOpenNewWinTarget}  title="${varCtaText}" class="${varCtaTypeClass} ${varCtaStyle}">${varCtaText}</a></div>
	            </div>
          	</div>
         </c:if>
      
          
	</div>
</div>

<c:if test="${fn:length(varPatentedContentList) > 0}">
</c:if>