<%@page session="false"%><%--
  Copyright 1997-2011 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Form 'element' component

  Draws an element of a form

--%>
<%@include file="/libs/foundation/global.jsp" %><%
%><%@ page import="com.day.cq.wcm.foundation.forms.FormsHelper,
                   com.day.cq.wcm.foundation.forms.LayoutHelper,
                   java.util.LinkedHashMap,
                   java.util.Map,
                   java.util.Locale,
				   java.util.ResourceBundle,
				   com.day.cq.i18n.I18n,
                   org.apache.commons.lang3.StringEscapeUtils,com.brands.core.utils.*" %><%
                   
	final Locale pageLocale = currentPage.getLanguage(true);
	final ResourceBundle resourceBundle = slingRequest.getResourceBundle(pageLocale);
	I18n i18n = new I18n(resourceBundle);  
					
    final String name = FormsHelper.getParameterName(resource);
    final String id = FormsHelper.getFieldId(slingRequest, resource);
    final boolean required = FormsHelper.isRequired(resource);
    final boolean hideTitle = properties.get("hideTitle", false);
    final String title = FormsHelper.getTitle(resource, i18n.get("Selection"));

    final String value = FormsHelper.getValue(slingRequest, resource);

    Map<String, String> displayValues = FormsHelper.getOptions(slingRequest, resource);
    
    String yesLabel = I18nUtil.getLabel("yes", currentPage, slingRequest, null);
    String noLabel = I18nUtil.getLabel("no", currentPage, slingRequest, null);
    
    if (displayValues == null) {
        displayValues = new LinkedHashMap<String, String>();
        displayValues.put("yes", yesLabel);
        displayValues.put("no", noLabel);
    }

    String contactUsMsgLabel = I18nUtil.getLabel("contactusmessage", currentPage, slingRequest, null);
    
    String titleMsg = i18n.getVar(FormsHelper.getTitle(resource, contactUsMsgLabel));
    %>
    <c:set var="varContactUsMsgLabel" value="<%= contactUsMsgLabel %>"/>
    <c:set var="varYesLabel" value="<%= yesLabel %>"/>
    <c:set var="varNoLabel" value="<%= noLabel %>"/>
    <c:set var="varTitleMsg" value="<%= titleMsg %>"/>
    <c:set var="varHideTitle" value="<%= !hideTitle %>"/>
    
    <div class="form-group form-marketing-wrapper">
    
	    <c:if test="${varHideTitle}">
	    <p class="message">${varTitleMsg}</p>
	    </c:if>
    
    	<input id="marketingactivities" type="hidden" name="<c:out value="<%= name %>"/>">
    	<div class="row">
    		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
    			<div class="row no-margin-row">
                <%

                int i = 0;
    
                for (String v : displayValues.keySet()) {
                    String btnId = "btnno";
                    final String t = displayValues.get(v);
                    final String currentId = id + "-" + i;

                %>
    
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 no-padding-col">
    
                <%

                String checked = "";
                if (i == 0) {
                    checked = " active";
                    btnId = "btnyes";
                }
                
                %>
                
                        <button class="btn btn-form btn-block <%= checked %>" value="<c:out value="<%= v %>"/>" id="<%= btnId %>"><c:out value="<%= t %>" /></button>
                     
                    </div>
                <%

                    i++;
                }
                
                %>

                </div>
            </div>
        </div>
    </div>
