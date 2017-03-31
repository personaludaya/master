    <%--
      ADOBE CONFIDENTIAL

      Copyright 2013 Adobe Systems Incorporated
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
    --%><%@page session="false"
                import="java.util.ArrayList,
                  java.util.Iterator,
                  java.util.HashMap,
                  java.util.Map,
                  org.apache.sling.api.wrappers.ValueMapDecorator,
                  com.day.cq.wcm.api.components.Component,
                  com.adobe.granite.ui.components.Config,
                  org.apache.sling.api.resource.ResourceUtil,
                  com.adobe.granite.ui.components.ds.DataSource,
                  com.adobe.granite.ui.components.ds.EmptyDataSource,
                  com.adobe.granite.ui.components.ds.SimpleDataSource,
                  com.adobe.granite.ui.components.ds.ValueMapResource,
				  org.apache.sling.api.resource.ResourceMetadata,
				  org.apache.sling.api.resource.SyntheticResource" %><%
        %><%@include file="/libs/foundation/global.jsp"%><%
    // contains final list of synthetic resources
    final ArrayList<Resource> resourceList = new ArrayList<Resource>();

    final String paths[] = resourceResolver.getSearchPath();
    final String libPath = "cq/personalization/clientlib/kernel/source/strategies/list";
    final String legacyLibPath = "cq/personalization/clientlib/source/strategies/list";
    final Map<String, String> entries = new HashMap<String, String>();
    for (final String path : paths) {
        Resource dir = resourceResolver.getResource(path + libPath);
        if (dir != null) {
            processScripts(path, dir, entries);
        }
        dir = resourceResolver.getResource(path + legacyLibPath);
        if (dir != null) {
            processScripts(path, dir, entries);
        }
    }

for(final Map.Entry<String, String> entry : entries.entrySet()) {
        // create a ValueMap
        HashMap map = new HashMap();
        map.put("text",entry.getValue());
        map.put("value",entry.getKey());

        // create a synthetic resource
        ValueMapResource valMapResource = new ValueMapResource(resourceResolver,new ResourceMetadata(),"",
            new ValueMapDecorator(map));

        // add resource to list
        resourceList.add(valMapResource);
    }

    DataSource ds;

    // if no matching nodes where found
    if (resourceList.size() == 0){
        // return empty datasource
        ds = EmptyDataSource.instance();
    } else {
        // create a new datasource object
        ds = new SimpleDataSource(resourceList.iterator());
    }

    // place it in request for consumption by datasource mechanism
    request.setAttribute(DataSource.class.getName(), ds);
%><%!

	private static void processScripts(String basePath, Resource dir, Map<String, String> entries) {
        final Iterator<Resource> i = dir.listChildren();
        while (i.hasNext()) {
            final Resource script = i.next();
            final ValueMap vm = ResourceUtil.getValueMap(script);

            // First, strip the path back to just the libPath:
            String key = script.getPath().substring(basePath.length());
            // Then convert to a pre-5.6-path (before clientlibs were separated into kernel and ui):
            key = key.replace("clientlib/kernel/source", "clientlib/source");

            final boolean enabled = vm.get("enabled", true);
            if (entries.containsKey(key)) {
                if (!enabled) {
                    entries.remove(key);
                }
            } else {
                if (enabled) {
                    entries.put(key, vm.get("jcr:title", script.getName()));
                }
            }
        }
    }
%>