<%@include file="/apps/brands/global/global.jsp" %><%
%><%@page import="com.brands.core.utils.*,org.apache.commons.lang3.StringUtils,javax.servlet.http.Cookie,java.util.Random"
%><%
    String ruleStr = pageProperties.get("chatbot-visibility", "20");
    Double chatBotRule = Double.parseDouble(ruleStr);
    Integer min = (int) Math.ceil(chatBotRule/10.0);

    String visitCountCookieName = "hp_visit_count";
    String showCBCookieName = "is_show_chatbot";
    String shownCBCountCookieName = "shown_chatbot_count";
    Cookie visitCountCookie = slingRequest.getCookie(visitCountCookieName);
    Cookie showCBCookie = slingRequest.getCookie(showCBCookieName);
    Cookie hasShownCBCountCookie = slingRequest.getCookie(shownCBCountCookieName);

    if(min < 10) {
        Integer pageVisitCount = 1;
        Integer shownCBCount = 0;
        Integer max = 11;
        Random rand = new Random();
        Integer dt = rand.nextInt((max - min) + 1) + min;
        String isShowCBStr = "false";
        Boolean[] isForceDisplay = new Boolean[max+1];
        Boolean isMax = false;

        if(null == visitCountCookie) {
            visitCountCookie = new Cookie(visitCountCookieName, String.valueOf(pageVisitCount));
            visitCountCookie.setHttpOnly(true);
            visitCountCookie.setSecure(true);
            response.addCookie(visitCountCookie);
        } else {
            pageVisitCount = Integer.parseInt(visitCountCookie.getValue()) + 1;
            if(pageVisitCount >= (max + 1) && min != 0) {
                pageVisitCount = 2;
                isMax = true;
            }
            visitCountCookie.setHttpOnly(true);
            visitCountCookie.setSecure(true);
            visitCountCookie.setValue(String.valueOf(pageVisitCount));
            response.addCookie(visitCountCookie);
        }

        if(min != 0) {
            if(isMax) {
                shownCBCount = 0;
            } else if(null != hasShownCBCountCookie) {
                shownCBCount = Integer.parseInt(hasShownCBCountCookie.getValue());
            }

            Integer reverseCount = min - 1;
            for(int i = max; i > -1; i--) {
                if(reverseCount > -1) {
                    isForceDisplay[i] = true;
                } else {
                    isForceDisplay[i] = false;
                }
                reverseCount--;
            }

            if(shownCBCount < min && (pageVisitCount == 1 || dt <= min)) {
                isShowCBStr = "true";
                shownCBCount++;
            }

            if(StringUtils.equalsIgnoreCase(isShowCBStr, "false") && shownCBCount < min && isForceDisplay[pageVisitCount]) {
                isShowCBStr = "true";
                shownCBCount++;
            }

            if (null == hasShownCBCountCookie) {
                hasShownCBCountCookie = new Cookie(shownCBCountCookieName, String.valueOf(shownCBCount));
                hasShownCBCountCookie.setHttpOnly(true);
                hasShownCBCountCookie.setSecure(true);
                response.addCookie(hasShownCBCountCookie);
            } else {
            	hasShownCBCountCookie.setHttpOnly(true);
                hasShownCBCountCookie.setSecure(true);
                hasShownCBCountCookie.setValue(String.valueOf(shownCBCount));
                response.addCookie(hasShownCBCountCookie);
            }
        }

        if (null == showCBCookie) {
            showCBCookie = new Cookie(showCBCookieName, isShowCBStr);
            showCBCookie.setHttpOnly(true);
            showCBCookie.setSecure(true);
            response.addCookie(showCBCookie);
        } else {
        	showCBCookie.setHttpOnly(true);
            showCBCookie.setSecure(true);
            showCBCookie.setValue(isShowCBStr);
            response.addCookie(showCBCookie);
        }

    } else {
        Cookie[] ckToRemove = new Cookie[]{visitCountCookie, showCBCookie, hasShownCBCountCookie};

        String[] ckName = new String[]{visitCountCookieName, showCBCookieName, shownCBCountCookieName};
        for (int i = 0; i < ckToRemove.length; i++) {
            if(null != ckToRemove[i]) {
                Cookie ck = new Cookie(ckName[i],"");
                ck.setHttpOnly(true);
                ck.setSecure(true);
                ck.setMaxAge(0);
                response.addCookie(ck);
            }
        }
    }    
    
    //analytics::datalayer
    request.setAttribute("varPageInfoName", "homepage");
    
    String cssCtry = site_ctry;
    String cssLang = site_lang;
    String cssAuthor = "";

    if (isAuthor) {
        cssAuthor = "cq-author";
    }
%>

<c:set var="varCssCtry" value="<%= cssCtry %>"/>
<c:set var="varCssLang" value="<%= cssLang %>"/>
<c:set var="varCssAuthor" value="<%= cssAuthor %>"/>

<body class="${varCssCtry} ${varCssLang} ${varCssAuthor}">
<c:set var="varIsAuthor" value="<%= isAuthor %>"/>
<cq:include script="cookie-policy.jsp" />
<cq:include script="orgschema.jsp"/>
<div class="brands-canvas">
  <cq:include script="node-swiper.jsp" />
 
  <div class="section-container">
    <%-- IMPT! header is included in canvas-bkgrd.jsp --%>
    <cq:include script="canvas-bkgrd.jsp" />
  </div>
  <c:choose>
    <c:when test="${varIsAuthor == true}">
        <cq:include script="content-w-chatbot.jsp" />
    </c:when>
    <c:when test="${not empty cookie.is_show_chatbot.value && cookie.is_show_chatbot.value == 'false'}">
      <cq:include script="content-wo-chatbot.jsp" />
    </c:when>
    <c:otherwise>
      <cq:include script="content-w-chatbot.jsp" />
    </c:otherwise>
  </c:choose>
</div>

<cq:include script="js-libs.jsp" />

<cq:include script="gtm.jsp" />

<cq:include script="analytics.jsp" />

<%-- custom body content --%>
<cq:include script="misc-body-content.jsp" />

<cq:include path="timing" resourceType="foundation/components/timing" />

</body>