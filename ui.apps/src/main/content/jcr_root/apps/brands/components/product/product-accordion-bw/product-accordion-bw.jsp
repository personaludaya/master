<%@include file="/apps/brands/global/global.jsp" %><%
%><%
int divId = (int)(Math.random()*1000);
%>

<c:set var="varDivId" value="<%= divId %>"/>

<div class="product-accordion" id="prdtaccordion-${varDivId}" data-accordion-id="prdtaccordion-${varDivId}">
  <div>
    <a class="collapsable">
      <cq:include path="header-title-bw" resourceType="brands/components/content/header-title-bw"/>
    </a>
    <svg class="brands-icon link-icon-small icon-expand hide hidden-lg hidden-md hidden-sm">
      <use href="<%=imgPath %>/icons/symbol-defs.svg#icon-arrow-down" xlink:href="<%=imgPath %>/icons/symbol-defs.svg#icon-arrow-down"></use>
    </svg>
    <svg class="brands-icon link-icon-small icon-collapse hidden-lg hidden-md hidden-sm">
      <use href="<%=imgPath %>/icons/symbol-defs.svg#icon-arrow-up" xlink:href="<%=imgPath %>/icons/symbol-defs.svg#icon-arrow-up"></use>
    </svg>
    <div class="content is-open">
      <cq:include path="product-accordion-par" resourceType="foundation/components/parsys"/>
    </div>
  </div>
</div>

<% 
if (isAuthor) { %>
<div class="clear"></div>
<%
} %>

<cq:include path="product-accordion-end" resourceType="brands/components/product/product-accordion-bw/endbar" />