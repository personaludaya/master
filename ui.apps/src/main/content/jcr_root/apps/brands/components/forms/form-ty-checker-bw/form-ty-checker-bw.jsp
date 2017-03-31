<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.analytics.DataLayerController,
                com.brands.core.analytics.FormController,
                com.brands.core.analytics.models.UserProfileModel,
                javax.servlet.http.HttpSession,
                org.apache.commons.lang3.StringUtils" %>
 <%--
 This component needs to exist on a Thank You page with a Form Page as a parent in order for analytics to work properly
  --%>

 <%
 //get the transactionId from cookie
Cookie bwtidCookie = slingRequest.getCookie("bwtid");


String varFormInfoFormName = "";
String varFormTransactionID = "";
String varFormHasEvent = "";
String varFormEventType = "";

//Customer Profile
String customerAge = "";
String customerType = "";
String customerCountry = "";
String customerGender = "";
//HttpSession uniqueSession = null;
 //if has transactionID, session is valid, trigger analytics event
 if(bwtidCookie != null){
	varFormTransactionID = bwtidCookie.getValue();
	//assuming this component will only be on thank you page, fire form success event
	try{
		FormController ctrl = new FormController(currentPage, resourceResolver);
		ctrl.setTransactionId(varFormTransactionID);
		UserProfileModel userProfile = ctrl.getUserProfileData();
		if(StringUtils.isNotBlank(userProfile.getCustomerAge())) customerAge = userProfile.getCustomerAge();
		if(StringUtils.isNotBlank(userProfile.getCustomerType())) customerType = userProfile.getCustomerType();
		if(StringUtils.isNotBlank(userProfile.getCustomerGender())) customerGender = userProfile.getCustomerGender();
		if(StringUtils.isNotBlank(userProfile.getCustomerCountryCode())) customerCountry = userProfile.getCustomerCountryCode();
		
		//parent page is the form page
		String formPagePath = currentPage.getParent().getPath();
		if(StringUtils.isNotBlank(formPagePath)){
			varFormInfoFormName = ctrl.getAnalyticsFormNameFromPath(formPagePath);
		}
	} catch(Exception e){log.error("Something went wrong getting form info name: " + e.getStackTrace());}
	
	//identifying thank you page
	varFormHasEvent = "true";
	varFormEventType = "form_submit";
	bwtidCookie.setMaxAge(0);
	response.addCookie(bwtidCookie);

} else {
	 //if no transactionId, dont fire analytics, do nth
}
%>
 
<c:set var="varFormInfoFormName" value="<%=varFormInfoFormName %>"/>
<c:set var="varFormHasEvent" value="<%= varFormHasEvent %>"/>
<c:set var="varFormEventType" value="<%= varFormEventType %>"/>
<c:set var="varFormTransactionID" value="<%= varFormTransactionID %>"/>

<c:set var="varCustProfileType" value="<%= customerType %>"/>
<c:set var="varCustProfileAge" value="<%= customerAge %>"/>
<c:set var="varCustProfileGender" value="<%= customerGender %>"/>
<c:set var="varCustProfileCountry" value="<%= customerCountry %>"/>

<c:if test="${not empty varFormInfoFormName}">
<div data-analytics-extend='{"form":{"formInfo":{"formName":"${varFormInfoFormName}"}}}'></div>
</c:if>
<c:if test="${not empty varFormTransactionID}">
<div data-analytics-extend='{"form":{"formInfo":{"transactionID":"${varFormTransactionID}"}}}'></div>
</c:if>

<c:if test="${not empty varCustProfileAge}">
<div data-analytics-extend='{"user":{"profile":{"age":"${varCustProfileAge}"}}}'></div>
</c:if>
<c:if test="${not empty varCustProfileType}">
<div data-analytics-extend='{"user":{"profile":{"customerType":"${varCustProfileType}"}}}'></div>
</c:if>
<c:if test="${not empty varCustProfileGender}">
<div data-analytics-extend='{"user":{"profile":{"gender":"${varCustProfileGender}"}}}'></div>
</c:if>
<c:if test="${not empty varCustProfileCountry}">
<div data-analytics-extend='{"user":{"profile":{"country":"${varCustProfileCountry}"}}}'></div>
</c:if>
<c:if test="${not empty varFormHasEvent}">
<div data-analytics-extend='{"event":{"eventInfo":{"eventName":"${varFormInfoFormName}","eventType":"${varFormEventType}"}}}'></div>
</c:if>

