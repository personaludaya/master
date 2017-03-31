<%@include file="/apps/brands/global/global.jsp" %>
<%@page contentType="text/javascript;charset=utf-8" %>

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1;
var yyyy = today.getFullYear();
if(dd < 10){
	dd = '0' + dd
}
if(mm < 10){
	mm = '0' + mm
}
var today = dd+mm+yyyy;

var instaPath = '<%=currentNode.getPath()%>.instagram.' + today + 'bw.json';
	
jQuery.ajaxSetup({
    // Disable caching of AJAX responses 
    cache: false
});