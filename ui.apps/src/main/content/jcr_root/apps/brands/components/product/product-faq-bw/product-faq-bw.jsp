<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils" %><%
%><%
String[] prdtFaqPathsArr = properties.get("prdt-faq-paths", String[].class);
%>

<c:set var="varPrdtPageTitle" value="<%= currentPage.getPageTitle() %>"/>
<c:set var="varPrdtFaqPathsArr" value="<%= prdtFaqPathsArr  %>"/>

<!-- product-faq start here-->
<div class="product-faq">
  <ul class="accordion-component" id="faq">
    <li class="accordion-wrapper">
      <h4 class="text-left">${varPrdtPageTitle}</h4>
    </li>
    
    <c:if test="${fn:length(varPrdtFaqPathsArr) > 0}">
    <%	for (String prdtFaqPath : prdtFaqPathsArr) {
			String faqPath = prdtFaqPath;
			Page faqPage = pageManager.getPage(faqPath);
			
			Node faqNode = WCMUtil.getNodePropertyValueByPage(faqPage, "faq_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(faqPage, "faq_admin_bw") : currentNode;
			String faqQns = WCMUtil.getNodePropertyValue(faqNode, "faq-qns_t");
			String faqAns = WCMUtil.getNodePropertyValue(faqNode, "faq-ans_t");
			String[] faqAnsBulletsArr = WCMUtil.getNodePropertyValues(faqNode, "faq-ans-bullets_t");
	%>
	<c:set var="varFaqQns" value="<%= faqQns %>"/>
	<c:set var="varFaqAns" value="<%= faqAns %>"/>
	<c:set var="varFaqAnsBulletsArr" value="<%= faqAnsBulletsArr %>"/>	
	
    <li class="accordion-wrapper"><a class="collapsable">${varFaqQns}</a>
      <svg class="brands-icon link-icon-small icon-expand">
        <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-down" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-down"></use>
      </svg>
      <svg class="brands-icon link-icon-small icon-collapse hide">
        <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up"></use>
      </svg>
      <div class="content product-faq-item">${varFaqAns}
        <c:if test="${fn:length(varFaqAnsBulletsArr) > 0}">
      	<article class='campaign-text bullet-list'>
      	  <ul>
      	  <%	for (String faqAnsBullet : faqAnsBulletsArr) {
      	  %>
      	  	<c:set var="varFaqBullet" value="<%= faqAnsBullet %>"/>
      	    <li>${varFaqBullet}</li>
      	  <%	}
		  %>
      	  </ul>
      	</article>
      	</c:if>
      </div>
    </li>
	<%	} 
	%>    
    </c:if>
    
  </ul>
  <div class="view-all-wrapper text-center"><a class="view-all" id="seemorefaq">see more</a></div>
</div>
<!-- product-faq end here-->