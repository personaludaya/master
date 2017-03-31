<%--
  Top Bar Header component
  Consists of: Country selector, Language Selector, CTA Links, Search, Chatbot
  ==============================================================================
  Requirements:
  1. Country Selector: When the end-user selects another country from the list, the system will redirect them to the specific BW locale homepage
  2. Language Selector: The field will be featured when the site have more than 1 lanaguage

--%>
<%@include file="/apps/brands/global/global.jsp" %>
<%
String[] cta = pageProperties.getInherited("top-bar-paths", String[].class);
String ev5clickloc = "clickloc=topnav";
%>

<!-- top-bar molecule start here-->
<ul class="top-bar top-bar-sm top-bar-item col-lg-11 col-md-10 col-sm-10 col-xs-12">
    <cq:include script="stub-selectors.jsp" />
    <%
    if (cta != null) {
        for (int i=0;i<cta.length;i++) {
            String thisCtaPath = cta[i];
            Page thisCtaPage = pageManager.getPage(thisCtaPath);
            thisCtaPath = WCMUtil.getURL(thisCtaPage, isAuthor);

            if (!thisCtaPath.isEmpty()) {
                String thisCtaTitle = (thisCtaPage!=null) ? thisCtaPage.getTitle() : "";
                thisCtaPath += "#"+ ev5clickloc;
;
                %>
                <c:set var="varCtaTitle" value="<%= thisCtaTitle %>" />
                <c:set var="varCtaPath" value="<%= thisCtaPath %>" />
                
                <li><a href="${varCtaPath}">${varCtaTitle}</a></li>
                <%
            }
        }
    }
    %>
 </ul>
<ul class="top-bar top-bar-sm top-bar-icon col-lg-1 col-md-2 col-sm-2 col-xs-12">
    <%
    String cssSearchDisabled = "";
    String searchresPath = pageProperties.getInherited("search-result-path", "");
    if (currentPage.getPath().contains(searchresPath)) {
        cssSearchDisabled = "data-disabled=1";
    }
    %>
    <c:set var="varCssSearchDisabled" value="<%= cssSearchDisabled %>"/>
    <li class="search">
        <a class="btn btn-default btn-sm btnsearch" ${varCssSearchDisabled}>
            <svg class="brands-icon icon-white">
                <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-search" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-search"></use>
            </svg>
        </a>
    </li>
    
    <%
    boolean showChatbotIcon = true;    
    String ctemplate = currentPage.getProperties().get("cq:template", "");
    if (ctemplate.equals("/apps/brands/templates/homepage")) {
        showChatbotIcon = false;
    }
    
    String chatbotRule = pageProperties.getInherited("chatbot-visibility", "");
    int chatbotVisible = 0;
    try {
        chatbotVisible = Integer.parseInt(chatbotRule);
        if (chatbotVisible < 1) {
            showChatbotIcon = false;
        }
    } catch (Exception e) { }
    %>
    <c:set var="varShowChatbot" value="<%= showChatbotIcon %>"/>
    <c:if test="${varShowChatbot}">
    <!-- hide (dont render) this global chatbot on home page... checked with kitty and daniela-->
    <li class="chatbot">
        <a class="btn btn-default btn-sm btnchatbot" href="#">
            <svg class="brands-icon icon-white">
                <use href="<%=imgPath%>/icons/symbol-defs.svg#icon-chatbot" xlink:href="<%=imgPath%>/icons/symbol-defs.svg#icon-chatbot"></use>
            </svg>
        </a>
    </li>
    </c:if>
</ul>
<!-- top-bar molecule start here-->