<%@include file="/apps/brands/global/global.jsp" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%
String copyrightLabel = pageProperties.getInherited("copyrightLabel_t", "");
String[] bottomLinksArr = pageProperties.getInherited("btmf-link-paths", String[].class);
%>
<c:set var="varCopyrightLabel" value="<%= copyrightLabel  %>"/>
<c:set var="varFootLinkPaths" value="<%= bottomLinksArr  %>"/>

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
  <div class="row">
    <div class="col-lg-7 col-md-7 col-sm-6 col-xs-12">
    	<c:if test="${fn:length(varFootLinkPaths) > 0}">
    		<ul class="terms-of-use-and-privacy-policy">
    		<%
    		int count = 0;
    		for(String bottomLink : bottomLinksArr) {
    			Page bottomLinkPage = pageManager.getPage(bottomLink);
    			if(bottomLinkPage != null){
    				if(count > 0){
    					%><li class="text-green">|</li><%
    				}
    				String linkLabel = WCMUtil.getNavTitle(bottomLinkPage);
    				String bottomLinkPath =  WCMUtil.getURL(bottomLink, isAuthor);
    				if(StringUtils.isNotEmpty(bottomLinkPath)) bottomLinkPath+="#clickloc=footer";
    				count++;
    				%>
    				<c:set var="varFootLinkPath" value="<%= bottomLinkPath  %>"/>
    				<c:set var="varFootLinkLabel" value="<%= linkLabel  %>"/>
    				<li> <a href="${varFootLinkPath }">${varFootLinkLabel }</a></li>
    				<%
    			}
    			
    		}
    		%>
    		</ul>
	     </c:if>
    </div>
    <div class="col-lg-5 col-md-5 col-sm-6 col-xs-12">
      <p>${varCopyrightLabel }</p>
    </div>
  </div>
</div>