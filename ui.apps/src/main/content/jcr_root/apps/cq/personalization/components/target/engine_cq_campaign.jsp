<%--

  ADOBE CONFIDENTIAL
  __________________

   Copyright 2014 Adobe Systems Incorporated
   All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.

--%><%@page
    session="false"
    pageEncoding="utf-8"
    import="
        java.util.ResourceBundle,
        com.day.text.Text,
        com.day.cq.i18n.I18n,
        com.day.cq.wcm.api.WCMMode,
        com.day.cq.wcm.core.stats.PageViewStatistics,
        com.day.cq.personalization.TargetedContentManager,
        com.day.cq.personalization.ClientContextUtil,
        org.apache.sling.api.resource.Resource,
        org.apache.sling.commons.json.JSONObject,
        org.apache.sling.commons.json.JSONArray,
        org.apache.sling.commons.json.JSONException,
        java.util.Iterator,
        org.apache.sling.api.resource.ValueMap,
        com.adobe.granite.xss.XSSAPI,
        com.day.cq.wcm.api.AuthoringUIMode"
%><%@include file="/libs/foundation/global.jsp" %><%

    boolean isTouch = AuthoringUIMode.TOUCH.equals(AuthoringUIMode.fromRequest(slingRequest));

    if (WCMMode.fromRequest(request) != WCMMode.DISABLED && !isTouch) {
        %><cq:includeClientLib categories="personalization.kernel"/><%
    }

    final ResourceBundle resourceBundle = slingRequest.getResourceBundle(null);
    I18n i18n = new I18n(resourceBundle);
    final TargetedContentManager targetedContentManager = sling.getService(TargetedContentManager.class);

    /* get page properties */
    final String campaignPath = properties.get("campaignpath", String.class);
    final String strategyPath = properties.get("strategyPath", "");
    final String location = properties.get("location", resource.getPath());
    final String strategy = Text.getName(strategyPath).replaceAll(".js", "");

    String campaignClass = "";
    if (campaignPath != null) {
        Page campaignPage = pageManager.getPage(campaignPath);
        if (campaignPage != null) {
            campaignClass = "campaign-" + campaignPage.getName();
        }
    }

    /* try to generate a "friendly" id for the div where teaser will be placed */
    String targetDivId = ClientContextUtil.getId(resource.getPath());
    final PageViewStatistics pwSvc = sling.getService(PageViewStatistics.class);
    String trackingURLStr = null;

    if (pwSvc != null && pwSvc.getTrackingURI() != null) {
        trackingURLStr = pwSvc.getTrackingURI().toString();
    }

    /* get list of teasers */
    JSONObject teaserInfo = targetedContentManager.getTeaserInfo(resourceResolver, campaignPath, location);
    JSONArray allTeasers = null;
    int numberOfTeasers = 0;

    try {
        allTeasers = teaserInfo.getJSONArray("allTeasers");
    } catch (JSONException e) {
        /* do nothing */
    }

    if (allTeasers != null) {
        String selectors = slingRequest.getRequestPathInfo().getSelectorString();
        selectors = (selectors != null) ? ("." + selectors) : "";

        for (int i = 0; i < allTeasers.length(); i++) {

            try {
                JSONObject teaser = (JSONObject) allTeasers.get(i);
                teaser.put("url", teaser.get("path") + "/_jcr_content/par" + selectors + ".html");
            } catch (JSONException e) {
                /* error when getting teaser info */
            }
        }

        /* create "default" teaser */
        JSONObject defaultTeaser = new JSONObject();

        try {
            defaultTeaser
                .put("path", resource.getPath() + "/default")
                .put("url", resource.getPath() + ".default" + selectors + ".html")
                .put("name", "default")
                .put("title", i18n.get("Default"))
                .put("campaignName", "")
                .put("thumbnail", resource.getPath() + ".thumb.png");
        } catch (JSONException e) {
            /* error when setting teaser info */
        }

        /* add "default" teaser */
        allTeasers.put(defaultTeaser);

        /* count teasers */
        numberOfTeasers = allTeasers.length();
    }

    if (numberOfTeasers > 0) {
        if (WCMMode.fromRequest(request) == WCMMode.DISABLED) {
            %> &lt;% <%
            int nbConditions = 0;
            for (int i = 0; i < numberOfTeasers; i++) {
                JSONObject teaser = null;

                /* get teaser info */
                try {
                    teaser = allTeasers.getJSONObject(i);
                } catch (JSONException e) {
                    /* error when getting teaser info */
                }

                /* skip this item if there was error */
                if (teaser == null) {
                    continue;
                }

                /* process given teaser */
                String teaserPath = null, segmentPath = null;

                try {
                    teaserPath = teaser.getString("path");

                    /* get first segment from the list */
                    if (teaser.has("segments")) {
                        JSONArray segments = teaser.getJSONArray("segments");

                        if (segments.length() > 0) {
                            segmentPath = segments.getString(0);
                        }
                    }
                } catch (JSONException e) {
                    /* error when getting teaser info */
                }

                /* skip this teaser if path is unknown */
                if (teaserPath == null) {
                    continue;
                }

                /* display "default" teaser if segment path is empty */
                if (segmentPath == null) {
                    %><%= (nbConditions > 0) ? " } else { %&gt; " : "%&gt;" %>
                    <sling:include path="<%= teaserPath + ".html" %>"/>
                    <%= (nbConditions > 0) ? " &lt;% } " : "&lt;%" %><%
                } else {
                    /* get segment definition to find out condition */
                    Resource segmentResource = resourceResolver.getResource(segmentPath);
                    // get OR expression
                    String condition = buildDisjunction(segmentResource.getChild("jcr:content/traits/orpar"), xssAPI);

                    /* don't include the teaser if condition is unknown */
                    if (condition != null) {
                        %><%= (nbConditions > 0) ? "} else " : "" %><%
                        %> if (<%= condition %>) { %&gt;
                            <sling:include path="<%= teaserPath + "/jcr:content/par.html" %>"/>
                        &lt;%<%
                        nbConditions++;
                    }
                }
            }
            %> %&gt; <%
        } else if (isTouch && resource.getChild("default") != null) {
            %><sling:include path="default"/><%
        } else {
            %>
            <script type="text/javascript">
                $CQ(function() {
                    CQ_Analytics.Engine.loadTeaser({
                        targetID: "<%= xssAPI.encodeForJSString(targetDivId) %>",
                        teasers: <%= allTeasers %>,
                        strategy: "<%= xssAPI.encodeForJSString(strategy) %>",
                        trackingURL: "<%= xssAPI.encodeForJSString(trackingURLStr) %>"
                    });
                });
            </script>
            <div id="<%= xssAPI.encodeForHTMLAttr(targetDivId) %>" class="campaign <%= xssAPI.encodeForHTMLAttr(campaignClass) %>"></div>
            <%
        }
    } else if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
        %><style type="text/css">
            .cq-teaser-placeholder-off { display: none; }
        </style>
        <h3 class="cq-texthint-placeholder"><%=i18n.get("No active campaigns target this teaser") %></h3>
        <img src="/libs/cq/ui/resources/0.gif" class="cq-teaser-placeholder" alt=""><%
    }
%><%
%><%!

    /**
     * Builds a disjunction with all children of the supplied resource. The returned
     * string is already escaped for HTML context.
     */
    private String buildDisjunction(Resource orPar, XSSAPI xssAPI) {
        if (orPar == null) {
            return null;
        }
        Iterator<Resource> iterator = orPar.getChildren().iterator();
        if (!iterator.hasNext()) {
            return null;
        }
        boolean isFirst = true;
        StringBuilder disjunction = new StringBuilder();
        while (iterator.hasNext()) {
            ValueMap properties = iterator.next().adaptTo(ValueMap.class);
            String key = properties.get("key", (String) null);
            String operator = properties.get("operator", (String) null);
            String segmentId = properties.get("segmentId", (String) null);
            if (key == null || operator == null || segmentId == null) {
                return null;
            }
            if (!isFirst) {
                disjunction.append(" || ");
            }
            isFirst = false;
            String condition = xssAPI.encodeForHTML(key) + " " + operator + " \"" + xssAPI.encodeForHTML(segmentId) + "\"";
            disjunction.append(condition);
        }
        return disjunction.toString();
    }

%>
