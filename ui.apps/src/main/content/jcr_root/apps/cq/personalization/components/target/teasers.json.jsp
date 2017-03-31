<%--
  ADOBE CONFIDENTIAL

  Copyright 2012 Adobe Systems Incorporated
  All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and may be covered by U.S. and Foreign Patents,
  patents in process, and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.
--%>
<%@include file="/libs/foundation/global.jsp" %>
<%@page session="false" %>
<%@ page import="com.day.cq.wcm.api.Page,
                 org.apache.sling.api.resource.ValueMap,
                 org.apache.sling.commons.json.JSONObject,
                 java.util.HashMap,
                 java.util.Iterator,
                 java.util.Map,
                 java.io.Writer,
                 com.day.cq.commons.Filter,
                 org.apache.sling.api.resource.Resource" %>
<%
    ValueMap resourceProperties = resource.adaptTo(ValueMap.class);

    String path = resource.getPath();
    String location = resourceProperties.get("location", path);
    String campaign = slingRequest.getRequestPathInfo().getSuffix();
    Map<String, String> offers = new HashMap<String, String>();

    offers.put("DEFAULT", path + "/default");

    Page campaignPage = pageManager.getPage(campaign);

    Iterator<Page> expericences = campaignPage.listChildren(new Filter<Page>() {
        public boolean includes(Page page) {
            return page.getContentResource().isResourceType("cq/personalization/components/experiencepage");
        }
    });

    for (; expericences.hasNext(); ) {
        Page experience = expericences.next();

        Iterator<Page> offerPages = experience.listChildren(new Filter<Page>() {
            public boolean includes(Page page) {
                return (page.getContentResource().isResourceType("cq/personalization/components/teaserpage")
                        || page.getContentResource().isResourceType("cq/personalization/components/offerproxy"));
            }
        });

        for (; offerPages.hasNext(); ) {
            Resource res = offerPages.next().getContentResource();
            ValueMap vm = res.adaptTo(ValueMap.class);
            String offerLocation = vm.get("location", "");

            if (location.equals(offerLocation)) {
                 if (res.isResourceType("cq/personalization/components/teaserpage")) {
                    offers.put(experience.getName(), res.getParent().getPath());
                 } else {
                    // follow the proxy page property to the original offer
                    String offerPath = vm.get("offerPath", "");
                    Page originalOfferPage = pageManager.getPage(offerPath);
                    if (originalOfferPage != null) {
                        String pathString = res.getParent().getPath() + "|" + originalOfferPage.getPath();
                        offers.put(experience.getName(), pathString);
                    }
                }
            }
        }
    }

    JSONObject offersJson = new JSONObject(offers);
    Writer writer = slingResponse.getWriter();
    slingResponse.setContentType("application/json");

    writer.write(offersJson.toString());
%>