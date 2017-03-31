<%@include file="/apps/brands/global/global.jsp" %><%
%>

<!-- popular-products-component start here-->
<div class="js-popular-products swiper-container">
  <div class="swiper-wrapper">
  
    <!-- popular-product-info start here-->
    <cq:include script="popular-product.jsp"/>
    <!-- popular-product-info end here-->
                                    
  </div>
  <div class="swiper-pagination"></div>
  <div class="swiper-next">
    <div class="swiper-button-wrapper">
      <div class="swiper-button">
        <svg class="brands-icon link-icon-small icon-center">
          <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-right" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-right"></use>
        </svg>
      </div>
    </div>
  </div>
  <div class="swiper-prev">
    <div class="swiper-button-wrapper">
      <div class="swiper-button">
        <svg class="brands-icon link-icon-small icon-center">
          <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-left" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-arrow-left"></use>
        </svg>
      </div>
    </div>
  </div>
</div>
<!-- popular-products-component end here-->
              
<cq:include script="lifestages.jsp"/>