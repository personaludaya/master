<%@include file="/apps/brands/global/global.jsp"%><%
%><%
String freeHtml = properties.get("free-html", "");
boolean hideInMobile = properties.get("hide-in-mobile", "").equals("true");

if (!isAuthor){
	freeHtml = freeHtml.replace("/content/brands/", "/");
}
%>

<c:set var="varFreeHtml" value="<%= freeHtml %>"/>
<c:set var="varHideInMobile" value="<%= hideInMobile %>"/>

<c:choose>
  <c:when test="${varFreeHtml != null}">
    <%= freeHtml %>
  </c:when>
  <c:otherwise>
    <img src="/libs/cq/ui/resources/0.gif" class="cq-text-placeholder" alt="" data-rjs="2">
  </c:otherwise>
</c:choose>

<c:if test="${varHideInMobile}">
<script type="text/javascript">
$(function() {
  $('div.free-html-bw').addClass("hidden-xs");
});
</script>
</c:if>