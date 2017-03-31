<%@include file="/apps/brands/global/global.jsp" %><%
%><%
int divId = (int)(Math.random()*1000);
String accordionLabel = properties.get("accordion-label_t", null);
%>

<c:set var="varDivId" value="<%= divId %>"/>
<c:set var="varAccordionLabel" value="<%= accordionLabel %>"/>

<div class="terms-and-conditions-wrapper">
  <div class="terms-and-conditions">
    <ul class="accordion-component" id="accordioncomponent-${varDivId}" data-accordion-id="accordioncomponent-${varDivId}">
      <li class="accordion-wrapper">
        <a class="collapsable">${varAccordionLabel}</a>
        <svg class="brands-icon link-icon-small icon-expand">
          <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-down" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-down"></use>
        </svg>
        <svg class="brands-icon link-icon-small icon-collapse hide">
          <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-up"></use>
        </svg>
        <div class="content">
          <cq:include path="content-accordion-par" resourceType="foundation/components/parsys"/>
        </div>
      </li>
    </ul>
  </div>
</div>

<% 
if (isAuthor) { %>
<div class="clear"></div>
<%
} %>

<cq:include path="content-accordion-end" resourceType="brands/components/content/content-accordion-bw/endbar" />