<%@include file="/apps/brands/global/global.jsp" %>

<%
  String imageBwImgPath = properties.get("img-path", null);
  String imgAlt = properties.get("img-alt_t", null);
  imgAlt = imgAlt == null ? currentPage.getPageTitle() : imgAlt;
  String imgCaption = properties.get("img-caption_t", null);
  String imgStyle = properties.get("img-style", null);
%>
<c:set var="varImageBwImgPath" value="<%= imageBwImgPath %>"/>
<c:set var="varImgAlt" value="<%= imgAlt %>"/>
<c:set var="varImgCaption" value="<%= imgCaption %>"/>
<c:set var="varImgStyle" value="<%= imgStyle %>"/>

<c:if test="${varImageBwImgPath != null}">
	<img class="img-responsive <c:out value="${varImgStyle}"/>" src="<c:out value="${varImageBwImgPath}"/>" alt="<c:out value="${varImgAlt}"/>" title="<c:out value="${varImgAlt}"/>" data-rjs="2">
</c:if>
