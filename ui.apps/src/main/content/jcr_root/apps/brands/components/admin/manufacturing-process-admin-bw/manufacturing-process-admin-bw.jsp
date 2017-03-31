<%@include file="/apps/brands/global/global.jsp" %>

<c:set var="processName" value="<%= properties.get("process-name_t",null)  %>"/>
<c:set var="processCopy" value="<%= properties.get("process-copy_t",null)  %>"/>
<c:set var="processImgPath" value="<%= properties.get("process-img-path",null)  %>"/>
<c:set var="processImgAlt" value="<%= properties.get("process-img-alt_t",null)  %>"/>


Process Name: <c:out value="${processName}"/>
<br/>
Process Copy: <c:out value="${processCopy}"/>
<br/>

<c:if test="${processImgPath != null}">
    <img src="<c:out value="${processImgPath}"/>" alt="<c:out value="${processImgAlt != null ? processImgAlt : processName}"/>" data-rjs="2">
</c:if>