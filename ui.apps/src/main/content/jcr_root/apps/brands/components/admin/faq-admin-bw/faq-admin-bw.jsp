<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*" %>

<%@ page import="org.apache.sling.commons.json.JSONObject" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.apache.sling.commons.json.JSONArray" %>



<%
String faqQns = properties.get("faq-qns_t", "");
String faqAns = properties.get("faq-ans_t", "");
Locale locale = new Locale("en");
String[] faqAnsBulletsArr = properties.get("faq-ans-bullets_t", String[].class);

String[] faqPrdtCategory = properties.get("faq-prdt-category", String[].class);
Map<String, String> faqPrdtCategoryMap = WCMUtil.getDialogTagMapList(currentPage, locale, faqPrdtCategory);

%>

<c:set var="varFaqQns" value="<%= faqQns %>"/>
<c:set var="varFaqAns" value="<%= faqAns %>"/>
<c:set var="varFaqAnsBulletsArr" value="<%= faqAnsBulletsArr  %>"/>

FAQ Category:

<%
   	for (Map.Entry<String, String> entry : faqPrdtCategoryMap.entrySet() ) {
   		String faqPrdtCategoryKey = entry.getKey();
   		String[] faqPrdtCategoryKeys = faqPrdtCategoryKey.split("/");
   		faqPrdtCategoryKey = faqPrdtCategoryKeys[faqPrdtCategoryKeys.length-1];
%>
<c:set var="varFaqPrdtCategoryKey" value="<%= faqPrdtCategoryKey %>"/>
<c:set var="varFaqPrdtCategoryValue" value="<%= entry.getValue() %>"/>
[${varFaqPrdtCategoryValue}]

<% } %>
<br/>
FAQ Question: <c:out value="${varFaqQns}"/>
<br/>
FAQ Answer: <c:out value="${varFaqAns}"/>
<br/>
FAQ Bullet:

<%
    try {
        Property property = null;

        if (currentNode.hasProperty("faq-ans-bullets_t")) {
            property = currentNode.getProperty("faq-ans-bullets_t");
        }

        if (property != null) {
            JSONObject obj = null;
            Value[] values = null;

            if (property.isMultiple()) {
                values = property.getValues();
            } else {
                values = new Value[1];
                values[0] = property.getValue();
            }

            for (Value val : values) {
                obj = new JSONObject(val.getString());
%>
<ul class="benefits-info-item">
    <li> <%= obj.get("text") %> </li>

<%
                JSONObject cs = null;

                if(obj.get("children") != null){
                    JSONArray desc = new JSONArray(String.valueOf(obj.get("children")));
%>
    <li style="list-style:none"><ul class="benefits-info-item">
<%
                    for(int r = 0; r < desc.length(); r++){
                        cs = new JSONObject(String.valueOf(desc.get(r)));

%>
            <li><%=cs.get("text")%></li>

  <%                      
                    }
   %>

    </ul></li></ul>
    <%
                }

            }
        } 

    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));
    }
%>