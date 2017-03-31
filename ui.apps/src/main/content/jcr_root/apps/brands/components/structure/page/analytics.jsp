<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="java.util.Iterator,
                com.brands.core.analytics.DataLayerController,
                com.brands.core.analytics.FormController,
                com.brands.core.analytics.models.UserProfileModel,
                java.util.Set,java.util.HashSet,
                org.apache.commons.lang3.StringUtils" %><%
%><%
String currentPageTitle = "";
String currentPagePath = "";
String pageInfoContentDate = "";
String pageInfoContentTitle = "";
String pageInfoPriCategory = "";
String pageInfoSubCategory = "";
String pageName = "";
String pageInfoName = "";
String pageInfoSubSect1 = "";
String pageInfoSubSect2 = "";
String pageInfoSubSect3 = "";
String pageInfoSubSect4 = "";

//for page info start here
try {
    //analytics
    DataLayerController ctrl = new DataLayerController(currentPage, resourceResolver);
    pageInfoPriCategory = ctrl.getSiteSection();
    pageInfoSubCategory = ctrl.getContentCategory();
    pageInfoContentTitle = ctrl.getContentTitle();
    pageInfoContentDate = ctrl.getContentPostDate();
    if(StringUtils.isEmpty(pageInfoSubCategory)) pageInfoSubCategory = pageInfoContentTitle;
    pageName = ctrl.getPageInfoName();
    //System.out.println("==-=-=-=-=-=--SITE SECTION=-=-=-=-=-=-=-=- " + pageInfoPriCategory);
    //System.out.println("==-=-=-=-=-=--CONTENT CATEGORY=-=-=-=-=-=-=-=- " + pageInfoSubCategory);
    //System.out.println("==-=-=-=-=-=--CONTENT TITLE=-=-=-=-=-=-=-=- " + pageInfoContentTitle);
    //System.out.println("==-=-=-=-=-=--CONTENT POST DATE=-=-=-=-=-=-=-=- " + pageInfoContentDate);
} catch (Exception e) {
    System.err.println(e.getMessage());
}

currentPageTitle = currentPage.getPageTitle();
currentPagePath = currentPage.getPath();
pageInfoSubSect1 = pageInfoPriCategory;
pageInfoSubSect2 = pageInfoSubCategory;

if(request.getAttribute("varPageInfoName") != null) {;
    pageInfoName = request.getAttribute("varPageInfoName").toString();
} else if (StringUtils.isNotEmpty(pageInfoPriCategory)) {
    pageInfoName = pageName;
}
%>

<c:set var="varAnalyticsPageTitle" value="<%= currentPageTitle %>"/>
<c:set var="varAnalyticsLanguage" value="<%= site_language %>"/>
<c:set var="varAnalyticsCountry" value="<%= site_name %>"/>
<c:set var="varAnalyticsSite" value="<%= slingRequest.getServerName() %>"/>
<c:set var="varAnalyticsReferrer" value="<%= slingRequest.getHeader("Referer") %>"/>
<c:set var="varPageInfoName" value="<%= pageInfoName %>"/>
<c:set var="varAnalyticsContentDate" value="<%= pageInfoContentDate %>"/>
<c:set var="varAnalyticsContentTitle" value="<%= pageInfoContentTitle %>"/>
<c:set var="varAnalyticsPriCategory" value="<%= pageInfoPriCategory %>"/>
<c:set var="varAnalyticsSubCategory" value="<%= pageInfoSubCategory %>"/>
<c:set var="varAnalyticsSubSect1" value="<%= pageInfoSubSect1 %>"/>
<c:set var="varAnalyticsSubSect2" value="<%= pageInfoSubSect2 %>"/>
<c:set var="varAnalyticsSubSect3" value="<%= pageInfoSubSect3 %>"/>
<c:set var="varAnalyticsSubSect4" value="<%= pageInfoSubSect4 %>"/>

<%
//**code to be updated if pillar renamed and/or new pillar created.**
//for product pillar start here
String[] prdtPillars = {
		"products/look-and-feel-good", "products/cultivate-your-wellness", "products/fulfil-your-potential"};
boolean isPrdtPillar = false;
int pvIdx = 0;
String pillarValue = "";
if (StringUtils.indexOfAny(currentPagePath, prdtPillars) > 0) {
	isPrdtPillar = true;
	pvIdx = StringUtils.indexOfAny(currentPagePath, prdtPillars) + 9;
	pillarValue = currentPagePath.substring(pvIdx);
}
%>
<c:set var="varIsPrdtPillar" value="<%= isPrdtPillar %>"/>
<c:set var="varPillarValue" value="<%= pillarValue %>"/>
<c:if test="${varIsPrdtPillar}">
<%-- <div data-analytics-extend='{"product":{"attributes":{"pillar":"${varPillarValue}"}}}'></div>
 --%><%-- 
