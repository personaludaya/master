<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="java.lang.StringBuilder, org.apache.commons.lang3.StringUtils" %><%
%><%
String dtmId = "";
String[] dtmHosts = new String[0];

String sgDtmId      = "da5c67bd44a76a9533c85f1eed16f01ce465d621";  //singapore
String[] sgDtmHosts = {"brands/sg/","brandsworld.com.sg"};
String hkDtmId      = "f8cc89b28e04c5cea0a632d91dab6a3a650709ef";  //hongkong
String[] hkDtmHosts = {"brands/hk/","brandsworld.com.hk"};
String myDtmId      = "de8a475dab165d9ec5d021ca78dd93e9aa9a26d0";  //malaysia
String[] myDtmHosts = {"brands/my/","brandsworld.com.my"};
String mmDtmId      = "91519b900f1465a4c6fb6c6361dbd5471b1c43f2";  //myanmar
String[] mmDtmHosts = {"brands/mm/","brandsworld.com.mm"};
String twDtmId      = "f6c298105b20a65b568e6d3990c5893cc67acf26";  //taiwan
String[] twDtmHosts = {"brands/tw/","brands.com.tw"};
String thDtmId      = "b4e02960710fb78f03a9c89b0d667dbe398cf19f";  //thailand
String[] thDtmHosts = {"brands/th/","brandsworld.co.th"};

String dtm_req_servername = slingRequest.getServerName();
String dtmPathCheck = currentPage.getPath();
if (StringUtils.indexOfAny(dtmPathCheck, sgDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, sgDtmHosts) > 0) {
    dtmId = sgDtmId;
    dtmHosts = sgDtmHosts;
} else if (StringUtils.indexOfAny(dtmPathCheck, hkDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, hkDtmHosts) > 0) {
    dtmId = hkDtmId;
    dtmHosts = hkDtmHosts;
} else if (StringUtils.indexOfAny(dtmPathCheck, myDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, myDtmHosts) > 0) {
    dtmId = myDtmId;
    dtmHosts = myDtmHosts;
} else if (StringUtils.indexOfAny(dtmPathCheck, mmDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, mmDtmHosts) > 0) {
    dtmId = mmDtmId;
    dtmHosts = mmDtmHosts;
} else if (StringUtils.indexOfAny(dtmPathCheck, twDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, twDtmHosts) > 0) {
    dtmId = twDtmId;
    dtmHosts = twDtmHosts;
} else if (StringUtils.indexOfAny(dtmPathCheck, thDtmHosts) > 0 || StringUtils.indexOfAny(dtm_req_servername, thDtmHosts) > 0) {
    dtmId = thDtmId;
    dtmHosts = thDtmHosts;
} else {
	dtmId = sgDtmId;
    dtmHosts = sgDtmHosts;
}

StringBuilder strBuilder = new StringBuilder();
for (int i = 1; i < dtmHosts.length; i++) { //exclude the first element!!
	if (i > 1) {
		strBuilder.append(",");
	}
    strBuilder.append("\"" + dtmHosts[i] + "\"");
}
String dtmHost = strBuilder.toString();

out.println("<!-- dtm_id >>>> " + dtmId + " #### dtm_host >>>> " + dtmHost + " -->");
%>

<c:set var="varDtmId" value="<%= dtmId %>"/>
<c:set var="varDtmHost" value="<%= dtmHost %>"/>

  <!-- Adobe Dynamic Tag Manager -->
  <script>
    var a = "//assets.adobedtm.com/94b1f4d73cfa658738ce046890114964956a0e8b/satelliteLib-${varDtmId}"; //script location
    var domainList = [${varDtmHost}]; //List of production domains 
    //append "-staging" if hostname is not found in domainList
    if (domainList.indexOf(location.hostname) < 0) {
      a += "-staging"
    }
    document.write(unescape('%3Cscript type="text/javascript" src="'+a+'.js"%3E%3C/script%3E')); //write to page
  </script>
  <!-- End Adobe Dynamic Tag Manager --> 