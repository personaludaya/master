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
    --%><%
        %><%@include file="/libs/granite/ui/global.jsp" %><%
        %><%@page session="false"
                  import="com.adobe.granite.ui.components.AttrBuilder,
                  com.adobe.granite.ui.components.Config,
                  com.adobe.granite.ui.components.Field,
                  com.adobe.granite.ui.components.Tag,
                  com.adobe.granite.ui.components.Value,
                  org.json.JSONArray" %><%
   /**
     * StaticParamInput is a custom component for the target dialog. It renders two input fields, one to enter
     * a variable name, the second to define the variables value.
     *
     * The name/value pair must be stored as a single string value containing a valid JSON array:
     *
     * ["<name>","<value>"]
     *
     * to stay backward compatible. so a hidden field is added that contains the concatenated value and is updated
     * whenever one of the input fields changes.

     * @component
     * @name StaticParamInput
     * @location libs\cq\personalization\components\target\dialogcomponents\staticparaminput
     *
     * @property {String} [id] id attr
     * @property {String} [rel] class attr (this is to indicate the semantic relationship of the component)
     * @property {String} [class] class attr
     * @property {String} [title] title attr
     * @property {String} [name] the name to be used for form submission
     * @property {String} &lt;other&gt; data-&lt;other&gt; attr
     *
     * @example
     * <caption>Content Structure</caption>
     * + staticparams
     *   - jcr:primaryType = "nt:unstructured"
     *   - sling:resourceType = "cq/personalization/components/target/dialogcomponents/staticparaminput"
     *   - name = "./staticParams"
     */

    String identifier = "cq-personalization-target-staticparaminput";
    Config cfg = cmp.getConfig();
    String name = cfg.get("name", String.class);
    JSONArray array = null;

    // get the value, turn it into a JSON array
    Value val = new Value(slingRequest, cfg);
    String contentValue = val.getContentValue(name, String.class);
    if (contentValue != null && contentValue != ""){
        array = new JSONArray(contentValue);
    }

    // build the attributes
    Tag tag = cmp.consumeTag();
    // for the sourrounding div
    AttrBuilder attrs = tag.getAttrs();
    attrs.add("id", cfg.get("id", String.class));
    attrs.addClass("field " + identifier);
    attrs.addClass(cfg.get("class", String.class));
    attrs.addRel(cfg.get("rel", String.class));
    attrs.add("title", i18n.getVar(cfg.get("title", String.class)));
    attrs.addOthers(cfg.getProperties(), "id", "class", "rel", "title", "name");


    // for the name input field
    AttrBuilder nameInputAttrs = new AttrBuilder(request, xssAPI);
    nameInputAttrs.add("placeholder", i18n.getVar("Variable"));
    nameInputAttrs.add("type","text");
    nameInputAttrs.addClass(identifier + "-nameinput");
    nameInputAttrs.addClass("coral-Textfield");
    if (array != null){
        nameInputAttrs.add("value",(String) array.get(0));
    }

    // for the value input field
    AttrBuilder valueInputAttrs = new AttrBuilder(request, xssAPI);
    valueInputAttrs.add("placeholder", i18n.getVar("Value"));
    valueInputAttrs.add("type","text");
    valueInputAttrs.addClass(identifier + "-valueinput");
    valueInputAttrs.addClass("coral-Textfield");
    if (array != null){
        valueInputAttrs.add("value",(String) array.get(1));
    }

    // for the hidden file
    AttrBuilder hiddenInputAttrs = new AttrBuilder(request, xssAPI);
    hiddenInputAttrs.add("name", name);
    hiddenInputAttrs.add("type","hidden");
    hiddenInputAttrs.addClass(identifier + "-hiddeninput");
    if (array != null){
        hiddenInputAttrs.add("value", contentValue);
    } else {
        // make sure initially empty start with emtpy JSON array
        hiddenInputAttrs.add("disabled",true);
    }

    %><div <%= attrs.build() %>>
         <input <%= nameInputAttrs.build() %> />
         <input <%= valueInputAttrs.build() %> />
         <input <%= hiddenInputAttrs.build() %> />
      </div>