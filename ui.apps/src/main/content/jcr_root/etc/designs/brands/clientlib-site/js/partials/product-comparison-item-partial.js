function pug_attr(t,e,n,f){return e!==!1&&null!=e&&(e||"class"!==t&&"style"!==t)?e===!0?" "+(f?t:t+'="'+t+'"'):("function"==typeof e.toJSON&&(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||e.indexOf('"')===-1)?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"):""}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_match_html=/["&<>]/;function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;;var locals_for_with = (locals || {});(function (icon, id, img, title) {pug_html = pug_html + "\u003Cdiv class=\"col-lg-3 col-md-3\"\u003E\u003Cdiv class=\"product-comparison-item\"\u003E\u003Csvg" + (" class=\"brands-icon link-icon-small icon-white\""+pug_attr("data-selected-id", id? id: '', true, false)) + "\u003E\u003Cuse" + (pug_attr("href", icon, true, false)+" xmlns:xlink=\"http:\u002F\u002Fwww.w3.org\u002F1999\u002Fxlink\""+pug_attr("xlink:href", icon, true, false)) + "\u003E\u003C\u002Fuse\u003E\u003C\u002Fsvg\u003E\u003Cimg" + (" class=\"img-responsive\""+pug_attr("src", img? img : "/clientlib-site/images/product/product-sample1.png", true, false)+" alt=\"alt\" title=\"title\"") + "\u002F\u003E\u003Cp\u003E" + (null == (pug_interp = title? title : 'Essence of Chicken Original') ? "" : pug_interp) + "\u003C\u002Fp\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";}.call(this,"icon" in locals_for_with?locals_for_with.icon:typeof icon!=="undefined"?icon:undefined,"id" in locals_for_with?locals_for_with.id:typeof id!=="undefined"?id:undefined,"img" in locals_for_with?locals_for_with.img:typeof img!=="undefined"?img:undefined,"title" in locals_for_with?locals_for_with.title:typeof title!=="undefined"?title:undefined));;return pug_html;}