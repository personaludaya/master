<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,
            java.util.*,
            org.apache.commons.lang3.StringUtils,
            com.brands.core.models.*,
            com.brands.core.controller.*"
%><%
String maxColsParamVal = slingRequest.getParameter("maxCol");
String prdtPageIdParamVal = slingRequest.getParameter("q");

if(StringUtils.isEmpty(maxColsParamVal)) {
    maxColsParamVal = "4";
}
if(StringUtils.isEmpty(prdtPageIdParamVal)) {
    prdtPageIdParamVal = "";
}

List<String> prdtPageIdArr = Arrays.asList(prdtPageIdParamVal.split(","));

String cpHeader = properties.get("compare-prdt-header_t", "");
String cpHeaderSize = properties.get("compare-prdt-header-size", "h1");
String cpHeaderAlign = properties.get("compare-prdt-header-alignment", "text-center");
String cpHeaderStyle = properties.get("compare-prdt-header-style", "secondary-color");
String cpCTAPath = properties.get("cta-path", "");
String cpCTATxt = properties.get("cta-text", "");
String cpCTAType = properties.get("cta-type", null);
String cpCTAStyle = properties.get("cta-style", "primary-color");
String cpOpenNewWindow = properties.get("cta-open-new-win", "");
String prdtRootPath = properties.get("prdt-root-path", "");
String prdtOpenNewWindow = properties.get("prdt-open-new-win", "");
String colDisplayImage = properties.get("compare-display-img", "");
String colDisplayTitle = properties.get("compare-display-title", "");
String colDisplayECommCTA = properties.get("compare-display-ec-cta", "");
String colECommCTATxt = properties.get("compare-ec-cta-text_t", "buynow");
String colDisplayPrice = properties.get("compare-display-price", "");
String colDisplayLifeStage = properties.get("compare-display-lifestage", "");
String colDisplayIngredients = properties.get("compare-display-ingredients", "");
String colDisplayIngredientsVol = properties.get("compare-display-ingredients-vol", "");
String colDisplayNutriInfo = properties.get("compare-display-nutri-info", "");
String colFreeBtnIcon = properties.get("compare-free-col-btn-icon", "icon-white");
String colFreeBtnIconStyle = properties.get("compare-free-col-btn-icon-style", "icon-plus-white");
String colFreeColDescr = properties.get("compare-free-col-descr_t", "");
String componentName = component.getProperties().get("jcr:title", "");

cpCTATxt = I18nUtil.getLabel(cpCTATxt, currentPage, slingRequest, null);
colECommCTATxt = I18nUtil.getLabel(colECommCTATxt, currentPage, slingRequest, null);

Boolean isDisplayIngredientVol = Boolean.parseBoolean(colDisplayIngredientsVol);
String cpCTAUrl = "";
String cpCTAClass = "";
String hdTargetBlankStr = "";
String prdtTargetBlankStr = "";
String sectPriceTitle = "";
String sectLifestyleTitle = "";
String sectIngredientsTitle = "";
String sectNutriInfoTitle = "";

if(StringUtils.isNotEmpty(cpCTAPath)) {
    cpCTAUrl =  WCMUtil.getURL(cpCTAPath, isAuthor) + "#product-compare-selection";
}

String addOnClickStr = "window.location.href='"+ cpCTAUrl+"'; return false;";

if(StringUtils.equalsIgnoreCase(cpOpenNewWindow, "true")) {
    addOnClickStr = "window.open('"+ cpCTAUrl +"'); return false;";
}

if(StringUtils.equalsIgnoreCase(cpCTAType, "button")) {
    cpCTAClass = "btn-action";
}

if(StringUtils.equalsIgnoreCase(cpOpenNewWindow, "true")) {
    hdTargetBlankStr = "target=\"_blank\"";
}

if(StringUtils.equalsIgnoreCase(prdtOpenNewWindow, "true")) {
    prdtTargetBlankStr = "target=\"_blank\"";
}

if(StringUtils.equalsIgnoreCase(colDisplayPrice, "true")) {
    sectPriceTitle = properties.get("compare-price-title_t", "Price");
}

