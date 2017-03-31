<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.sling.commons.json.*,
            org.apache.sling.commons.json.io.JSONWriter" %>

<%@page contentType="application/json;charset=utf-8" %>
<%

JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();

String pathToInstagram = properties.get("path-to-instagram", null);
String hashtag = properties.get("hashtag", null);
String hashtagCopy = properties.get("hashtag-copy_t", null);
String timing = properties.get("timing", null);

writer.key("title");
writer.value(hashtag);
writer.key("description");
writer.value(hashtagCopy);
writer.key("interval");
writer.value(timing);

writer.key("instaFeeds").array();

Page pathToInstagramRootPage = pageManager.getPage(pathToInstagram);
Iterator<Page> iterInstagramPages = pathToInstagramRootPage.listChildren(new PageFilter(request));
               
 while (iterInstagramPages.hasNext()) {
	 Page instagramPage = iterInstagramPages.next();
	 Node instagramNode = WCMUtil.getNodePropertyValueByPage(instagramPage, "instagram_admin_bw") != null ? WCMUtil.getNodePropertyValueByPage(instagramPage, "instagram_admin_bw") : currentNode;
	 String instagramImg = WCMUtil.getNodePropertyValue(instagramNode, "instagram-img");
	 String instagramUrl = WCMUtil.getNodePropertyValue(instagramNode, "instagram-url");
	 writer.object();
	 writer.key("image").value(instagramImg);
	 writer.key("url").value("https://api.instagram.com/oembed?url=" +instagramUrl);
	 writer.endObject();
 }
 writer.endArray();
 writer.endObject();
 
%>
