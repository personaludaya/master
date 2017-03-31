function pug_attr(t,e,n,f){return e!==!1&&null!=e&&(e||"class"!==t&&"style"!==t)?e===!0?" "+(f?t:t+'="'+t+'"'):("function"==typeof e.toJSON&&(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||e.indexOf('"')===-1)?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"):""}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_match_html=/["&<>]/;function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;;var locals_for_with = (locals || {});(function (General, arrowDown, arrowUp, faqList, header) {pug_html = pug_html + "\u003C!-- faq-container-partial start here--\u003E\u003Ch2\u003E" + (null == (pug_interp = header || General) ? "" : pug_interp) + "\u003C\u002Fh2\u003E\u003Cdiv class=\"faq-accordion\" id=\"faqaccordion\"\u003E\u003Cdiv class=\"content is-open\"\u003E\u003Cdiv class=\"faq\"\u003E\u003Cul class=\"accordion-component\" id=\"faq\"\u003E";
// iterate faqList
;(function(){
  var $$obj = faqList;
  if ('number' == typeof $$obj.length) {
      for (var pug_index0 = 0, $$l = $$obj.length; pug_index0 < $$l; pug_index0++) {
        var item = $$obj[pug_index0];
pug_html = pug_html + "\u003Cli class=\"accordion-wrapper\"\u003E\u003Ca class=\"collapsable\"\u003E" + (null == (pug_interp = item.title) ? "" : pug_interp) + "\u003C\u002Fa\u003E\u003Csvg class=\"brands-icon link-icon-small icon-expand\"\u003E\u003Cuse" + (pug_attr("href", arrowDown, true, false)+pug_attr("xlink:href", arrowDown, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E\u003Csvg class=\"brands-icon link-icon-small icon-collapse hide\"\u003E\u003Cuse" + (pug_attr("href", arrowUp, true, false)+pug_attr("xlink:href", arrowUp, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E\u003Cdiv class=\"content\"\u003E" + (null == (pug_interp = item.content) ? "" : pug_interp) + "\u003C\u002Fdiv\u003E\u003C\u002Fli\u003E";
      }
  } else {
    var $$l = 0;
    for (var pug_index0 in $$obj) {
      $$l++;
      var item = $$obj[pug_index0];
pug_html = pug_html + "\u003Cli class=\"accordion-wrapper\"\u003E\u003Ca class=\"collapsable\"\u003E" + (null == (pug_interp = item.title) ? "" : pug_interp) + "\u003C\u002Fa\u003E\u003Csvg class=\"brands-icon link-icon-small icon-expand\"\u003E\u003Cuse" + (pug_attr("href", arrowDown, true, false)+pug_attr("xlink:href", arrowDown, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E\u003Csvg class=\"brands-icon link-icon-small icon-collapse hide\"\u003E\u003Cuse" + (pug_attr("href", arrowUp, true, false)+pug_attr("xlink:href", arrowUp, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E\u003Cdiv class=\"content\"\u003E" + (null == (pug_interp = item.content) ? "" : pug_interp) + "\u003C\u002Fdiv\u003E\u003C\u002Fli\u003E";
    }
  }
}).call(this);

pug_html = pug_html + "\u003C\u002Ful\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C!-- faq-container-partial end here--\u003E";}.call(this,"General" in locals_for_with?locals_for_with.General:typeof General!=="undefined"?General:undefined,"arrowDown" in locals_for_with?locals_for_with.arrowDown:typeof arrowDown!=="undefined"?arrowDown:undefined,"arrowUp" in locals_for_with?locals_for_with.arrowUp:typeof arrowUp!=="undefined"?arrowUp:undefined,"faqList" in locals_for_with?locals_for_with.faqList:typeof faqList!=="undefined"?faqList:undefined,"header" in locals_for_with?locals_for_with.header:typeof header!=="undefined"?header:undefined));;return pug_html;}