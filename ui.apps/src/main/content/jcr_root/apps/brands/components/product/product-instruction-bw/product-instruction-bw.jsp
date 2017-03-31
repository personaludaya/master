<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,com.brands.core.models.*,com.brands.core.controller.*" %>

<%
String prdtInstrTitle = properties.get("prdt-instr-title_t", "");
String prdtInstrSubTitle = properties.get("prdt-instr-subtitle_t", "");
String prdtInstrCopy = properties.get("prdt-instr-copy_t", "");
String prdtInstrImgPath = properties.get("prdt-instr-img-path", "");
String prdtInstrImgAlt = properties.get("prdt-instr-img-alt_t", "");

ProductController productController = new ProductController();
Product product = new Product();
product = productController.getProuctPageProperties(currentPage, isAuthor, slingRequest);
%>
<c:set var="varPrdtInstrTitle" value="<%= prdtInstrTitle  %>"/>
<c:set var="varPrdtInstrSubTitle" value="<%= prdtInstrSubTitle  %>"/>
<c:set var="varPrdtInstrCopy" value="<%= prdtInstrCopy  %>"/>
<c:set var="varPrdtInstrImgPath" value="<%= prdtInstrImgPath  %>"/>
<c:set var="varPrdtInstrImgAlt" value="<%= prdtInstrImgAlt  %>"/>

<c:set var="varPrdImgBottleImgPath" value="<%= pageProperties.get("prdt-bottle-img-path", "") %>" />
<c:set var="varPrdImgBottleImgAltText" value="<%= product.getPrdImgBottleImgAltText() %>" />
<c:set var="varSvgIconPath" value="<%= svgIconPath  %>"/>

<div class="product-instruction">
    <div class="product-instruction-slide-item">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 col-lg-offset-6 col-md-offset-6 col-sm-offset-0 col-xs-offset-0">
                    <div class="instruction-detail-content">
                         <h3 class="text-left">${varPrdtInstrSubTitle}</h3>
                            <p>${varPrdtInstrCopy}</p>
                    </div>
                    
                    <div class="product-image-wrapper"><img class="product-image img-responsive" src="${varPrdImgBottleImgPath}" alt="${varPrdImgBottleImgAltText}" title="${varPrdImgBottleImgAltText}" data-rjs="2"></div>
                    <img class="img-responsive full-width" src="${varPrdtInstrImgPath}" alt="${varPrdtInstrImgAlt}" title="${varPrdtInstrImgAlt}" data-rjs="2">
                </div>
            </div>
        </div>
    </div>
</div>