if(StringUtils.equalsIgnoreCase(colDisplayLifeStage, "true")) {
    sectLifestyleTitle = properties.get("compare-lifestage-title_t", "Suitable for");
}

if(StringUtils.equalsIgnoreCase(colDisplayIngredients, "true")) {
    sectIngredientsTitle = properties.get("compare-ingredients-title_t", "Ingredients");
}

if(StringUtils.equalsIgnoreCase(colDisplayNutriInfo, "true")) {
    sectNutriInfoTitle = properties.get("compare-nutri-info-title_t", "Nutritional information");
}

List<Product> foundPrdtArr = new ArrayList<Product>();
List<String> matchedPrdtId = new ArrayList<String>();
String productPageRsrc = "brands/components/page/productpage-bw";

if(StringUtils.isNotEmpty(prdtRootPath)) {
    Page root = pageManager.getPage(prdtRootPath);

    Integer requiredDepth = 1;
    Integer rootDepth = root.getDepth();

    Iterator<Page> children = root.listChildren(new PageFilter(), true);

    while (children.hasNext()) {
        Page child = children.next();
        Integer relativeDepth = child.getDepth() - rootDepth;

        if(relativeDepth <= requiredDepth) {
            for(int i = 0; i < relativeDepth; i++) {
                for(String id : prdtPageIdArr) {
                    if(StringUtils.equalsIgnoreCase(id, child.getName())) {
                        if(StringUtils.equalsIgnoreCase(productPageRsrc, child.getProperties().get("sling:resourceType", ""))) {
                            Product prodItem = new Product();
                            ProductController prodController = new ProductController();
                            prodItem = prodController.getProuctPageProperties(child, isAuthor, slingRequest);

                            if(prodItem != null) {
                                foundPrdtArr.add(prodItem);
                                matchedPrdtId.add(id);
                            }
                        }
                    }
                }
            }
        }
    }
}

Integer totalResults = foundPrdtArr.size();
Integer maxCols = Integer.parseInt(maxColsParamVal);
Integer freeCol = maxCols - totalResults;
cpHeader = cpHeader.replace("##num##", String.valueOf(totalResults));
%>

<c:set var="varHeaderSize" value="<%=cpHeaderSize%>" />
<c:set var="varHeaderTxt" value="<%=cpHeader%>" />
<c:set var="varHeaderStyle" value="<%=cpHeaderStyle%>" />
<c:set var="varHeaderAlign" value="<%=cpHeaderAlign%>" />
<c:set var="varHeaderTargetBlankStr" value="<%=hdTargetBlankStr%>" />
<c:set var="varHeaderCTAUrl" value="<%=cpCTAUrl%>" />
<c:set var="varHeaderCTATxt" value="<%=cpCTATxt%>" />
<c:set var="varHeaderCTAStyle" value="<%=cpCTAStyle%>" />
<c:set var="varIsDispImg" value="<%=colDisplayImage%>" />
<c:set var="varIsDispTitle" value="<%=colDisplayTitle%>" />
<c:set var="varIsDispEComm" value="<%=colDisplayECommCTA%>" />
<c:set var="varIsDispPrice" value="<%=colDisplayPrice%>" />
<c:set var="varIsDispImgLifeStage" value="<%=colDisplayLifeStage%>" />
<c:set var="varIsDispIngredients" value="<%=colDisplayIngredients%>" />
<c:set var="varIsDispImgNutriInfo" value="<%=colDisplayNutriInfo%>" />
<div data-js-loader='["compare-products-container.js"]'></div>

<div class="section-container compare-product">
    <${varHeaderSize} class="${varHeaderStyle} ${varHeaderAlign}">
        ${varHeaderTxt}
    </${varHeaderSize}>

    <c:if test="${not empty varHeaderCTATxt}">
    <div class="view-all-wrapper ${varHeaderAlign}">
        <a class="view-all ${varHeaderCTAStyle}" href="${varHeaderCTAUrl}" ${varHeaderTargetBlankStr}>
            ${varHeaderCTATxt}
        </a>
    </div>
    </c:if>
