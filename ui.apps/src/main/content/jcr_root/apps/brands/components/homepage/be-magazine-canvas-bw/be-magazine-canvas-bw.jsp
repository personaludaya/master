<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,
        org.apache.commons.lang3.StringUtils,
        com.brands.core.models.*,
        com.brands.core.controller.*,
        java.util.ArrayList,
        java.util.List"
%>
<%
String bmHeader = properties.get("bm-canvas-header-text_t", "");
String bmHeaderSize = properties.get("bm-canvas-header-size", "h1");
String bmHeaderAlign = properties.get("bm-canvas-header-align", "text-left");
String bmHeaderStyle = properties.get("bm-canvas-header-style", "secondary-color");
String bmSubHeader = properties.get("bm-canvas-subhead-text_t", "");
String bmDescr = properties.get("bm-canvas-descr_t", "");
String bmCTAPath = properties.get("cta-path", "");
String bmCTATxt = properties.get("cta-text", "");
bmCTATxt = I18nUtil.getLabel(bmCTATxt, currentPage, slingRequest, null);
String bmCTAType = properties.get("cta-type", "");
String bmCTAStyle = properties.get("cta-style", "");
String bmCTAIcon = properties.get("cta-icon", "");
String bmCTAIconStyle = properties.get("cta-icon-style", "");
String bmCTAOpenNewWindow = properties.get("cta-open-new-win", "");

String[] bmPagePathsArr = properties.get("bm-canvas-signposts-path", String[].class);
String bmSignpostsShowCatStr = properties.get("bm-signposts-show-cat", "false");
String bmSignpostsTitleSize = properties.get("bm-signposts-title-size", "h4");
String bmSignpostsAlign = properties.get("bm-signposts-alignment", "text-left");
String bmSignpostsStyle = properties.get("bm-signposts-style", "secondary-color");

String targetBlankStr = "";
String beMagPage = "brands/components/page/bemagazinepage-bw";

if (StringUtils.equalsIgnoreCase("true", bmCTAOpenNewWindow)) {
    targetBlankStr = "target=\"_blank\"";
}

if (StringUtils.equalsIgnoreCase(bmCTAType, "link")) {
    bmCTAType = "btn-link";
}

if (StringUtils.isNotEmpty(bmCTAPath)) {
    bmCTAPath = WCMUtil.getURL(bmCTAPath, isAuthor);
}

List<BeMagazineArticleItem> articleItems = new ArrayList<BeMagazineArticleItem>();

if (bmPagePathsArr != null && bmPagePathsArr.length > 0) {
    for (String path : bmPagePathsArr) {
        Page articlePage = pageManager.getPage(path);

        if (StringUtils.equalsIgnoreCase(beMagPage, articlePage.getProperties().get("sling:resourceType", ""))) {
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
}
%>

<div data-js-loader='["be-magazine-container.js"]'></div>
<c:set var="showCatStr" value="<%=bmSignpostsShowCatStr%>" />

<!-- be-magazine-component start here-->
<div class="be-magazine-component" data-swiper-parallax="-500%" style="transform: translate3d(0px, 0%, 0px); transition-duration: 0ms;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="row">

                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-4 text-left">
                        <div class="be-magazine-category">
                            <<%=bmHeaderSize%> class="<%=bmHeaderAlign%> <%=bmHeaderStyle%>">
                                <%=bmHeader%>
                            </<%=bmHeaderSize%>>
                            <p><%=bmSubHeader%></p>
                            <p><%=bmDescr%></p>

                            <div class="view-all-wrapper">
                                <a href="<%=bmCTAPath%>" class="view-all <%=bmCTAType%> <%=bmCTAStyle%>" <%=targetBlankStr%>>
                                <%=bmCTATxt%>
                                    <svg class="brands-icon <%=bmCTAIconStyle%>">
                                        <use href="<%=svgIconPath%>#<%=bmCTAIcon%>" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#<%=bmCTAIcon%>"></use>
                                    </svg>
                                </a>
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                        <div class="js-be-magazine-articles swiper-container swiper-container-horizontal">
                            <div class="swiper-wrapper">

                            <%
                                if (articleItems != null && articleItems.size() > 0) {
                                    for (BeMagazineArticleItem article : articleItems) {
                            %>
                                    <div class="swiper-slide swiper-slide-active">
                                        <div class="article <%=bmSignpostsAlign%> <%=bmSignpostsStyle%>">
                                            <img class="full-width" src="<%=article.getPageImgPath()%>" alt="<%=article.getPageImgAltTxt()%>" title="<%=article.getPageImgAltTxt()%>">
                                                <c:if test="${showCatStr == 'true'}">
                                                   <a class="btn btn-default">
                                                       <%=article.getCategory()%>
                                                   </a>
                                                </c:if>

                                            <a href="<%=article.getPageUrl()%>">
                                               <<%=bmSignpostsTitleSize%>>
                                                   <%=article.getPageTitle()%>
                                               </<%=bmSignpostsTitleSize%>>
                                            </a>

                                            <p><%=article.getPageOverview()%></p>
                                        </div>
                                    </div>

                            <%
                                    }
                                }
                            %>

                            </div>
                            
                            <div class="swiper-pagination hidden-lg hidden-md hidden-sm swiper-pagination-clickable swiper-pagination-bullets">
                                <span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>
                                <span class="swiper-pagination-bullet"></span>
                                <span class="swiper-pagination-bullet"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- be-magazine-component end here-->