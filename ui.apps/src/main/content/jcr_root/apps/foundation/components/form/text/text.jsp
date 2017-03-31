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

--%><%@include file="/libs/foundation/global.jsp"%><%
%><%@ page import="com.day.cq.wcm.foundation.TextFormat,
                   com.day.cq.wcm.foundation.forms.FormsHelper,
                   com.day.cq.wcm.foundation.forms.LayoutHelper,
                   com.day.cq.wcm.foundation.forms.FormResourceEdit,
				   java.util.ResourceBundle,
				   com.day.cq.i18n.I18n" %><%

	final ResourceBundle resourceBundle = slingRequest.getResourceBundle(null);
	I18n i18n = new I18n(resourceBundle);  
					
    final String name = FormsHelper.getParameterName(resource);
    String textBoxName = xssAPI.encodeForHTMLAttr(name);
    final String id = FormsHelper.getFieldId(slingRequest, resource);
    final boolean required = FormsHelper.isRequired(resource);
    final boolean readOnly = FormsHelper.isReadOnly(slingRequest, resource);
    final boolean multiValued = properties.get("multivalue", false);
    final boolean hideTitle = properties.get("hideTitle", false);
    final String width = properties.get("width", String.class);
    final int rows = xssAPI.getValidInteger(properties.get("rows", String.class), 1);
    final int cols = xssAPI.getValidInteger(properties.get("cols", String.class), 35);
    String[] values = FormsHelper.getValues(slingRequest, resource);
    if (values == null) {
        values = new String[]{""};
    }

    String title = i18n.getVar(FormsHelper.getTitle(resource, "Text"));

    if (multiValued && !readOnly) {
        %><%@include file="multivalue.jsp"%><%
    }

    boolean multiRes = FormResourceEdit.isMultiResource(slingRequest);
    String mrName = name + FormResourceEdit.WRITE_SUFFIX;
    String mrChangeHandler = multiRes ? "cq5forms_multiResourceChange(event, '" + xssAPI.encodeForJSString(mrName) + "');" : "";
    String forceMrChangeHandler = multiRes ? "cq5forms_multiResourceChange(event, '" + xssAPI.encodeForJSString(mrName) + "', true);" : "";

    //addon - ismobile
    String inputType = "text";
    boolean isMobileField = properties.get("ismobilefield", "").equals("true");
    if (isMobileField) {
    	inputType = "tel";
    }
    %>
    
<c:set var="varTitle" value="<%= title %>"/>
<c:set var="varRows" value="<%= rows %>"/>
<c:set var="varTextBoxName" value="<%= textBoxName %>"/>
<c:set var="varInputType" value="<%= inputType %>"/>

<%
int i = 0;
for (String value : values) {
	String currentId = i == 0 ? id : id + "-" + i;
%>
 <div class="form-group floating-label-form-group">
   <label for="<%= xssAPI.encodeForHTMLAttr(name) %>">${varTitle}</label>
   <%
   if (rows == 1) {
   %>
   <input class="form-control" name="<%= xssAPI.encodeForHTMLAttr(name) %>" type="${varInputType}" autocomplete="off" placeholder="${varTitle}" id="<%= xssAPI.encodeForHTMLAttr(currentId) %>">
   <%} else { %>
   <textarea class="form-control" name="<%= xssAPI.encodeForHTMLAttr(name) %>" placeholder="${varTitle}" rows="${varRows}"></textarea>
   <%} %>
 </div>
<%
}
LayoutHelper.printErrors(slingRequest, name, hideTitle, out);
%>



    
    
    
    
    
    
    
    
    
  
