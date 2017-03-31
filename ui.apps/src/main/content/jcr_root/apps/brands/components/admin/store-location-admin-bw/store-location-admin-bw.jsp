<%@include file="/apps/brands/global/global.jsp" %>
<cq:text property="text" escapeXml="true"
        placeholder="<%= Placeholder.getDefaultPlaceholder(slingRequest, component, null)%>"/>

<c:set var="title" value="<%= properties.get("title_t",null)  %>"/>
<c:set var="imgPath" value="<%= properties.get("img-path",null)  %>"/>
<c:set var="imgAlt" value="<%= properties.get("img-alt_t",null)  %>"/>
<c:set var="ctaPath" value="<%= properties.get("cta-path",null)  %>"/>
<c:set var="ctaLabel" value="<%= properties.get("cta-label_t",null)  %>"/>
<c:set var="ctaOpenNewWin" value="<%= properties.get("cta-open-new-win",null)  %>"/>


Title: <c:out value="${title}"/>
<br/>
Image Alt Text: <c:out value="${imgAlt}"/>
<br/>
CTA Path: <c:out value="${ctaPath}"/>
<br/>
CTA Label: <c:out value="${ctaLabel}"/>
<br/>
CTA Open in new window: <c:out value="${ctaOpenNewWin}"/>
<br/>
<c:if test="${imgPath != null}">
	<img src="<c:out value="${imgPath}"/>" alt="<c:out value="${imgAlt != null ? imgAlt : title}"/>" data-rjs="2">
</c:if>