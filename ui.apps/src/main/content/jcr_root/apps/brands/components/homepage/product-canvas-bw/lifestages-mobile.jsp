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

<div class="liveStagesBar hidden-lg hidden-md hidden-sm">
  <p class="secondary-color">${varLsHeaderText}</p>
  <div class="swiper-container live-stages-bar">
    <div class="swiper-wrapper">
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
                            
                        <div class="swiper-slide"><a class="btn btn-default" href="${varLsPrdtAnchorPath}">
                          <svg class="brands-icon icon-white icon-no-resize">
                            <use href="${varLsSvgIconPath}#${varLsTagIcon}" xlink:href="${varLsSvgIconPath}#${varLsTagIcon}"></use>
                          </svg>
                          <div class="live-stage-text">${varLsTagTitle}</div></a></div>
                        <%
                    }
                }
            }
        }
    }
    %>
    
    </div>
    <div class="swiper-next-livestages">
      <div class="view-all-wrapper"><a class="view-all">
          <svg class="brands-icon link-icon-small icon-white">
            <use href="${varLsSvgIconPath}#icon-arrow-right" xlink:href="${varLsSvgIconPath}#icon-arrow-right"></use>
          </svg></a></div>
    </div>
    <div class="swiper-prev-livestages">
      <div class="view-all-wrapper"><a class="view-all">
          <svg class="brands-icon link-icon-small icon-white">
            <use href="${varLsSvgIconPath}#icon-arrow-left" xlink:href="${varLsSvgIconPath}#icon-arrow-left"></use>
          </svg></a></div>
    </div>
  </div>
</div>