<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String searchResultPath = pageProperties.getInherited("search-result-path", "");
%>

<!-- search-box molecule start here-->
<div class="btnsubmenu" id="btnsubmenu">
  <div class="container-fluid search-container">
    <div class="search-box" id="search-box" style="display:none">
      <form id="site-search" action="<%= WCMUtil.getURL(searchResultPath, isAuthor) %>" method="GET">
        <div class="form-group">
          <label class="sr-only">Search</label>
          <div class="input-group input-group-lg">
            <input name="q" class="form-control search-box-control" type="text" placeholder="Search">
            <svg class="brands-icon icon-white">
              <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-search" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-search"></use>
            </svg>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- search-box molecule end here-->