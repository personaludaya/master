<%@include file="/apps/brands/global/global.jsp" %><%
%>

<script>var baseUrl = '<%=jsPath%>';</script>
<%
if(isAuthor){
	%>
	<script src="<%=jsPath%>/vendors/system-polyfills.js" type="text/javascript"></script>
	<script src="<%=jsPath%>/vendors/system.js" type="text/javascript"></script>
	<script src="<%=jsPath%>/main.js" type="text/javascript"></script>
	<%
} else {
	%>
	<script src="<%=jsPath%>/vendors/system-polyfills.min.js" type="text/javascript"></script>
	<script src="<%=jsPath%>/vendors/system.min.js" type="text/javascript"></script>
	<script src="<%=jsPath%>/main.min.js" type="text/javascript"></script>
	<%
}
%>
<script>  
  SystemJS.import('js-loader.js');
  SystemJS.import('header.js');
  SystemJS.import('footer.js');
  SystemJS.import('ux.ui.fancy-animation.js');
  SystemJS.import('home.js');
  SystemJS.import('popular-products.js');
</script>

<%
//social-share-bar
boolean hideSocialShareBar = pageProperties.getInherited("hide-socialshare-bar", "").equals("true");
String addthisWidgetPubid = pageProperties.getInherited("addthis-widget-pubid", "");  //ra-586cbab3d7e73069
out.println("<!-- hideSocialShareBar == " + hideSocialShareBar + " -->");
%>
<c:set var="varHideSocialShareBar" value="<%= hideSocialShareBar %>"/>
<c:set var="vAddthisWidgetPubid" value="<%= addthisWidgetPubid %>"/>
<c:if test="${varHideSocialShareBar == 'false'}">
<script src="//s7.addthis.com/js/300/addthis_widget.js#pubid=${vAddthisWidgetPubid}"></script>
</c:if>

<script>
  SystemJS.import('jquery.cookie');
  SystemJS.import('svgxuse');
  SystemJS.import('lazyloadxt');
  SystemJS.import('jquery.scrollTo');
  SystemJS.import('skrollr');
  SystemJS.import('analytics.js');
  //- SystemJS.import('retinajs');
</script>