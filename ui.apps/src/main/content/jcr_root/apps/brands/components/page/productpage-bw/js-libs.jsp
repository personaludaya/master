<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.models.*,
                com.brands.core.controller.*" %>
                	
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
  SystemJS.import('product.js');
</script>

<%
//social-share-bar
boolean hideSocialShareBar = pageProperties.get("hide-socialshare-bar", "").equals("true");
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

<%
String prdtName = currentPage.getName();
String prdtCategory = "";
String prdtCategoryID = "";
String prdtStage = ""; 

ProductController productController = new ProductController();
Product product = new Product();
product = productController.getProuctPageProperties(currentPage, isAuthor, slingRequest);

String prdtID = product.getPrdId();
String prdtEcCatId = product.getPrdEcommerceCatId();

Map<String, String> prdtCategoryMapTags = product.getPrdCategoryMap();

String prdtCategoryTagName = "";
String prdtCatgoryTagID = "";
for (Map.Entry<String, String> entry : prdtCategoryMapTags.entrySet() ) {
        prdtCategoryTagName = entry.getValue();
        prdtCatgoryTagID = WCMUtil.getTagKeyByTags(entry.getKey());
}

Map<String, String> prdtLifeStageMapTags = product.getPrdLifeStageMap();
String prdLifeStageValue = "";
String prdtLifeStageKey = "";
for (Map.Entry<String, String> entry : prdtLifeStageMapTags.entrySet() ) {
        prdtLifeStageKey = prdtLifeStageKey + "|" + WCMUtil.getTagKeyByTags(entry.getKey()); 
        prdLifeStageValue = prdLifeStageValue + "|" + entry.getValue();
}

//set request attributes for analytics.jsp
request.setAttribute("varPrdtLifeStageKey", prdtLifeStageKey.substring(1));
request.setAttribute("varPrdtCatgoryTagID", prdtCatgoryTagID);
request.setAttribute("varPrdtEcCatID", prdtEcCatId);
request.setAttribute("varPrdtName", prdtName);
request.setAttribute("varPrdtID", prdtID);
%>
<c:set var="varPrdtName" value="<%= prdtName %>"/>
<c:set var="varPrdtID" value="<%= prdtID %>"/>
<c:set var="varPrdtEcCatID" value="<%= prdtEcCatId %>"/>
<c:set var="varPrdtCategoryTagName" value="<%= prdtCategoryTagName %>"/>
<c:set var="varPrdtCatgoryTagID" value="<%= prdtCatgoryTagID %>"/>
<c:set var="varPrdtStage" value="<%= prdtStage %>"/>
<c:set var="varPrdtLifeStageKey" value="<%= prdtLifeStageKey.substring(1) %>"/>
<c:set var="varPrdLifeStageValue" value="<%= prdLifeStageValue.substring(1) %>"/>

<%--
<script>
var prdtAnalytics = {
   product: {
     productInfo: {
        productName:'${varPrdtName}',
        productID:'${varPrdtID}'
     },
     category: {
        primaryCategory:'${varPrdtCatgoryTagID}',
        primaryCategoryID:'${varPrdtEcCatID}'
     },
     attributes: {
        stage:'${varPrdtLifeStageKey}'
     }
   }
 };

 SystemJS.import('analytics.js').then(function(){
     window['brands'].tracker.extendDataLayer(prdtAnalytics);
 });
</script>
--%>