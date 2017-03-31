<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.sling.commons.json.*,
            	org.apache.sling.commons.json.io.JSONWriter,
            	org.apache.sling.api.request.RequestPathInfo,
               	com.day.cq.search.*,
                com.day.cq.search.result.*,
               	com.day.cq.tagging.Tag,
				com.day.cq.tagging.TagManager" %>

<%@page contentType="application/json;charset=utf-8" %>
<%
JSONWriter writer = new JSONWriter(response.getWriter());
RequestPathInfo pathInfo = slingRequest.getRequestPathInfo();
String configPath = properties.get("faq-config-path", ""); 
String expandIconPath = properties.get("faq-expand-icon", ""); 
String collapseIconPath = properties.get("faq-collapse-icon", ""); 
String[] selectors =  null;
String tagPath = "/etc/tags";


if (pathInfo != null) {
	selectors =  pathInfo.getSelectors();
}

if (selectors != null && selectors.length-1 > 1) {
	for (int i = 1; i < selectors.length-1; i++) {
		tagPath += "/" + selectors[i];
	}
}

Resource tagResource = resourceResolver.getResource(tagPath);
Tag tag = (tagResource != null) ? tagResource.adaptTo(Tag.class) : null;
String tagTitle = (tag != null) ? tag.getLocalizedTitle(site_locale) : "";
String tagId = (tag != null) ? tag.getTagID() : "";

writer.object();
writer.key("faqs");
writer.object();
writer.key("expandIcon").value(svgIconPath + "#" + expandIconPath);
writer.key("collapseIcon").value(svgIconPath + "#" + collapseIconPath);

writer.key("header").value(tagTitle);
writer.key("faqList").array();

Map<String, String> searchMap = new HashMap<String, String> ();
searchMap.put("path", configPath);
searchMap.put("sling:resourceType", "brands/components/admin/faq-admin-bw");
searchMap.put("1_property", "faq-prdt-category");
searchMap.put("1_property.1_value", tagId);
searchMap.put("p.limit", "-1");
List<Hit> hits = QueryUtil.searchGetHits(resourceResolver, searchMap);
for (Hit hit : hits) {
	writer.object();
	
	Node hitNode = resourceResolver.getResource(hit.getPath()).adaptTo(Node.class);
	String qns = WCMUtil.getNodePropertyValue(hitNode, "faq-qns_t");
	String ans = WCMUtil.getNodePropertyValue(hitNode, "faq-ans_t");
	String[] bullets = WCMUtil.getNodePropertyValues(hitNode, "faq-ans-bullets_t");
	
	writer.key("title").value(qns);
	writer.key("content").value(ans);
	
	if (bullets != null && bullets.length > 0) {
		writer.key("bulletList").array();
		for (String bullet : bullets) {
			writer.value(bullet);
		}
		writer.endArray();
	}
	
	writer.endObject();
}


writer.endArray();
writer.endObject();
writer.endObject();

%>