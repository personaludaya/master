<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ~
  ~ ADOBE CONFIDENTIAL
  ~ __________________
  ~
  ~  Copyright 2013 Adobe Systems Incorporated
  ~  All Rights Reserved.
  ~
  ~ NOTICE:  All information contained herein is, and remains
  ~ the property of Adobe Systems Incorporated and its suppliers,
  ~ if any.  The intellectual and technical concepts contained
  ~ herein are proprietary to Adobe Systems Incorporated and its
  ~ suppliers and are protected by trade secret or copyright law.
  ~ Dissemination of this information or reproduction of this material
  ~ is strictly forbidden unless prior written permission is obtained
  ~ from Adobe Systems Incorporated.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

<%@include file="/libs/foundation/global.jsp" %>
<%@page import="com.day.cq.analytics.testandtarget.util.MboxHelper,
                com.day.cq.wcm.api.AuthoringUIMode,
                com.day.cq.wcm.api.WCMMode,
                com.day.cq.wcm.webservicesupport.ConfigurationManager,
                org.apache.sling.commons.json.JSONArray,
                org.apache.sling.commons.json.JSONObject" %>
<%@ page import="java.util.Map" %>
<%
    // 1. Extract globally useful information
    WCMMode wcmMode = WCMMode.fromRequest(request);
    AuthoringUIMode authoringMode = AuthoringUIMode.fromRequest(request);
    String[] ambitMappings = pageProperties.getInherited("cq:target-ambits", String[].class);
    String mboxName = MboxHelper.generateLocationName(resource, wcmMode, ambitMappings);

    String mboxLocation = xssAPI.encodeForJSString(properties.get("location", resource.getPath()));
    // we can't use mboxCreate multiple times so when authoring, which can involve component refreshes
    // always use accurate rendering so we can refresh the mbox multiple times
    boolean forceAccurateRendering = WCMMode.fromRequest(request) != WCMMode.DISABLED;
    String divClass = (wcmMode == WCMMode.EDIT) ? "" : "class=\"mboxDefault\"";
    String placeholderId = xssAPI.encodeForHTMLAttr(mboxName) + "--target-placeholder";
%>

<%-- 2. include default content --%>
<div id="<%= xssAPI.encodeForHTMLAttr(mboxName)%>" <%= divClass%>>

    <%
        if (AuthoringUIMode.CLASSIC.equals(authoringMode)) {
            // CQ5-32864: avoid decorations for the targetparsys component since it leads to DOM leaks when simulating
            WCMMode.DISABLED.toRequest(request);
        }
        if (resource.getChild("default") != null) {
    %>
    <sling:include path="default"/>
    <%
        }
        wcmMode.toRequest(request);
    %>
    <% if (wcmMode != WCMMode.DISABLED) { %>
    <div id="<%= placeholderId %>" class="faded">
        <div class="target-Wait--centered target-Wait--large"></div>
    </div>
    <% } %>
</div>

<%-- 3. Prepare mbox call
     For accurate rendering mboxes use define + push so that the ClientContext parameters are taken into account
     For non-accurate rendering mboxes use plain create
 --%>
