<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,
        com.brands.core.models.*,
        com.brands.core.controller.*,
        java.util.*,
        org.apache.commons.lang3.StringUtils,
        org.apache.sling.commons.json.JSONObject,
        org.apache.sling.commons.json.JSONArray,
        com.day.cq.wcm.foundation.Sitemap,
        com.day.cq.wcm.foundation.Sitemap.Link"
%>
<%
List<Node> sitemapConfigNodeList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "sitemap-section-config");
String openNewWinStr = properties.get("sitemap-open-new-window", "");
String sortItemsStr = properties.get("sitemap-sort-alpha", "");
String iconType = properties.get("sitemap-list-item-icon", "icon-chevron-right-primary");
String iconStyle = properties.get("sitemap-list-item-icon-style", "link-icon-small");
String targetBlankStr = "";
if (StringUtils.equalsIgnoreCase("true", openNewWinStr)) {
    targetBlankStr = "target=\"_blank\"";
}

List<JSONObject> sectionObjList = new ArrayList<JSONObject>();
for (Node configNode : sitemapConfigNodeList) {
    String configRootPath = WCMUtil.getNodePropertyValue(configNode, "sitemap-section-rootpath");
    String configHeaderTxt = WCMUtil.getNodePropertyValue(configNode, "sitemap-section-header_t");
    String configTemplateType = WCMUtil.getNodePropertyValue(configNode, "sitemap-template-type");
    String configChildOrder = WCMUtil.getNodePropertyValue(configNode, "sitemap-children-order");
    String configGrandchildOrder = WCMUtil.getNodePropertyValue(configNode, "sitemap-grandchildren-order");
    String configCatChildOrder = WCMUtil.getNodePropertyValue(configNode, "sitemap-categorized-order");

    String childOrder = StringUtils.isEmpty(configChildOrder) ? "2" : configChildOrder;
    String grandchildOrder = StringUtils.isEmpty(configGrandchildOrder) ? "3" : configGrandchildOrder;
    String catChildOrder = StringUtils.isEmpty(configCatChildOrder) ? "1" : configCatChildOrder;

    String pageResourceType = "";
    String categoryFieldName = "";
    boolean hasFilter = false; // to determine if Anchors are to be added to URL

    if (StringUtils.equalsIgnoreCase("product", configTemplateType)) {
        pageResourceType = "brands/components/page/productpage-bw";
        categoryFieldName = "prdt-category";
        hasFilter = true;
    }
    /* TODO when categories had been implemented for the following types, options need to be added to dialog too
    else if (StringUtils.equalsIgnoreCase("be-magazine", configTemplateType)) {
    } else if (StringUtils.equalsIgnoreCase("bundle", configTemplateType)) {
    }
    */

    try {
        if(StringUtils.isNotEmpty(configRootPath)) {
            Page rootPage = pageManager.getPage(configRootPath);
            boolean isRootHideItself = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(rootPage, "hide-in-sitemap-component"));
            boolean isRootHideChild = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(rootPage, "hide-subpage-in-sitemap-component"));
            Integer requiredDepth = 2;

            Sitemap stm = new Sitemap(rootPage);
            LinkedList<Sitemap.Link> stmLinkList = stm.getLinks();
            List<ArrayList<String>> sectionChildList = new ArrayList<ArrayList<String>>();
            List<ArrayList<String>> sectionGrandchildList = new ArrayList<ArrayList<String>>();
            List<ArrayList<String>> sectionCatList = new ArrayList<ArrayList<String>>();
            //stm.draw(out);

            // start looping sitemap links to separate them
            for (int i = 0; i < stmLinkList.size(); i++) {
                if (stmLinkList.get(i).getLevel() <= requiredDepth) {
                    // get current page info
                    Page currPage = pageManager.getPage(stmLinkList.get(i).getPath());
                    String pageTitle = currPage.getTitle();
                    String pagePath = currPage.getPath();
                    String pageUrl = WCMUtil.getURL(pagePath, isAuthor);
                    boolean currPageHasChild = currPage.listChildren(new PageFilter(), false).hasNext();
                    boolean isCurrPageHideChild = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(currPage, "hide-subpage-in-sitemap-component"));
                    boolean isCurrPageHideItself = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(currPage, "hide-in-sitemap-component"));
                    int pageRelativeDepth = stmLinkList.get(i).getLevel();

                    // get parent page info
                    Page currParentPage = currPage.getParent(); // necessary for non-immediate children
                    String parentTitle = currParentPage.getTitle();
                    String parentUrl = WCMUtil.getURL(currParentPage.getPath(), isAuthor);
                    boolean isParentHideItself = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(currParentPage, "hide-in-sitemap-component"));
                    boolean isParentHideChild = Boolean.parseBoolean(WCMUtil.getPagePropertyValue(currParentPage, "hide-subpage-in-sitemap-component"));

                    if(!isRootHideChild && !isCurrPageHideItself) {
                        // for pages to be categorized, e.g. Product Page
                        if (!isParentHideChild && StringUtils.equalsIgnoreCase(pageResourceType, currPage.getProperties().get("sling:resourceType", ""))) {
                            Locale locale = currPage.getLanguage(true);
                            Map<String, String> catMapTags = WCMUtil.getTagMapList(currPage, locale, categoryFieldName);
                            String catName = "";
                            String catId = "";

                            for(Map.Entry<String, String> entry: catMapTags.entrySet()) {
                                catName = entry.getValue();
                                catId = WCMUtil.getTagKeyByTags(entry.getKey());
                            }

                            String catUrl = hasFilter ? (WCMUtil.getURL(currParentPage.getPath(), isAuthor) + "#" + catId) : WCMUtil.getURL(currParentPage.getPath(), isAuthor);
                            sectionCatList.add(new ArrayList<String>(Arrays.asList(catName, catUrl, pageTitle, pageUrl)));
                        }
                        // for all other descendant pages
                        else if(!StringUtils.equalsIgnoreCase(configRootPath, pagePath)){
                            // for grandchildren and above
                            if (pageRelativeDepth > 1) {
                                if(!isParentHideChild && isParentHideItself) {
                                    sectionChildList.add(new ArrayList<String>(Arrays.asList(pageTitle, pageUrl)));
                                } else if (!isParentHideChild) {
                                    sectionGrandchildList.add(new ArrayList<String>(Arrays.asList(parentTitle, parentUrl, pageTitle, pageUrl)));
                                }
                            }
                            // for immediate children
                            else if ((currPageHasChild && isCurrPageHideChild) || !currPageHasChild) {
                                sectionChildList.add(new ArrayList<String>(Arrays.asList(pageTitle, pageUrl)));
                            }
                        }
                    } else if (!isRootHideChild && isCurrPageHideItself && pageRelativeDepth > 1) {
                        // for pages who only has a single child and single child needs to hide itself
                        boolean isContainItem = sectionChildList.contains(new ArrayList<String>(Arrays.asList(parentTitle, parentUrl)));
                        int childrenCt = 0;
                        Iterator<Page> currParentChildList = currParentPage.listChildren(new PageFilter(), false);
                        while (currParentChildList.hasNext()) {
                            Page currParentChildPg = currParentChildList.next();
                            childrenCt ++;

                            if (childrenCt > 1) {
                                break;
                            }
                        }

                        if(!isContainItem && (childrenCt > 0 && childrenCt < 2) && !isParentHideItself) {
                            sectionChildList.add(new ArrayList<String>(Arrays.asList(parentTitle, parentUrl)));
                        }
                    }
                }
            }
            // end looping sitemap links to separate them

            // start sorting
            if(StringUtils.equalsIgnoreCase("true", sortItemsStr)) {
                Collections.sort(sectionCatList, new Comparator<ArrayList<String>>() {
                    @Override
                    public int compare(ArrayList<String> o1, ArrayList<String> o2) {
                        return o1.get(0).compareTo(o2.get(0));
                    }
                });

                Collections.sort(sectionGrandchildList, new Comparator<ArrayList<String>>() {
                    @Override
                    public int compare(ArrayList<String> o1, ArrayList<String> o2) {
                        return o1.get(0).compareTo(o2.get(0));
                    }
                });

                Collections.sort(sectionChildList, new Comparator<ArrayList<String>>() {
                     @Override
                     public int compare(ArrayList<String> o1, ArrayList<String> o2) {
                         return o1.get(0).compareTo(o2.get(0));
                     }
                });
            }
            // end sorting

            // start creating JSON object
            JSONObject renderObj = new JSONObject();
            JSONArray childWOChildArr = new JSONArray();
            JSONArray grandchildArr = new JSONArray();
            JSONArray catChildArr = new JSONArray();

            String sectionHeader = rootPage.getTitle();
            String sectionUrl = WCMUtil.getURL(configRootPath, isAuthor);

            if (StringUtils.isNotEmpty(configHeaderTxt)) {
                sectionHeader = configHeaderTxt;
            }

            renderObj.put("headerTxt", sectionHeader);
            if(!isRootHideItself) {
                renderObj.put("headerUrl", sectionUrl);
            }

            for (List<String> catInfo : sectionCatList) {
                Object[] selfArr = catInfo.toArray();
                JSONObject catChildObj = new JSONObject();

                catChildObj.put("mainItemTxt", selfArr[0].toString());
                catChildObj.put("mainItemUrl", selfArr[1].toString());
                catChildObj.put("innerItemTxt", selfArr[2].toString());
                catChildObj.put("innerItemUrl", selfArr[3].toString());

                catChildArr.put(catChildObj);
            }

            for (List<String> gcInfo : sectionGrandchildList) {
                Object[] selfArr = gcInfo.toArray();
                JSONObject grandchildObj = new JSONObject();

                grandchildObj.put("mainItemTxt", selfArr[0].toString());
                grandchildObj.put("mainItemUrl", selfArr[1].toString());
                grandchildObj.put("innerItemTxt", selfArr[2].toString());
                grandchildObj.put("innerItemUrl", selfArr[3].toString());

                grandchildArr.put(grandchildObj);
            }

            for (List<String> childInfo : sectionChildList) {
                Object[] selfArr = childInfo.toArray();
                JSONObject childObj = new JSONObject();
                childObj.put("mainItemTxt", selfArr[0].toString());
                childObj.put("mainItemUrl", selfArr[1].toString());

                childWOChildArr.put(childObj);
            }

            renderObj.put(catChildOrder, catChildArr);
            renderObj.put(childOrder, childWOChildArr);
            renderObj.put(grandchildOrder, grandchildArr);
            sectionObjList.add(renderObj);
            // end creating JSON object
        }
	} catch (Exception e) {
        System.err.println(e);
    }
}
%>