<script type="text/javascript">
var prdtPillarAnalytics = {
  product: {
    attributes: {
      pillar:'${varPillarValue}'
    }
  }
};
SystemJS.import('analytics.js').then(function(){
  window['brands'].tracker.extendDataLayer(prdtPillarAnalytics);
});
</script>
--%>
</c:if>
<%
//for product pillar end here
%>

<%
//for site-search/chatbot start here
String varSearchPrimaryCategory = "";
String varSearchSubCategory = "";
String varSearchResultNo = "";
String varSearchQuery = "";
if (request.getAttribute("varSearchPrimaryCategory") != null) {
    varSearchPrimaryCategory = request.getAttribute("varSearchPrimaryCategory").toString();
}
if (request.getAttribute("varSearchSubCategory") != null) {
	varSearchSubCategory = request.getAttribute("varSearchSubCategory").toString();
}
if (request.getAttribute("varSearchResultNo") != null) {
    varSearchResultNo = request.getAttribute("varSearchResultNo").toString();
}
if (request.getAttribute("varSearchQuery") != null) {
    varSearchQuery = request.getAttribute("varSearchQuery").toString();
}
%>
<c:set var="varSearchPrimaryCategory" value="${varSearchPrimaryCategory}"/>
<c:set var="varSearchSubCategory" value="${varSearchSubCategory}"/>
<c:set var="varSearchResultNo" value="${varSearchResultNo}"/>
<c:set var="varSearchQuery" value="${varSearchQuery}"/>
<c:if test="${not empty varSearchPrimaryCategory}">
<%--
<div data-analytics-extend='{"search":{"searchInfo":{"term":"${varSearchQuery}", "results":"${varSearchResultNo}"}, "category":{"primaryCategory":"${varSearchPrimaryCategory}", "subCategory":"${varSearchSubCategory}"}, "attributes": {"source":"${varAnalyticsReferrer}"}}}'></div>
--%>
<script type="text/javascript">
var searchAnalytics = {
  search: {
    searchInfo: {
      term:'${varSearchQuery}',
      results:'${varSearchResultNo}'
    },
    category: {
      primaryCategory:'${varSearchPrimaryCategory}',
      subCategory:'${varSearchSubCategory}'
    },
    attributes: {
      source:'${varAnalyticsReferrer}'
    }
  }
};
SystemJS.import('analytics.js').then(function(){
  window['brands'].tracker.extendDataLayer(searchAnalytics);
});
</script>
</c:if>
<%
//for site-search/chatbot end here
%>

<%
// for form start here
String varFormInfoFormName = "";
String varFormHasEvent = ""; //to check if there is any event (i.e. success form submit/error form submit)
String varFormEventType = "";

if (request.getAttribute("varFormInfoFormName") != null) {
	varFormInfoFormName = request.getAttribute("varFormInfoFormName").toString();	
}
if (request.getAttribute("varFormHasEvent") != null) {
	varFormHasEvent = request.getAttribute("varFormHasEvent").toString();
	
	if (request.getAttribute("varFormEventType") != null) {
		varFormEventType = request.getAttribute("varFormEventType").toString();
	}
}
%>
<c:set var="varFormInfoFormName" value="<%=varFormInfoFormName %>"/>
<c:set var="varFormHasEvent" value="<%= varFormHasEvent %>"/>
<c:set var="varFormEventType" value="<%= varFormEventType %>"/>

<c:if test="${not empty varFormInfoFormName}">
<div data-analytics-extend='{"form":{"formInfo":{"formName":"${varFormInfoFormName}"}}}'></div>
</c:if>

<c:if test="${not empty varFormHasEvent}">
<script type="text/javascript">
   	$(document).ready(function(){
   		var formInfoFields = "";
   		var currentFormErrors = $('.form_error');
   		for(var i = 0; i < currentFormErrors.length; i++){
   			var errorElement = $(currentFormErrors).eq(i);
   			var errorElementName = $(errorElement).parent().siblings('input').attr('name');
   			if(!errorElementName) errorElementName = $(errorElement).parent().siblings().find("input").attr('name');
   			if(i > 0)formInfoFields += errorElementName + "|";
   		}
   		formInfoFields = formInfoFields.substring(0, formInfoFields.length-1);
   		if(currentFormErrors.length > 0){
	   		var formAnalytics = {
	   			  form: {
	   			    formInfo: {
	   			      formField:formInfoFields
	   			    }
	   			  }
	   			};
	   		
	   		
	   		SystemJS.import('analytics.js').then(function(){
	   		  window['brands'].tracker.extendDataLayer(formAnalytics);
	   		});
   		} 
   	});