<script type="text/javascript">
    <% if (wcmMode != WCMMode.DISABLED) { %>
        var event = document.createEvent("CustomEvent"),
                target = document.getElementById("<%= xssAPI.encodeForHTMLAttr(mboxName) %>--target-placeholder");
        event.initEvent("target-placeholder-loaded", true, false);
        target.dispatchEvent(event);
    <% } %>

    var mboxId = mboxName = '<%= xssAPI.encodeForJSString(mboxName) %>';
    var mboxLocation = '<%= mboxLocation %>';
    var wcmMode = '<%= wcmMode %>';
    var includeResolvedSegments = <%= properties.get("includeResolvedSegments", false) %>;
    var accurateTargeting = <%= Boolean.valueOf(properties.get("accurateTargeting","false")) %>;

    // register the default content path in the "defaults" map
    CQ_Analytics.TestTarget.defaults[mboxName] = "<%= resource.getChild("default").getPath()%>.html";

    if (typeof mboxDefine == 'function' && wcmMode !== 'ANALYTICS') {
        var callParameters = [ mboxId ];
        var callFunction;
        var replaced = false;

        <%
            Map<String, String> staticParameterMap = MboxHelper.getStaticParameters(resource);
            JSONObject staticParameters = new JSONObject();
            for ( Map.Entry<String, String> entry : staticParameterMap.entrySet() ) {
                staticParameters.put(entry.getKey(), entry.getValue());
            }

            Map<String,String> mappedCcParameterNames = MboxHelper.getMappedClientContextParameterNames(resource, pageProperties,
                    resource.getResourceResolver().adaptTo(ConfigurationManager.class));
            StringBuilder profileParameterNames = new StringBuilder("'");
            JSONArray mappings = new JSONArray();

            for ( Map.Entry<String,String> ccParameterEntry : mappedCcParameterNames.entrySet() ) {
                profileParameterNames.append(xssAPI.encodeForJSString(ccParameterEntry.getValue())).append(",");
                mappings.put(new JSONObject().put("ccKey", ccParameterEntry.getKey()).put("param", ccParameterEntry.getValue()));
            }

            profileParameterNames.append("'");

            if ( forceAccurateRendering || MboxHelper.isAccurateRendering(resource ) ) { %>
        callParameters.push(mboxName);
        callFunction = mboxDefine;

        // add the static parameters to each mbox
        var staticParameters = <%= staticParameters.toString() %>,
            arrStaticParams = [];

        for (var key in staticParameters)
            arrStaticParams.push(key + '=' + staticParameters[key]);

        replaced = CQ_Analytics.TestTarget.addMbox({id: mboxName, name: mboxName, defined: false, staticParameters:arrStaticParams,
            mappings: <%= mappings.toString() %>, isProfile: <%= profileParameterNames.toString() %>, includeResolvedSegments: includeResolvedSegments });
        // Make sure the default div does not get cached, since it might no longer be connected to the DOM
        mboxFactories.get('default').getMboxes().get(mboxName).each(function (mbox) {
            mbox.clearDefaultDiv();
        });

        <% } else { %>
            callFunction = mboxCreate;
        <% } %>

        <%--
            4. Handle mboxDefine case specially to account for page flicker and authoring
        --%>
        if (callFunction == mboxDefine) {

            // if the campaign store is available at this time we are most likely simulating
            // so trigger an update if the (auto) campaign is selected
            if (window.ClientContext !== undefined) {
                var campaignStore = ClientContext.get("campaign");
                if (campaignStore
                        && !campaignStore.isCampaignSelected()
                        && wcmMode !== 'DISABLED') {
                    CQ_Analytics.TestTarget.triggerUpdate();
                }
            } else {
                // if we don't have CC then trigger the update directly
                CQ_Analytics.TestTarget.triggerUpdate();
            }

            // wait for 2 seconds for the T&T answer to come in to prevent page flicker issues
            // also see the overlay of mbox.protoype.setOffer which completes this
            CQ_Analytics.TestTarget.ignoreLateMboxArrival(mboxId, mboxName, 5000);
        }  else {
            var staticParameters = <%= staticParameters.toString() %>;

            for ( var key in staticParameters ) {
                callParameters.push(key  + '=' + staticParameters[key]);
            }

            callFunction.apply(undefined, callParameters);
        }
    }

    <%--
        6. Analytics mode hooks
    --%>
    <% if ( wcmMode == WCMMode.ANALYTICS ) { %>
    var mboxSelector = '#' + mboxName + '.mboxDefault';  // the selector for this mbox. mboxName is unique in DOM
    $CQ(mboxSelector).css('visibility', 'visible'); // override the mbox handling of hiding the default content
    var analyzables = $CQ(mboxSelector).closest('.cq-analyzable'); // find the closest analyzable parent wrapping the default content
    $CQ(analyzables).each(function (index, analyzable) {
        $CQ(analyzable).append(
                $CQ('<div>').attr('class', 'cq-analyzable-launch-button').attr('title', CQ.I18n.get('Show analytics data')).
                        click(function () {
                            if (window.ClientContext === undefined 
                                    || !ClientContext.get("campaign")) {
                                return;
                            }
                            var location = '<%= mboxLocation %>';
                            var overlay = new CQ.personalization.TargetAnalyticsOverlay(analyzable, location);
                            overlay.toggle(ClientContext.get("campaign/path"));
                            overlay.installCampaignStoreListener();
                        }
                )
        );
    });
    <% } %>

</script>
