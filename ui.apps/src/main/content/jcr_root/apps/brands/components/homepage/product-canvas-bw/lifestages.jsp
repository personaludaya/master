<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.day.cq.tagging.Tag,
				  com.day.cq.tagging.TagManager" %>
<% 
String lsHeaderText = properties.get("lifestages-header", "");
String lsProductPath = WCMUtil.getURL(properties.get("prdt-path", ""), isAuthor);
List<Map<String, String>> lsTags = WCMUtil.getMultiFieldPanelValues(resource, "lifestages");
TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
%>
<c:set var="varLsHeaderText" value="<%= lsHeaderText  %>"/>
<c:set var="varLsProductPath" value="<%= lsProductPath  %>"/>
<c:set var="varLsSvgIconPath" value="<%= svgIconPath  %>"/>

<cq:include script="lifestages-mobile.jsp"/>

<div class="leftNavBar hidden-xs">
  <h5 class="secondary-color text-left">${varLsHeaderText}</h5>
  <ul>
  	<%
  	if (lsTags != null) {
  		for (Map<String,String> lsTag : lsTags) {
  			if (lsTag != null) {
  				String lsTagStr = lsTag.get("tag");
  				
  				if (lsTagStr.indexOf("[") > -1 && lsTagStr.indexOf("]") > -1) { 
  					lsTagStr = lsTagStr.replace("[","").replace("]","").replace("\"","");
  					Tag tag = tagManager.resolve(lsTagStr);
  					if (tag != null) {
  	                    String tagTitle = tag.getLocalizedTitle(site_locale);
  	                    String tagName = tag.getName();
  	                  	String tagIcon = WCMUtil.getProductStageIcon(tagName);
  	                    String prdtAnchorPath = (!tagName.isEmpty()) ? lsProductPath + "#profile=" + tagName : lsProductPath;
  	                    %>
  	                    <c:set var="varLsTagIcon" value="<%= tagIcon  %>"/>
  	                    <c:set var="varLsTagTitle" value="<%= tagTitle  %>"/>
  	                    <c:set var="varLsPrdtAnchorPath" value="<%= prdtAnchorPath  %>"/>
  	                    
  	                    <li><a href="${varLsPrdtAnchorPath}">
					        <svg class="brands-icon pull-left link-icon-small icon-white">
					          <use href="${varLsSvgIconPath}#${varLsTagIcon}" xlink:href="${varLsSvgIconPath}#${varLsTagIcon}"></use>
					        </svg>${varLsTagTitle}</a></li>
  	                    <%
  					}
  				}
  			}
  		}
  	}
  	%>
  </ul>
</div>              