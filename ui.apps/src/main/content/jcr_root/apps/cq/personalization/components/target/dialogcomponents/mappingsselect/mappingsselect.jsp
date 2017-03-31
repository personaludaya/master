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
    --%><%
        %><%@include file="/libs/granite/ui/global.jsp" %><%
        %><%@page session="false"
                  import="java.io.IOException,
                  java.util.Arrays,
                  java.util.Iterator,
                  java.util.List,
                  com.adobe.granite.ui.components.AttrBuilder,
                  com.adobe.granite.ui.components.Config,
                  com.adobe.granite.ui.components.Field,
                  com.adobe.granite.ui.components.Tag,
                  com.adobe.granite.ui.components.Value" %><%

    /**
     * MappingsSelect is a custom component for the target dialog. It renders a simple select with no options.
     * Any set value is stored in an data attribute of the select element.
     *
     * The available options, the context hub parameters from the different stores, can only be evaluated on the
     * client side. So the clientlib for this component will extract the data , add the available options, mark the
     * the one that is selected (if any) and finally initialize a normal Coral UI Select widget for it.
     *
     * @component
     * @name MappingsSelect
     * @location libs\cq\personalization\components\target\dialogcomponents\mappingsselect
     *
     * @property {String} [id] id attr
     * @property {String} [rel] class attr (this is to indicate the semantic relationship of the component)
     * @property {String} [class] class attr
     * @property {String} [title] title attr
     * @property {String} [name] the name to be used for form submission
     * @property {String} [emptyText] The initial text to display when nothing is selected
     * @property {String} &lt;other&gt; data-&lt;other&gt; attr
     *
     * @example
     * <caption>Content Structure</caption>
     * + myselect
     *   - jcr:primaryType = "nt:unstructured"
     *   - sling:resourceType = "cq/personalization/components/target/dialogcomponents/mappingsselect"
     *   - emptyText = "Select"
     *   - name = "./cq:mappings"
     */

    String identifier = "cq-personalization-target-mappingsselect";
    Config cfg = cmp.getConfig();
    String name = cfg.get("name", String.class);
    Value val = new Value(slingRequest, cfg);
    String contentValue = val.getContentValue(name, String.class);

    Tag tag = cmp.consumeTag();
    // attribute for the root element
    AttrBuilder spanAttrs = tag.getAttrs();
    spanAttrs.add("id", cfg.get("id", String.class));

    // add identifier class
    spanAttrs.addClass(identifier);
    // store any defined value in a data attribute
        spanAttrs.add("data-" + identifier + "-value",contentValue);

    spanAttrs.addClass("coral-Select");
    spanAttrs.addRel(cfg.get("rel", String.class));
    spanAttrs.add("title", i18n.getVar(cfg.get("title", String.class)));
    spanAttrs.addOthers(cfg.getProperties(), "id", "class", "rel", "title", "name", "emptyText");

    // attributes for the button element
    AttrBuilder buttonAttrs = new AttrBuilder(request, xssAPI);
    buttonAttrs.add("type", "button");
    buttonAttrs.addClass("coral-Select-button coral-MinimalButton");

    // attributes for the select
    AttrBuilder selectAttrs = new AttrBuilder(request, xssAPI);
    // set the value as data attribute
    selectAttrs.add("name", name);
    selectAttrs.add("id","selector");
    selectAttrs.addClass("coral-Select-select");
    // standard Coral UI select structure but with no option
    %>
    <span <%= spanAttrs.build() %>>
        <button <%= buttonAttrs.build() %> >
            <span class="coral-Select-button-text"><%= i18n.getVar("Select")%></span>
        </button>
        <select <%= selectAttrs.build() %>></select>
    </span>

