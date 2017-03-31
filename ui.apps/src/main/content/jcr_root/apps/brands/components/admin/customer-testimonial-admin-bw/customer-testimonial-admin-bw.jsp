<%@include file="/apps/brands/global/global.jsp" %>
<cq:text property="text" escapeXml="true"
        placeholder="<%= Placeholder.getDefaultPlaceholder(slingRequest, component, null)%>"/>

<c:set var="customerName" value="<%= properties.get("customer-name_t",null)  %>"/>
<c:set var="customerAge" value="<%= properties.get("customer-age",null)  %>"/>
<c:set var="customerSaluation" value="<%= properties.get("customer-saluation_t",null)  %>"/>
<c:set var="customerImgPath" value="<%= properties.get("customer-img-path",null)  %>"/>
<c:set var="imgAlt" value="<%= properties.get("customer-img-alt_t",null)  %>"/>
<c:set var="review" value="<%= properties.get("customer-review_t",null)  %>"/>

Customer Name: <c:out value="${customerName}"/>
<br/>
Customer Age: <c:out value="${customerAge}"/>
<br/>
Customer Saluation: <c:out value="${customerSaluation}"/>
<br/>
Image Alt Text: <c:out value="${imgAlt}"/>
<br/>
Review: <c:out value="${review}"/>
<br/>

<c:if test="${customerImgPath != null}">
    <img src="<c:out value="${customerImgPath}"/>" alt="<c:out value="${imgAlt != null ? imgAlt : customerName}"/>" data-rjs="2">
</c:if>