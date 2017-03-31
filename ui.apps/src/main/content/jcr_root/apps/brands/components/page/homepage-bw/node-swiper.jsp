<%@include file="/apps/brands/global/global.jsp" %><%
%>

<div class="nodes" data-0="display: block;" data-end="display: none;">
  <div class="line">
    <div class="blue">
      <div class="red-container">
        <div class="red"></div>
      </div>
    </div>
  </div>
  <c:if test="${cookie.is_show_chatbot.value == 'true' || empty cookie.is_show_chatbot.value}">
  <div class="node active" data-swiper-index="1">
    <div class="active-circle">
      <div class="splash"></div>
      <div class="cover">
        <div class="white"></div>
      </div>
    </div>
    <div class="inactive-circle">
      <div class="small-cover"></div>
    </div>
  </div>
  </c:if>
  <div class="node" data-swiper-index="2">
    <div class="active-circle">
      <div class="splash"></div>
      <div class="cover">
        <div class="white"></div>
      </div>
    </div>
    <div class="inactive-circle">
      <div class="small-cover"></div>
    </div>
  </div>
  <div class="node" data-swiper-index="3">
    <div class="active-circle">
      <div class="splash"></div>
      <div class="cover">
        <div class="white"></div>
      </div>
    </div>
    <div class="inactive-circle">
      <div class="small-cover"></div>
    </div>
  </div>
  <div class="node" data-swiper-index="4">
    <div class="active-circle">
      <div class="splash"></div>
      <div class="cover">
        <div class="white"></div>
      </div>
    </div>
    <div class="inactive-circle">
      <div class="small-cover"></div>
    </div>
  </div>
  
    <div class="node" data-swiper-index="5">
      <div class="active-circle">
        <div class="splash"></div>
        <div class="cover">
          <div class="white"></div>
         </div>
      </div>
      <div class="inactive-circle">
        <div class="small-cover"></div>
      </div>
    </div>
  
</div>