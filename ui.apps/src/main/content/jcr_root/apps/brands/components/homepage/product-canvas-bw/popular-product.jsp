<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.day.cq.tagging.Tag,
                  com.day.cq.tagging.TagManager" %>
<% 
List<Node> productList = WCMUtil.getMultiCompositePropertyNodeList(currentNode, "products");
TagManager tagManager = resourceResolver.adaptTo(TagManager.class);

for (Node productNode : productList) {
    String productPath = WCMUtil.getNodePropertyValue(productNode, "path");
    String productDesc = WCMUtil.getNodePropertyValue(productNode, "description_t");
    String productCta = WCMUtil.getNodePropertyValue(productNode, "cta-text_t");
    
    if (!productPath.isEmpty()) {
        Page productPage = pageManager.getPage(productPath);
        if (productPage != null) {
            String bgImg = WCMUtil.getPagePropertyValue(productPage, "page-bkgrd-img-path");
            String productTitle = productPage.getPageTitle();
            //String productImg =  WCMUtil.getPagePropertyValue(productPage, "prdt-bottle-img-path");
            String productImg =  WCMUtil.getPagePropertyValue(productPage, "prdt-img-path_hmpg");
            String productImgAlt =  WCMUtil.getPagePropertyValue(productPage, "prdt-bottle-img-alt_t");
            String productImgStyle = WCMUtil.getPagePropertyValue(productPage, "prdt-img-style-hmpg");
            //String dropletImg = WCMUtil.getPagePropertyValue(productPage, "prdt-droplet-img-path");
            String dropletImg = "";
            String[] lifestages = WCMUtil.getPagePropertyValues(productPage, "prdt-life-stage");
            %>
            
            <c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>
            <c:set var="varBgImg" value="<%= bgImg  %>"/>
            <c:set var="varProductTitle" value="<%= productTitle  %>"/>
            <c:set var="varProductImg" value="<%= productImg  %>"/>
            <c:set var="varProductImgAlt" value="<%= productImgAlt  %>"/>
            <c:set var="varProductImgStyle" value="<%= productImgStyle  %>"/>
            <c:set var="varDropletImg" value="<%= dropletImg  %>"/>
            <c:set var="varLifestages" value="<%= lifestages  %>"/>
            <c:set var="varProductPath" value="<%= WCMUtil.getURL(productPath, isAuthor)  %>"/>
            <c:set var="varProductDesc" value="<%= productDesc  %>"/>
            <c:set var="varProductCta" value="<%= productCta  %>"/>
            
            <div class="popular-product-info swiper-slide ${varProductImgStyle}">
              <div class="background-container background-cover-image" style="background-image: url(${varBgImg})">
                <div class="popular-product-info-content">
                      <h2>${varProductTitle}</h2>
                      <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-lg-offset-3 col-md-offset-3 col-sm-offset-3">
                    <div class="thumbnail">
                        <div class="product-info-image">
                          <c:choose>
                            <c:when test="${not empty varDropletImg}">
                              <img class="product-background img-responsive" src="${varDropletImg}" alt="${varProductImgAlt}">
                            </c:when>
                            <c:otherwise>
                              <img class="product-background img-responsive" style="visibility:hidden">
                            </c:otherwise>
                          </c:choose>
                          <img class="product-image" src="${varProductImg}" alt="${varProductImgAlt}">
                        </div>
                        <p>${varProductDesc}</p>
                        <ul class="product-benefits">
                          <% 
                          for (String lifestage : lifestages) {
                            Tag tag = tagManager.resolve(lifestage);
                              if (tag != null) {
                                String tagTitle = tag.getLocalizedTitle(site_locale);
                                String tagName = tag.getName();
                                String tagIcon = WCMUtil.getProductStageIcon(tagName);
                                %>
                                <c:set var="varTagTitle" value="<%= tagTitle  %>"/>
                                <c:set var="varTagIcon" value="<%= tagIcon  %>"/>
                                <li>
                                  <svg class="brands-icon icon-white icon-no-resize">
                                    <use href="${varSvgIconPath}#${varTagIcon}"></use>
                                  </svg>
                                  <div>${varTagTitle}</div>
                                </li>
                                <%
                              }
                          }
                          %>
                        </ul>
                        <a class="btn btn-action btn-lg" href="${varProductPath}">${varProductCta}</a>
                      </div>
                            
                            </div></div></div>
                
                
              </div>
            </div>
            <%
        }
    }
}
%>