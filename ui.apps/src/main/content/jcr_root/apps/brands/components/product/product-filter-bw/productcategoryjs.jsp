<%@include file="/apps/brands/global/global.jsp" %>
<%@page contentType="text/javascript;charset=utf-8" %>

var prodCategoryPath;
var prodCategory;

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
	
jQuery.ajaxSetup({
    // Disable caching of AJAX responses 
    cache: false
});

$(document).ready(function(){  
    $.ajax({
         type: "GET",
         url: '<%=currentNode.getPath()%>.productcategory.json',
         contentType: "application/json; charset=utf-8",
         success: function(data){
         //alert("TT");
           prodCategory = data;
           prodCategoryPath = '<%=currentNode.getPath()%>.productcategory.' + today + 'bw.json';
         }
    })
});
    