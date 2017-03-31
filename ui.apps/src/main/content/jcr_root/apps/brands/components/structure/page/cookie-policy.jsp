<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String cookieHeader = pageProperties.getInherited("cookie-header_t", "");
String cookieMsg = pageProperties.getInherited("cookie-msg_t", "");
%>

<c:set var="varCookieHeader" value="<%= cookieHeader %>" />
<c:set var="varCookieMsg" value="<%= cookieMsg %>" />

<!--.text-center.hidden-xs.secondary-color-->
<div class="cookie-policy">
    <svg class="brands-icon icon-white link-icon-small" id="closecookiepolicy">
        <use href="<%=svgIconPath%>#icon-close" xlink:href="<%=svgIconPath%>#icon-close"></use>
    </svg>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h6 class="text-left">${varCookieHeader}</h6>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                ${varCookieMsg}
            </div>
        </div>
    </div>
</div>