<%@include file="/apps/brands/global/global.jsp" %><%
%><%
String gtmId = "";
String gtmHost = "";

String qaGtmId = "TK9MHPL";  //qa-env
String sgGtmId = "W7HR6F";  //singapore
String hkGtmId = "TGTXRS";  //hongkong
String myGtmId = "NZQKMB";  //malaysia
String mmGtmId = "P78DF4";  //myanmar
String twGtmId = "NN6TG5";  //taiwan
String thGtmId = "TSP6HC";  //thailand

String gtm_req_servername = slingRequest.getServerName();
if (gtm_req_servername.indexOf("brandsworld.com.sg") > -1) {
	gtmId = sgGtmId;
    gtmHost = "sg";
} else if (gtm_req_servername.indexOf("brandsworld.com.hk") > -1) {
	gtmId = hkGtmId;
    gtmHost = "hk";
} else if (gtm_req_servername.indexOf("brandsworld.com.my") > -1) {
    gtmId = myGtmId;
    gtmHost = "my";
} else if (gtm_req_servername.indexOf("brandsworld.com.mm") > -1) {
    gtmId = mmGtmId;
    gtmHost = "mm";
} else if (gtm_req_servername.indexOf("brands.com.tw") > -1) {
    gtmId = twGtmId;
    gtmHost = "tw";
} else if (gtm_req_servername.indexOf("brandsworld.co.th") > -1) {
    gtmId = thGtmId;
    gtmHost = "th";
} else {
	gtmId = qaGtmId;
	gtmHost = "qa";
}

out.println("<!-- gtm_id >>>> " + gtmId + " #### gtm_host >>>> " + gtmHost + " -->");
%>

<c:set var="varGtmId" value="<%= gtmId %>"/>

<!-- Google Tag Manager -->
<script>
 (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
 new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
 j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
 '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
 })(window,document,'script','dataLayer','GTM-${varGtmId}');
</script>
<!-- End Google Tag Manager --> 
<!-- Google Tag Manager (noscript) -->
<noscript>
  <iframe src="//www.googletagmanager.com/ns.html?id=GTM-${varGtmId}" originalattribute="src" originalpath="//www.googletagmanager.com/ns.html?id=GTM-${varGtmId}" height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->