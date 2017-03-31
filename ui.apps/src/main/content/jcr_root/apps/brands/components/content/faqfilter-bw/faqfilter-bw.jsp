<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.day.cq.tagging.Tag,
                  com.day.cq.tagging.TagManager,
                  java.util.Calendar,
                  java.text.SimpleDateFormat,
                  org.apache.sling.commons.json.JSONArray" %><%
%><%
List<Map<String, String>> categoryTags = WCMUtil.getMultiFieldPanelValues(resource, "faq-category-tags");
String[] selectedTags = properties.get("faq-default-selection", String[].class);

TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
JSONArray tagArray = new JSONArray();
List selectedTagsList = (selectedTags != null) ? Arrays.asList(selectedTags) : null;

for (Map<String, String> tag : categoryTags) {
    if (tag != null) {
        String tagStr = tag.get("tag");
        if (tagStr.indexOf("[") > -1 && tagStr.indexOf("]") > -1) { 
            tagStr = tagStr.replace("[","").replace("]","").replace("\"","");
            tagArray.put(tagStr);
        }
    }
}

String today = "";
try {
    SimpleDateFormat sdf2 = new SimpleDateFormat("ddMMyyyy");
    Calendar now = Calendar.getInstance();
    today = sdf2.format(now.getTime());
} catch (Exception e1) {
	System.err.println(e1.getMessage());
}
%>

<c:set var="varToday" value="<%= today %>"/>

<div data-js-loader='["faq.js"]'></div>
<ul class="faq-category-list">
<%
if (tagArray.length() > 0) {
    for (int i = 0 ; i < tagArray.length(); i++) {
        Tag tag = tagManager.resolve(tagArray.getString(i));
        String tagClass = (selectedTagsList !=null) ? ((selectedTagsList.contains(tagArray.getString(i)))? "btn-action" : "btn-default") : "btn-default";
        if (tag != null) {
            String tagTitle = tag.getLocalizedTitle(site_locale);
            String tagSelectors = tagArray.getString(i).replace(":",".").replace("/",".");
            %>
            <c:set var="varTagTitle" value="<%= tagTitle  %>"/>
            <c:set var="varTagSelectors" value="<%= tagSelectors  %>"/>
            <c:set var="varTagClass" value="<%= tagClass  %>"/>
            <c:set var="varCurrentNodePath" value="<%=currentNode.getPath()%>"/>
            <li><a class="btn ${varTagClass} btn-block-xs btn-lg" href="javascript:void(0);" data-url="${varCurrentNodePath}.faqfilter.${varTagSelectors}.${varToday}bw.json">${varTagTitle}</a></li>
            <%
        }
    }
}
%>
</ul>