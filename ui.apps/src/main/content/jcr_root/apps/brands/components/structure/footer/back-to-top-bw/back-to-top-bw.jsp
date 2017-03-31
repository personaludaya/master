<%@include file="/apps/brands/global/global.jsp" %>

<%
String backToTopLabel = pageProperties.getInherited("backToTopLabel_t", "");
%>
<c:set var="varBackToTopLabel" value="<%= backToTopLabel  %>"/>

<div class="js-go-top-parent-container">
  <div class="go-top-container">
    <div class="go-top-wrapper">
    	<c:if test="${not empty varBackToTopLabel}">
		    <div class="go-top"><a>
		          <svg class="brands-icon link-icon-small pull-center">
		            <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up"></use>
		          </svg>${varBackToTopLabel }</a></div>
		    </div>
	    </c:if>
  </div>
</div>