<%@include file="/apps/brands/global/global.jsp" %>
<%@page	import="com.brands.core.utils.*,
        org.apache.commons.lang3.StringUtils,
        com.brands.core.models.*,
        com.brands.core.controller.*,
        java.util.ArrayList,
        java.util.List"
%>
<%
String isGetChildNodesStr = properties.get("bm-signposts-use-parent", "false");
String[] configuredPathsArr = properties.get("bm-signposts-path", String[].class);
String contentGridRowLoad = properties.get("bm-signposts-row", "1");
String contentGridCol = properties.get("bm-signposts-column", "cols4");
String signpostsShowCatStr = properties.get("bm-signposts-show-cat", "false");
String loadLblTxt = properties.get("bm-load-more-label_t", "Load more");
loadLblTxt = I18nUtil.getLabel(loadLblTxt, currentPage, slingRequest, null);
String loadLblAlign = properties.get("bm-load-label-alignment", "text-center");
String loadLblStyle = properties.get("bm-load-label-style", "primary-color");
String signpostsTitleSize = properties.get("bm-signposts-title-size", "h4");
String signpostTitleAlign = properties.get("bm-signposts-title-alignment", "text-left");
String signpostsTitleStyle = properties.get("bm-signposts-title-style", "secondary-color");

String parentPagePath = "";
String beMagPage = "brands/components/page/bemagazinepage-bw";
String columnStyle = "col-lg-3 col-md-3 col-sm-6 col-xs-12";

if (StringUtils.equalsIgnoreCase(isGetChildNodesStr, "true")) {
    parentPagePath = currentPage.getPath();
}

if (StringUtils.equalsIgnoreCase(contentGridCol, "cols3")) {
    columnStyle="col-lg-4 col-md-4 col-sm-6 col-xs-12";
}

List<String> articlePathsArr = new ArrayList<String>();
List<BeMagazineArticleItem> articleItems = new ArrayList<BeMagazineArticleItem>();

if (StringUtils.isNotEmpty(parentPagePath)) {
    Page root = pageManager.getPage(parentPagePath);

    Integer requiredDepth = 1;
    Integer rootDepth = root.getDepth();

    Iterator<Page> children = root.listChildren(new PageFilter(), true);

    while (children.hasNext()) {
        Page child = children.next();
        Integer relativeDepth = child.getDepth() - rootDepth;
        if(relativeDepth <= requiredDepth) {
            for(int i = 0; i < relativeDepth; i++) {
                articlePathsArr.add(child.getPath());
            }
        }
    }
}

if (configuredPathsArr != null && configuredPathsArr.length > 0) {
    for (String configuredPath : configuredPathsArr) {
        if(StringUtils.isNotEmpty(configuredPath)) {
            articlePathsArr.add(configuredPath);
        }
    }
}

for (String path : articlePathsArr) {
    Page articlePage = pageManager.getPage(path);

    if(StringUtils.equalsIgnoreCase(beMagPage, articlePage.getProperties().get("sling:resourceType", ""))) {
        BasicController basicController = new BasicController();
        Basic basic = new Basic();
        basic = basicController.getBasicPageProperties(articlePage, isAuthor, slingRequest);
        Map<String, String> articlePageMapTags = basic.getBasicTagsKeywordsMap();

        GeneralController generalController = new GeneralController();
        General general = new General();
        general = generalController.getGeneralPageProperties(articlePage, isAuthor, slingRequest);

        String signpostPagePath = WCMUtil.getURL(articlePage.getPath(), isAuthor);

        BeMagazineArticleItem item = new BeMagazineArticleItem();
        item.setPageTitle(basic.getBasicPageTitle());
        item.setPageOverview(basic.getBasicOverview());
        item.setPageImgPath(general.getGenPageImgPath());
        String imgAltTxt = general.getGenPageImgAltText();

        if(StringUtils.isEmpty(imgAltTxt)) {
            imgAltTxt = basic.getBasicPageTitle();
        }

        item.setPageImgAltTxt(imgAltTxt);
        item.setPageUrl(signpostPagePath);

        for (Map.Entry<String, String> entry : articlePageMapTags.entrySet() ) {
            String articlePageTagVal = entry.getValue();
            item.setCategory(articlePageTagVal);
            break;
        }

        articleItems.add(item);
    }
}

Integer numOfRowsLoad = Integer.parseInt(contentGridRowLoad);
Double numOfCols = StringUtils.equalsIgnoreCase(contentGridCol, "cols3") ? 3.0 : 4.0;
Double totalResults = (double) articleItems.size();
Integer totalRow = (int) Math.ceil(totalResults / numOfCols);
String[][] htmlMatrix = new String[totalRow][numOfCols.intValue()];

%>

<div data-js-loader='["be-magazine-listing.js"]'></div>
<c:set var="showCatStr" value="<%=signpostsShowCatStr%>" />

<div class="section-container be-magazine-listing--listing-content" data-row-load-limit="<%=numOfRowsLoad%>" data-col-load-limit="<%=numOfCols.intValue()%>">
  <div class="container-fluid">
    <%
    int traverseCount = 0;
    if (articleItems != null && articleItems.size() > 0) {

        htmlMatrixLoop:
        for(int i = 0; i < htmlMatrix.length; i++) {
    %>
            <div class="row">

            <%
            for(int j = 0; j < htmlMatrix[i].length; j++) {
                String ctTitle = articleItems.get(traverseCount).getPageTitle();
                String ctDescr = articleItems.get(traverseCount).getPageOverview();
                String ctImgPath = articleItems.get(traverseCount).getPageImgPath();
                String ctImgAltTxt = articleItems.get(traverseCount).getPageImgAltTxt();
                String ctUrl = articleItems.get(traverseCount).getPageUrl();
                String ctCat = articleItems.get(traverseCount).getCategory();
            %>

                <div class="<%=columnStyle%>">
                    <div class="article">
                        <a href="<%=ctUrl%>"> <img class="full-width" src="<%=ctImgPath%>" alt="<%=ctImgAltTxt%>" title="<%=ctImgAltTxt%>"></a>

                        <c:if test="${showCatStr == 'true'}">
                           <a class="btn btn-default">
                               <%=ctCat%>
                           </a>
                        </c:if>

                       <a href="<%=ctUrl%>">
                           <<%=signpostsTitleSize%> class="<%=signpostsTitleStyle%> <%=signpostTitleAlign%>">
                               <%=ctTitle%>
                           </<%=signpostsTitleSize%>>
                       </a>

                       <p><%=ctDescr%></p>

                    </div>
                </div>

            <%
                traverseCount++;

                if(traverseCount == articleItems.size()) {
                     break htmlMatrixLoop;
                }
            }
            %>

            </div>
    <%
        }
    }
    %>
  </div>

  <div class="view-all-wrapper <%=loadLblAlign%>">
      <a class="view-all <%=loadLblStyle%>">
          <%=loadLblTxt%>
      </a>
  </div>

</div>