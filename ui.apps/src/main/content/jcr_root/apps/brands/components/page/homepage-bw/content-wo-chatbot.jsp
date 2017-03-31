<%@include file="/apps/brands/global/global.jsp" %><%
%><%@ page import="com.day.cq.wcm.api.components.IncludeOptions" %><%

String beMagBkgrdImg = pageProperties.get("bemag-bkgrd-img-path", imgPath + "/template/home-screen4-bg.jpg");
String beMagBkgrdStyle = pageProperties.get("bemag-bkgrd-style", "background-cover-image");
String instaWallBkgrdImg = pageProperties.get("instagramwall-bkgrd-img-path", imgPath + "/template/home-screen5-bg.jpg");
String instaWallBkgrdStyle = pageProperties.get("instagramwall-bkgrd-style", "background-cover-image");
%>
<c:set var="varBeMagBkgrdImg" value="<%= beMagBkgrdImg %>" />
<c:set var="varBeMagBkgrdStyle" value="<%= beMagBkgrdStyle %>" />
<c:set var="varInstaWallBkgrdImg" value="<%= instaWallBkgrdImg %>" />
<c:set var="varInstaWallBkgrdStyle" value="<%= instaWallBkgrdStyle %>" />

<div class="swiper-container home-screen">
    <div class="swiper-wrapper" data-name="homepage">

        <div class="swiper-slide home-screens-slide" data-title="campaign-canvas">
            <div class="section-container home--screen3">
                <div class="campaign-component">
                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions campaignCarouselCanvasBwOpts = IncludeOptions.getOptions(request, true);
                    campaignCarouselCanvasBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="campaign-carousel-canvas-bw" resourceType="brands/components/homepage/campaign-carousel-canvas-bw"/>
                </div>
            </div>
        </div>

        <div class="swiper-slide home-screens-slide" data-title="popular-products-canvas">
            <div class="section-container home--screen2">
                <div class="popular-products-component">
                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions productCanvasBwOpts = IncludeOptions.getOptions(request, true);
                    productCanvasBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="product-canvas-bw" resourceType="brands/components/homepage/product-canvas-bw"/>
                </div>
            </div>
        </div>

        <div class="swiper-slide home-screens-slide" data-title="bemagazine-canvas">
            <div class="section-container home--screen4" data-swiper-parallax="-100%">
                <div class="background-container ${varBeMagBkgrdStyle}" style="background-image: url(${varBeMagBkgrdImg});" data-rjs="2" data-rjs-processed="true">
                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions beMagazineCanvasBwOpts = IncludeOptions.getOptions(request, true);
                    beMagazineCanvasBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="be-magazine-canvas-bw" resourceType="brands/components/homepage/be-magazine-canvas-bw"/>

                    <div class="view-all-fixed-bottom">
                      <div class="view-all-wrapper text-center">
                      <a class="view-all">
                          <svg class="brands-icon icon-white link-icon-small no-text">
                            <use href="<%=svgIconPath%>#icon-arrow-down" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#icon-arrow-down"></use>
                          </svg></a></div>
                    </div>

                </div>
            </div>
        </div>

        <div class="swiper-slide home-screens-slide" data-title="instagram-wall-canvas">
            <div class="section-container home--screen5" data-swiper-parallax="-100%">
                <div class="background-container ${varInstaWallBkgrdStyle}" style="background-image: url(${varInstaWallBkgrdImg})" data-rjs="2">
                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions headerTitleBwOpts = IncludeOptions.getOptions(request, true);
                    headerTitleBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="header-title-bw" resourceType="brands/components/content/header-title-bw" />

                <%
                    //To remove extra div created by the AEM parsys
                    IncludeOptions InstagramWallCanvasBwOpts = IncludeOptions.getOptions(request, true);
                    InstagramWallCanvasBwOpts.setDecorationTagName("");
                %>
                    <cq:include path="instagram-wall-canvas-bw" resourceType="brands/components/content/instagram-wall-bw"/>
                    <cq:include script="footer.jsp" />

                </div>
            </div>
        </div>

    </div>
</div>