</div>


<div class="section-container compare-product--products">
    <div class="loader">
		<svg class="brands-icon brands-loader icon-center fa-pulse">
		<use href="<%=imgPath%>/icons/symbol-defs.svg#icon-loading" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-loading"></use>
		</svg>
	</div>
	<div class="js-compare-products swiper-container swiper-container-horizontal">

		<!-- table container start here -->
		<div class="compare-products-wrapper swiper-wrapper">

		<%
            int count = 0;
			for(Product prdt : foundPrdtArr) {
                if(count < maxCols) {
                    String prdtUrl = WCMUtil.getURL(prdt.getPrdPath(), isAuthor);
                    String eCommTargetBlankStr = "";
                    String prdtUniqueId = matchedPrdtId.get(count);
                    String pidStr = "#pid=bw_by_" + ANALYTICS_BODY + "_" + componentName;
                    String eCommUrl = prdt.getPrdEcommerceUrl();

                    Map<String, String> prdtCatMap = prdt.getPrdCategoryMap();
                    String prdtCatTagName = "";
                    String prdtCatTagID = "";
                    for (Map.Entry<String, String> entry : prdtCatMap.entrySet() ) {
                        prdtCatTagName = entry.getValue();
                        prdtCatTagID = WCMUtil.getTagKeyByTags(entry.getKey());
                    }

                    String prdtAnalyticsStr = "\"product\":{\"productInfo\":{\"productName\":\"" + prdtUniqueId + "\",\"productID\":\"" + prdt.getPrdId() + "\"},\"category\":{\"primaryCategory\":\"" + prdtCatTagID + "\",\"primaryCategoryID\":\"" + prdt.getPrdEcommerceCatId() + "\"}}";
                    String eCommAnalyticsStr = "{\"event\":{\"eventInfo\":{\"eventType\":\"ecommerce\",\"eventName\":\"" + ANALYTICS_BODY + ":" + componentName + "\",\"eventAction\":\"buynow\",\"eventURL\":\"" + eCommUrl  + "\"}}," + prdtAnalyticsStr + "}";

                    if(StringUtils.isNotEmpty(eCommUrl)) {
                        eCommUrl += pidStr;
                        eCommTargetBlankStr = "target=\"_blank\"";;
                    }
		%>

			<c:set var="varPrdtUrl" value="<%=prdtUrl%>" />
			<c:set var="varPrdtName" value="<%=prdt.getPrdPageTitle()%>" />
			<c:set var="varPrdtUniqueId" value="<%=prdtUniqueId%>" />
			<c:set var="varPrdtPkgImgPath" value="<%=prdt.getPrdPackageImgPath()%>" />
			<c:set var="varPrdtPkgImgAltTxt" value="<%=prdt.getPrdPackageImgAltText()%>" />
			<c:set var="varPrdtECommTargetBlankStr" value="<%=eCommTargetBlankStr%>" />
			<c:set var="varPrdtECommUrl" value="<%=eCommUrl%>" />
			<c:set var="varECommAnalytics" value="<%=eCommAnalyticsStr%>" />
			<c:set var="varPrdtPriceCurrency" value="<%=prdt.getPrdPriceCurrency()%>" />
			<c:set var="varPrdtRetailTitle" value="<%=prdt.getPrdRetailPriceTitle()%>" />
			<c:set var="varPrdtRetailPrice" value="<%=prdt.getPrdRetailPrice()%>" />
			<c:set var="varPrdtSpecialTitle" value="<%=prdt.getPrdSpecialPriceTitle()%>" />
			<c:set var="varPrdtSpecialPrice" value="<%=prdt.getPrdSpecialPrice()%>" />

			<!-- compare column start here -->
			<div class="compare-products-slide swiper-slide">
				<div class="container-fluid">

					<!-- product section start here -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 compare-product-border no-padding-col">
							<div class="compare-products-info" style="min-height: 433px;">
								<a class="btn-remove" data-product-unique-id="${varPrdtUniqueId}">
									<svg class="brands-icon link-icon-small">
										<use href="<%=svgIconPath%>#icon-close" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#icon-close"></use>
									</svg>
								</a>
								<div class="content">

									<c:if test="${varIsDispImg == 'true'}">
									<a href="${varPrdtUrl}" <%=prdtTargetBlankStr%>>
                                        <img class="img-responsive" src="${varPrdtPkgImgPath}" alt="${varPrdtPkgImgAltTxt}" title="${varPrdtPkgImgAltTxt}">
                                    </a>
									</c:if>

									<c:if test="${varIsDispTitle == 'true'}">
									<a href="${varPrdtUrl}" <%=prdtTargetBlankStr%>>
                                        <h4>
                                            ${varPrdtName}
                                        </h4>
                                    </a>
									</c:if>

									<c:if test="${varIsDispEComm == 'true'}">
									<a class="btn btn-action btn-lg" href="${varPrdtECommUrl}" ${varPrdtECommTargetBlankStr} data-analytics='${varECommAnalytics}'>
                                            <%=colECommCTATxt%>
									</a>
									</c:if>

								</div>
							</div>
						</div>
					</div>
					<!-- product section end here -->

					<c:if test="${varIsDispPrice == 'true'}">
					<!-- price section start here -->
					<div class="row info-header-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding-col">
							<h4>
								<%=sectPriceTitle%>
							</h4>
						</div>
					</div>

					<div class="row info-content-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 compare-product-border no-padding-col">
							<ul class="compare-products-info-price">

                                <c:choose>
                                    <c:when test="${not empty varPrdtSpecialPrice}">
                                    <li>
                                        <h4 class="text-left">
                                            ${varPrdtSpecialTitle}
                                            <span class="price">
                                                <span class="currency">${varPrdtPriceCurrency}</span>
                                                <span class="amount">${varPrdtSpecialPrice}</span>
                                            </span>
                                        </h4>
                                    </li>
                                    <li>
                                        ${varPrdtRetailTitle}
                                        <del>${varPrdtPriceCurrency}${varPrdtRetailPrice}</del>
                                    </li>
                                    </c:when>

                                    <c:otherwise>
                                        <h4 class="text-left">
                                            ${varPrdtRetailTitle}
                                            <span class="price">
                                                <span class="currency">${varPrdtPriceCurrency}</span>
                                                <span class="amount">${varPrdtRetailPrice}</span>
                                            </span>
                                        </h4>
                                    </c:otherwise>
								</c:choose>

							</ul>
						</div>
					</div>
					<!-- price section end here -->
					</c:if>

					<c:if test="${varIsDispImgLifeStage == 'true'}">
					<!-- lifestyle section start here -->
					<div class="row info-header-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding-col">
							<h4>
								<%=sectLifestyleTitle%>
							</h4>
						</div>
					</div>

					<div class="row info-content-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 compare-product-border no-padding-col">
							<ul class="compare-products-info-links">

							<%
                                Map<String, String> prdtLifeStageMapTags = prdt.getPrdLifeStageMap();
                                for (Map.Entry<String, String> entry : prdtLifeStageMapTags.entrySet() ) {
                                    String lifeStageKey = WCMUtil.getTagKeyByTags(entry.getKey());
                                    String lifeStageValue = entry.getValue();
                                    String lifeStageIcon = svgIconPath + "#" +  WCMUtil.getProductStageIcon(lifeStageKey);

							%>
								<li>
									<svg class="brands-icon icon-no-resize">
                                        <use href="<%=lifeStageIcon%>" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=lifeStageIcon%>"></use>
									</svg>
									<div class="benefit-name">
                                        <%=lifeStageValue%>
									</div>
								</li>
							<%
                                }
							%>

							</ul>
						</div>
					</div>
					<!-- lifestyle section end here -->
					</c:if>

					<c:if test="${varIsDispIngredients == 'true'}">
					<!-- ingredients section start here -->
					<div class="row info-header-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding-col">
							<h4>
								<%=sectIngredientsTitle%>
							</h4>
						</div>
					</div>

					<div class="row info-content-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 compare-product-border no-padding-col">
							<ul class="compare-products-info-links">

							<%
                                List<ProductIngredient> ingrdtList = prdt.getPrdIngredientsList();

                                for (ProductIngredient ingrdt : ingrdtList) {
                                    String ingrdtConfigPath = ingrdt.getIngredientPagePath();
                                    String ingrdtConfigTxt = ingrdt.getIngredientTxt();
                                    String ingrdtConfigVol = ingrdt.getIngredientVolume();
                                    String ingrdtDispTxt = "";

                                    if (StringUtils.isNotEmpty(ingrdtConfigPath)) {
                                        Page ingredientPage = pageManager.getPage(ingrdtConfigPath);
                                        ingrdtDispTxt = ingredientPage.getPageTitle();
                                    } else if(StringUtils.isNotEmpty(ingrdtConfigTxt)) {
                                        ingrdtDispTxt = ingrdtConfigTxt;
                                    }

                                    if(StringUtils.isNotEmpty(ingrdtConfigVol) && isDisplayIngredientVol) {
                                        ingrdtDispTxt = ingrdtDispTxt + " " + ingrdtConfigVol;
                                    }

							%>
                                <li>
                                  <%=ingrdtDispTxt%>
                                </li>
							<%
                                }
							%>

							</ul>
						</div>
					</div>
					<!-- ingredients section end here -->
					</c:if>

					<c:if test="${varIsDispImgNutriInfo == 'true'}">
					<!-- nutri info section start here -->
					<div class="row info-header-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding-col">
							<h4>
								<%=sectNutriInfoTitle%>
							</h4>
						</div>
					</div>

					<div class="row info-content-row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 compare-product-border no-padding-col">
							<ul class="compare-products-info-links">

							<%

                                Map<String, String> nutritionalInfoMap = prdt.getPrdNutritionalInformationMap();
                                for (Map.Entry<String, String> entry : nutritionalInfoMap.entrySet()) {
                                    String nutritionalKey = WCMUtil.getTagKeyByTags(entry.getKey());
                                    String nutritionalValue = entry.getValue();
                            %>
                                <li>
                                    <%=nutritionalValue%>
                                </li>
                            <%
                            	}
                            %>

							</ul>
						</div>
					</div>
					<!-- nutri info section end here -->
					</c:if>

				</div>
			</div>
			<!-- compare column end here -->
		<%
                }
                count++;

			}
		%>

		<%
			for (int i = 0; i < freeCol; i++) {
		%>
			<!-- empty columnn start here -->
			<div class="swiper-slide">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="compare-products-info add-another-product-to-compare-bg">
								<div class="content-add-new">
									<button class="btn btn-action btn-lg" onClick="<%=addOnClickStr%>">
                                        <svg class="brands-icon <%=colFreeBtnIcon%>" style="margin-right:0px;">
                                            <use href="<%=svgIconPath%>#<%=colFreeBtnIconStyle%>" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#<%=colFreeBtnIconStyle%>"></use>
                                        </svg>
									</button>
									<h4><%=colFreeColDescr%></h4>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- empty columnn end here -->
		<%
			}
		%>

		</div>
		<!-- table container end here -->

	</div>

	<!-- mobile swiper start here -->
	<div class="swiper-prev">
		<div class="swiper-button-wrapper">
			<div class="swiper-button">
				<svg class="brands-icon link-icon-small icon-center">
					<use href="<%=svgIconPath%>#icon-arrow-left" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#icon-arrow-left"></use>
				</svg>
			</div>
		</div>
	</div>

	<div class="swiper-next">
		<div class="swiper-button-wrapper">
			<div class="swiper-button">
			<svg class="brands-icon link-icon-small icon-center">
				<use href="<%=svgIconPath%>#icon-arrow-right" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<%=svgIconPath%>#icon-arrow-right"></use>
			</svg>
			</div>
		</div>
	</div>
	<!-- mobile swiper end here -->
</div>