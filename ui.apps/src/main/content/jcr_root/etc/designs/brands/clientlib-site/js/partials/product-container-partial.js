function pug_attr(t,e,n,f){return e!==!1&&null!=e&&(e||"class"!==t&&"style"!==t)?e===!0?" "+(f?t:t+'="'+t+'"'):("function"==typeof e.toJSON&&(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||e.indexOf('"')===-1)?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"):""}
function pug_classes(s,r){return Array.isArray(s)?pug_classes_array(s,r):s&&"object"==typeof s?pug_classes_object(s):s||""}
function pug_classes_array(r,a){for(var s,e="",u="",c=Array.isArray(a),g=0;g<r.length;g++)s=pug_classes(r[g]),s&&(c&&a[g]&&(s=pug_escape(s)),e=e+u+s,u=" ");return e}
function pug_classes_object(r){var a="",n="";for(var o in r)o&&r[o]&&pug_has_own_property.call(r,o)&&(a=a+n+o,n=" ");return a}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_has_own_property=Object.prototype.hasOwnProperty;
var pug_match_html=/["&<>]/;function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;;var locals_for_with = (locals || {});(function (categoryid, eccategoryid, hide_all_label, selectedLifeStages, tileList, title, view_all_label) {pug_html = pug_html + "\u003C!-- product-container-partial start here--\u003E\u003Cdiv class=\"product-container\"\u003E\u003Cdiv class=\"container-fluid\"\u003E\u003Cdiv class=\"row\"\u003E\u003Cdiv class=\"col-lg-12 col-md-12 col-sm-12 col-xs-12\"\u003E\u003Ch3" + (" class=\"title\""+pug_attr("id", categoryid, true, false)) + "\u003E" + (pug_escape(null == (pug_interp = title) ? "" : pug_interp)) + "\u003C\u002Fh3\u003E\u003C!--div.view-all-wrapper.text-right.hidden-lg.hidden-md.hidden-sm rb_dev this is the original arrow down--\u003E\u003C!--  a.view-all View all--\u003E\u003C!--    svg.brands-icon.link-icon-small.icon-expand.hidden-lg.hidden-md.hidden-sm--\u003E\u003C!--      use(href=(tile? tile : arrowDown) xlink:href=(tile? tile : arrowDown))--\u003E\u003C!--    svg.brands-icon.link-icon-small.icon-collapse.hide.hidden-lg.hidden-md.hidden-sm--\u003E\u003C!--      use(href=(tile? tile : arrowUp) xlink:href=(tile? tile : arrowUp))--\u003E\u003C\u002Fdiv\u003E\u003Cdiv class=\"col-lg-12 col-md-12 col-sm-12 col-xs-12\"\u003E\u003Cdiv class=\"row product-row-wrapper\"\u003E";
// iterate tileList
;(function(){
  var $$obj = tileList;
  if ('number' == typeof $$obj.length) {
      for (var pug_index0 = 0, $$l = $$obj.length; pug_index0 < $$l; pug_index0++) {
        var tile = $$obj[pug_index0];
if (tile.type == 'product') {
pug_html = pug_html + "\u003Cdiv class=\"col-lg-4 col-md-4 col-sm-6 col-xs-12 product-col-wrapper hidden-xs\"\u003E\u003Cdiv class=\"product-info-overview\"\u003E\u003Ca" + (pug_attr("href", tile.url, true, false)) + "\u003E\u003Cimg" + (" class=\"img-responsive\""+pug_attr("src", (tile? tile.image: '/clientlib-site/images/product/tangwei-box.jpg'), true, false)+pug_attr("alt", "" + tile.title + "", true, false)+pug_attr("title", "" + tile.title + "", true, false)) + "\u002F\u003E\u003C\u002Fa\u003E\u003Cdiv class=\"checkbox checkbox-primary\"\u003E\u003Cinput" + (" type=\"checkbox\""+pug_attr("data-analytics", '{"product":{"productInfo":{"productName":"'+ tile.productid +'","productID":"'+tile.ecproductid +'"},"category":{"primaryCategory": "'+ categoryid +'","primaryCategoryID":"'+ eccategoryid +'"}},"event":{"eventInfo":{"eventType":"product_selectcomparison","eventName":"'+ tile.title +'"}}}', true, false)+pug_attr("data-product-unique-id", tile.productid, true, false)+pug_attr("data-ecproduct-unique-id", tile.ecproductid, true, false)+pug_attr("data-category-unique-id", categoryid, true, false)+pug_attr("data-eccategory-unique-id", eccategoryid, true, false)+pug_attr("data-category-title", title, true, false)) + "\u002F\u003E\u003Clabel\u003ECompare\u003C\u002Flabel\u003E\u003C\u002Fdiv\u003E\u003Ca" + (pug_attr("href", tile.url, true, false)) + "\u003E\u003Ch4 class=\"text-left\"\u003E" + (null == (pug_interp = tile.title) ? "" : pug_interp) + "\u003C\u002Fh4\u003E\u003C\u002Fa\u003E\u003Cdiv class=\"product-info-overview-detail\"\u003E\u003Cul class=\"product-benefits\"\u003E";
if (tile && tile.needs) {
// iterate tile.needs
;(function(){
  var $$obj = tile.needs;
  if ('number' == typeof $$obj.length) {
      for (var pug_index1 = 0, $$l = $$obj.length; pug_index1 < $$l; pug_index1++) {
        var need = $$obj[pug_index1];
pug_html = pug_html + "\u003Cli" + (pug_attr("class", pug_classes([(selectedLifeStages && selectedLifeStages.indexOf(need.lifestageid) > -1)? 'selected-life-stage': ''], [true]), false, false)+pug_attr("data-id", "" + need.lifestageid, true, false)) + "\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", need.icon, true, false)+pug_attr("xlink:href", need.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E" + (pug_escape(null == (pug_interp = need.name) ? "" : pug_interp)) + "\u003C\u002Fli\u003E";
      }
  } else {
    var $$l = 0;
    for (var pug_index1 in $$obj) {
      $$l++;
      var need = $$obj[pug_index1];
pug_html = pug_html + "\u003Cli" + (pug_attr("class", pug_classes([(selectedLifeStages && selectedLifeStages.indexOf(need.lifestageid) > -1)? 'selected-life-stage': ''], [true]), false, false)+pug_attr("data-id", "" + need.lifestageid, true, false)) + "\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", need.icon, true, false)+pug_attr("xlink:href", need.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E" + (pug_escape(null == (pug_interp = need.name) ? "" : pug_interp)) + "\u003C\u002Fli\u003E";
    }
  }
}).call(this);

}
else
if (!tile) {
pug_html = pug_html + "\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003EEnergy & Stamina\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E";
}
pug_html = pug_html + "\u003C\u002Ful\u003E\u003Cul class=\"product-info-detail\"\u003E\u003Cli\u003E\u003Ca" + (" class=\"btn btn-action btn-lg\""+pug_attr("data-analytics", tile['data-analytics'], true, false)+pug_attr("href", tile.ecproducturl, true, false)+" target=\"_blank\"") + "\u003Ebuy now\u003C\u002Fa\u003E\u003C\u002Fli\u003E\u003C\u002Ful\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
}
else
if (tile.type == 'ads') {
pug_html = pug_html + "\u003Cdiv class=\"col-lg-4 col-md-4 col-sm-6 col-xs-12 product-col-wrapper hidden-xs\"\u003E\u003Cdiv class=\"section-container ads-box free-home-delivery\"\u003E\u003Cdiv class=\"background-container gradient-background\"\u003E\u003Cdiv class=\"ads-content\"\u003E";
if (tile.icon) {
pug_html = pug_html + "\u003Csvg class=\"brands-icon icon-white icon-free-home-delivery icon-center\"\u003E\u003Cuse" + (pug_attr("href", tile.icon, true, false)+pug_attr("xlink:href", tile.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E";
}
pug_html = pug_html + ("\u003Cdiv class=\"content\"\u003E\u003Ch3 class=\"secondary-color\"\u003E" + (null == (pug_interp = tile.title) ? "" : pug_interp) + "\u003C\u002Fh3\u003E\u003Cp\u003E" + (null == (pug_interp = tile.content) ? "" : pug_interp) + "\u003C\u002Fp\u003E\u003Ca" + (" class=\"btn btn-action\""+" target=\"_blank\""+pug_attr("href", tile.cta.button.url, true, false)+pug_attr("data-analytics", tile.cta.button['data-analytics'], true, false)) + "\u003E" + (null == (pug_interp = tile.cta.button.text) ? "" : pug_interp) + "\u003C\u002Fa\u003E\u003Cdiv class=\"view-all-wrapper\"\u003E\u003Ca" + (" class=\"view-all\""+pug_attr("href", tile.cta.link.url, true, false)+pug_attr("data-analytics", tile.cta.link['data-analytics'], true, false)) + "\u003E" + (null == (pug_interp = tile.cta.link.text) ? "" : pug_interp));
if (tile.cta.link.icon) {
pug_html = pug_html + "\u003Csvg class=\"brands-icon icon-white link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", tile.cta.link.icon, true, false)+pug_attr("xlink:href", tile.cta.link.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E";
}
pug_html = pug_html + "\u003C\u002Fa\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
}
      }
  } else {
    var $$l = 0;
    for (var pug_index0 in $$obj) {
      $$l++;
      var tile = $$obj[pug_index0];
if (tile.type == 'product') {
pug_html = pug_html + "\u003Cdiv class=\"col-lg-4 col-md-4 col-sm-6 col-xs-12 product-col-wrapper hidden-xs\"\u003E\u003Cdiv class=\"product-info-overview\"\u003E\u003Ca" + (pug_attr("href", tile.url, true, false)) + "\u003E\u003Cimg" + (" class=\"img-responsive\""+pug_attr("src", (tile? tile.image: '/clientlib-site/images/product/tangwei-box.jpg'), true, false)+pug_attr("alt", "" + tile.title + "", true, false)+pug_attr("title", "" + tile.title + "", true, false)) + "\u002F\u003E\u003C\u002Fa\u003E\u003Cdiv class=\"checkbox checkbox-primary\"\u003E\u003Cinput" + (" type=\"checkbox\""+pug_attr("data-analytics", '{"product":{"productInfo":{"productName":"'+ tile.productid +'","productID":"'+tile.ecproductid +'"},"category":{"primaryCategory": "'+ categoryid +'","primaryCategoryID":"'+ eccategoryid +'"}},"event":{"eventInfo":{"eventType":"product_selectcomparison","eventName":"'+ tile.title +'"}}}', true, false)+pug_attr("data-product-unique-id", tile.productid, true, false)+pug_attr("data-ecproduct-unique-id", tile.ecproductid, true, false)+pug_attr("data-category-unique-id", categoryid, true, false)+pug_attr("data-eccategory-unique-id", eccategoryid, true, false)+pug_attr("data-category-title", title, true, false)) + "\u002F\u003E\u003Clabel\u003ECompare\u003C\u002Flabel\u003E\u003C\u002Fdiv\u003E\u003Ca" + (pug_attr("href", tile.url, true, false)) + "\u003E\u003Ch4 class=\"text-left\"\u003E" + (null == (pug_interp = tile.title) ? "" : pug_interp) + "\u003C\u002Fh4\u003E\u003C\u002Fa\u003E\u003Cdiv class=\"product-info-overview-detail\"\u003E\u003Cul class=\"product-benefits\"\u003E";
if (tile && tile.needs) {
// iterate tile.needs
;(function(){
  var $$obj = tile.needs;
  if ('number' == typeof $$obj.length) {
      for (var pug_index2 = 0, $$l = $$obj.length; pug_index2 < $$l; pug_index2++) {
        var need = $$obj[pug_index2];
pug_html = pug_html + "\u003Cli" + (pug_attr("class", pug_classes([(selectedLifeStages && selectedLifeStages.indexOf(need.lifestageid) > -1)? 'selected-life-stage': ''], [true]), false, false)+pug_attr("data-id", "" + need.lifestageid, true, false)) + "\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", need.icon, true, false)+pug_attr("xlink:href", need.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E" + (pug_escape(null == (pug_interp = need.name) ? "" : pug_interp)) + "\u003C\u002Fli\u003E";
      }
  } else {
    var $$l = 0;
    for (var pug_index2 in $$obj) {
      $$l++;
      var need = $$obj[pug_index2];
pug_html = pug_html + "\u003Cli" + (pug_attr("class", pug_classes([(selectedLifeStages && selectedLifeStages.indexOf(need.lifestageid) > -1)? 'selected-life-stage': ''], [true]), false, false)+pug_attr("data-id", "" + need.lifestageid, true, false)) + "\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", need.icon, true, false)+pug_attr("xlink:href", need.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E" + (pug_escape(null == (pug_interp = need.name) ? "" : pug_interp)) + "\u003C\u002Fli\u003E";
    }
  }
}).call(this);

}
else
if (!tile) {
pug_html = pug_html + "\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003EEnergy & Stamina\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E\u003Cli\u003E\u003Csvg class=\"brands-icon pull-left link-icon-small\"\u003E\u003Cuse href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\" xlink:href=\"\u002Fclientlib-site\u002Fimages\u002Ficons\u002Fsymbol-defs.svg#icon-brain\"\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003ESkins & Complexion\u003C\u002Fli\u003E";
}
pug_html = pug_html + "\u003C\u002Ful\u003E\u003Cul class=\"product-info-detail\"\u003E\u003Cli\u003E\u003Ca" + (" class=\"btn btn-action btn-lg\""+pug_attr("data-analytics", tile['data-analytics'], true, false)+pug_attr("href", tile.ecproducturl, true, false)+" target=\"_blank\"") + "\u003Ebuy now\u003C\u002Fa\u003E\u003C\u002Fli\u003E\u003C\u002Ful\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
}
else
if (tile.type == 'ads') {
pug_html = pug_html + "\u003Cdiv class=\"col-lg-4 col-md-4 col-sm-6 col-xs-12 product-col-wrapper hidden-xs\"\u003E\u003Cdiv class=\"section-container ads-box free-home-delivery\"\u003E\u003Cdiv class=\"background-container gradient-background\"\u003E\u003Cdiv class=\"ads-content\"\u003E";
if (tile.icon) {
pug_html = pug_html + "\u003Csvg class=\"brands-icon icon-white icon-free-home-delivery icon-center\"\u003E\u003Cuse" + (pug_attr("href", tile.icon, true, false)+pug_attr("xlink:href", tile.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E";
}
pug_html = pug_html + ("\u003Cdiv class=\"content\"\u003E\u003Ch3 class=\"secondary-color\"\u003E" + (null == (pug_interp = tile.title) ? "" : pug_interp) + "\u003C\u002Fh3\u003E\u003Cp\u003E" + (null == (pug_interp = tile.content) ? "" : pug_interp) + "\u003C\u002Fp\u003E\u003Ca" + (" class=\"btn btn-action\""+" target=\"_blank\""+pug_attr("href", tile.cta.button.url, true, false)+pug_attr("data-analytics", tile.cta.button['data-analytics'], true, false)) + "\u003E" + (null == (pug_interp = tile.cta.button.text) ? "" : pug_interp) + "\u003C\u002Fa\u003E\u003Cdiv class=\"view-all-wrapper\"\u003E\u003Ca" + (" class=\"view-all\""+pug_attr("href", tile.cta.link.url, true, false)+pug_attr("data-analytics", tile.cta.link['data-analytics'], true, false)) + "\u003E" + (null == (pug_interp = tile.cta.link.text) ? "" : pug_interp));
if (tile.cta.link.icon) {
pug_html = pug_html + "\u003Csvg class=\"brands-icon icon-white link-icon-small\"\u003E\u003Cuse" + (pug_attr("href", tile.cta.link.icon, true, false)+pug_attr("xlink:href", tile.cta.link.icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E";
}
pug_html = pug_html + "\u003C\u002Fa\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
}
    }
  }
}).call(this);

pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003Cdiv class=\"col-xs-12\"\u003E\u003Cdiv class=\"view-all-wrapper text-center hidden-lg hidden-md hidden-sm\"\u003E\u003Ca" + (" class=\"view-all\""+pug_attr("data-view-all-text", (view_all_label || 'View all'), true, false)+pug_attr("data-hide-all-text", (hide_all_label || 'Hide all'), true, false)) + "\u003E" + (pug_escape(null == (pug_interp = (view_all_label || 'View all')) ? "" : pug_interp)) + "\u003Cspan\u003E\u003C\u002Fspan\u003E\u003C\u002Fa\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C!-- product-container-partial end here--\u003E";}.call(this,"categoryid" in locals_for_with?locals_for_with.categoryid:typeof categoryid!=="undefined"?categoryid:undefined,"eccategoryid" in locals_for_with?locals_for_with.eccategoryid:typeof eccategoryid!=="undefined"?eccategoryid:undefined,"hide_all_label" in locals_for_with?locals_for_with.hide_all_label:typeof hide_all_label!=="undefined"?hide_all_label:undefined,"selectedLifeStages" in locals_for_with?locals_for_with.selectedLifeStages:typeof selectedLifeStages!=="undefined"?selectedLifeStages:undefined,"tileList" in locals_for_with?locals_for_with.tileList:typeof tileList!=="undefined"?tileList:undefined,"title" in locals_for_with?locals_for_with.title:typeof title!=="undefined"?title:undefined,"view_all_label" in locals_for_with?locals_for_with.view_all_label:typeof view_all_label!=="undefined"?view_all_label:undefined));;return pug_html;}