</script>

</c:if>
<%--
<script type="text/javascript">
var formAnalytics = {
  form: {
    formInfo: {
      formName:'${varFormInfoFormName}'
    }
  }
};
SystemJS.import('analytics.js').then(function(){
  window['brands'].tracker.extendDataLayer(formAnalytics);
});
</script>
--%>
<%
//for form end here
%>

<%
// for error-404 start here
String varErrorPageURL = "";
if (request.getAttribute("varErrorPageURL") != null) {
    varErrorPageURL = request.getAttribute("varErrorPageURL").toString();
}
%>
<c:set var="varErrorPageURL" value="${varErrorPageURL}"/>
<c:if test="${not empty varErrorPageURL}">
<c:set var="varErrorURL" value="<%=slingRequest.getRequestURL().toString()%>"/>
<div data-analytics-extend='{"error": {"errorInfo": {"errorPageURL":"${varErrorURL}"}}}'></div>
<%--
<script type="text/javascript">
var error404Analytics = {
  error: {
    errorInfo: {
      errorPageURL:window.location.href
    }
  }
};
SystemJS.import('analytics.js').then(function(){
  window['brands'].tracker.extendDataLayer(error404Analytics);
});
</script>
--%>
</c:if>
<%
//for error-404 end here
%>

<%
//for products analytics
String prdtLifeStageKey = (String)request.getAttribute("varPrdtLifeStageKey");
String prdtCatgoryTagID = (String)request.getAttribute("varPrdtCatgoryTagID");
String prdtEcCatID = (String)request.getAttribute("varPrdtEcCatID");
String prdtName = (String)request.getAttribute("varPrdtName");
String prdtID = (String)request.getAttribute("varPrdtID");
boolean hasProducts = false;
if(StringUtils.isNotBlank(prdtName)) hasProducts = true;
//end products analytics		
%>
<c:set var="varHasProducts" value="<%= hasProducts %>"/>
<c:set var="varPrdtLifeStageKey" value="<%= prdtLifeStageKey %>"/>
<c:set var="varPrdtCatgoryTagID" value="<%= prdtCatgoryTagID %>"/>
<c:set var="varPrdtEcCatID" value="<%= prdtCatgoryTagID %>"/>
<c:set var="varPrdtName" value="<%= prdtName %>"/>
<c:set var="varPrdtID" value="<%= prdtID %>"/>

<%-- page analytics --%>
<script type="text/javascript">
  var brandsDataLayer = {
    page: { 
      pageInfo: {
        pageURL:window.location.href,
        referrer:"${varAnalyticsReferrer}",
        pageTitle:"${varAnalyticsPageTitle}",
        pageName:"${varPageInfoName}",
        primaryCategory:"${varAnalyticsPriCategory}",
        subCategory:"${varAnalyticsSubCategory}",
        contentTitle:"${varAnalyticsContentTitle}",
        contentDate:"${varAnalyticsContentDate}",
        subSection1:"${varAnalyticsSubSect1}",
        subSection2:"${varAnalyticsSubSect2}",
        subSection3:"${varAnalyticsSubSect3}",
        subSection4:"${varAnalyticsSubSect4}"
      }, 
      attributes: {
        channel:"brandsworld",
        site:"${varAnalyticsSite}",
        siteType: ($(window).prop('outerWidth') <= 767 ? "mobile" : "desktop"),
        language:"${varAnalyticsLanguage}",
        country:"${varAnalyticsCountry}"
      }
    }
  };
  var hasEvent = "${varFormHasEvent}";
  var eventObj = {};
  if(hasEvent){
	  eventObj = {
			eventInfo:{
				eventName:"${varFormInfoFormName}",
				eventType:"${varFormEventType}"
			}
		}
	  brandsDataLayer.event = eventObj; 
  }
  var hasProductPillar = "${varIsPrdtPillar}";
  if(hasProductPillar == "true"){
	  var pillarVal = "${varPillarValue}";
	  if(pillarVal.length > 0){
		  var productPillarObj = {
				  attributes:{
					  pillar:pillarVal
				  }
		  }
		  brandsDataLayer.product = productPillarObj; 
	  }
  }
  var hasProducts = "${varHasProducts}";
  if(hasProducts == "true"){
	  var productObj = {
			  attributes:{
				  stage:"${varPrdtLifeStageKey}"
			  },
			  category:{
				  primaryCategory:"${varPrdtCatgoryTagID}",
				  primaryCategoryID:"${varPrdtEcCatID}"
			  },
			  productInfo:{
				  productID:"${varPrdtID}",
				  productName:"${varPrdtName}"
			  }
	  }
	  brandsDataLayer.product = productObj;
  }
  _satellite.pageBottom();
</script>