<c:set var="varTargetBlankStr" value="<%= targetBlankStr %>" />
<c:set var="varIconType" value="<%= iconType %>" />
<c:set var="varIconStyle" value="<%= iconStyle %>" />

<div class="container-fluid">
	<div class="row">

	<%
        for (JSONObject sectionJSONObj : sectionObjList) {
            String sectionHeader = sectionJSONObj.getString("headerTxt");
            String sectionHeaderUrl = sectionJSONObj.getString("headerUrl");
    %>
        <c:set var="varHeaderTxt" value="<%= sectionHeader %>" />
        <c:set var="varHeaderUrl" value="<%= sectionHeaderUrl %>" />

		<!-- sitemap section start here -->
		<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">

			<a href="${varHeaderUrl}" ${varTargetBlankStr}>
                <h3>${varHeaderTxt}</h3>
			</a>

			<%
                for (int i = 1; i < 4; i++) {
                    JSONArray itemJSONArr = (JSONArray) sectionJSONObj.get(String.valueOf(i));
                    Integer len = itemJSONArr.length();
                    String prevMainItem = "";

                    for (int j = 0; j < len; j++) {
                        JSONObject itemJSONObj = itemJSONArr.getJSONObject(j);
                        String mainItemTxt = itemJSONObj.getString("mainItemTxt");
                        String mainItemUrl = itemJSONObj.getString("mainItemUrl");

                        boolean isSameMainItem = StringUtils.equals(prevMainItem, mainItemTxt);
                        boolean isFirstInnerItem = (j == 0);
                        boolean isLastInnerItem = (j == len);

                        String innerItemTxt = "";
                        String innerItemUrl = "";

                        if(itemJSONObj.has("innerItemTxt")) {
                            innerItemTxt = itemJSONObj.getString("innerItemTxt");
                            innerItemUrl = itemJSONObj.getString("innerItemUrl");
                        }
            %>

            <c:set var="varIsSameMainItem" value="<%= isSameMainItem %>" />
            <c:set var="varIsFirstInnerItem" value="<%= isFirstInnerItem %>" />
            <c:set var="varIsLastInnerItem" value="<%= isLastInnerItem %>" />
            <c:set var="varMainItemTxt" value="<%= mainItemTxt %>" />
            <c:set var="varMainItemUrl" value="<%= mainItemUrl %>" />
            <c:set var="varInnerItemTxt" value="<%= innerItemTxt %>" />
            <c:set var="varInnerItemUrl" value="<%= innerItemUrl %>" />

            <c:if test="${varIsSameMainItem eq 'false'}">
                <a href="${varMainItemUrl}" ${varTargetBlankStr}>
                    <h4>${varMainItemTxt}</h4>
                </a>
            </c:if>
            <c:if test="${not empty varInnerItemTxt}">
                <c:if test="${varIsFirstInnerItem eq 'true'}">
                    <ul>
                </c:if>
                        <li>
                            <svg class="brands-icon icon-no-resize ${varIconStyle}">
                                <use href="<%=svgIconPath%>#${varIconType}" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#${varIconType}"></use>
                            </svg>
                            <a href="${varInnerItemUrl}" ${varTargetBlankStr}>
                                ${varInnerItemTxt}
                            </a>
                        </li>
                <c:if test="${varIsLastInnerItem eq 'true'}">
                    </ul>
                </c:if>
            </c:if>
            <%
                        prevMainItem = mainItemTxt;
                    }
                }
			%>

		</div>
		<!-- sitemap section end here -->
	<%
        }
	%>

    </div>
</div>