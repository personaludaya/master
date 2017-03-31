<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,
					org.apache.commons.lang3.StringUtils,
					com.day.cq.tagging.Tag,
					com.day.cq.tagging.TagManager,
					java.util.*,
					com.day.cq.search.*,
                	com.day.cq.search.result.*,
                	com.brands.core.models.*,
                	com.brands.core.controller.*" %><%
%>

<%
String[] prdtLifeStageTags = properties.get("prdt-life-stage-tags", String[].class);
String prdtPath = properties.get("path-to-product", "");


TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
%>
<c:set var="varPrdtLifeStageTags" value="<%= prdtLifeStageTags  %>"/>
<c:set var="varPrdtPath" value="<%= prdtPath  %>"/>

<div data-js-loader='["our-product-toolbar-and-container.js"]'></div>

<c:if test="${fn:length(varPrdtLifeStageTags) > 0}">
	<cq:include script="product-toolbar.jsp"/>
</c:if>


<c:if test="${varPrdtPath != ''}">
	<script type="text/javascript" src="<%= resource.getPath() %>.productcategoryjs.html"></script>
	<div class="js-product-container-wrapper">           </div>
</c:if>


 <script type="text/javascript" src="<%= resource.getPath() %>.productfilterjs.html"></script> 


