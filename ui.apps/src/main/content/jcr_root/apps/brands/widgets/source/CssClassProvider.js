/*
 * Used by Product Page
 * Prevent serving cached response
 * Gets card type where JSON is rendered
 */
jQuery.ajaxSetup({
    // Disable caching of AJAX responses 
    cache: false
});

//AJAX calls for dialog selection list
CQ.utils.Css = function() {
    return {
    	getHeaderStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/header-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }

	        return [];
	    },getIconList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/icon-svg.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getDataSpeedList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/data-speed.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
 				sortJSONObj(opts, "text", "string", true);
	            return opts;

	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }

	        return [];
	    },getBgList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/mice/csslist/BgList.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPageIconList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/mice/csslist/CategoryIconList.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getCtaTextList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/cta-text.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getBackgroundColorList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/background-color.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPageBackgroundImageList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/page-background-image.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getBackgroundStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/background-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getImageStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/image-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPageBackgroundStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/page-background-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getSectionContainerStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/section-container-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getCtaStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/cta-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getIconStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/icon-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPrdtPriceCurrencyList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/prdt-price-currency.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPrdtPriceTitleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/prdt-price-title.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    },getPrdtImageStyleList : function(contentPath) {
	        try{	        	
	            var opts = [];
	            var url = CQ.HTTP.noCaching("/etc/designs/brands/css-json/prdt-image-style.json");
	            
	            var jsonOb = CQ.HTTP.eval(url);

	            for (var a = 0; a < jsonOb.length; a++) {
	                opts.push({
	                    //value: jsonOb[a].value,
	                	//text is for showing at dialog
	                    text: jsonOb[a].text,
	                    //value is for grabbing in codes
	                    value: jsonOb[a].value
	                });
	            }
	            sortJSONObj(opts, "text", "string", true);
	            opts.unshift({text: "", value: "none"});
	            return opts;
	
	        }catch (e) {
	             CQ.Log.error("... failed: " + e.message);
	        }
	
	        return [];
	    }
	    
    };
}();

var sortJSONObj = function (obj, prop, propType, asc) {
  switch (propType) {
    case "int":
      obj = obj.sort(function (a, b) {
        if (asc) {
          return (parseInt(a[prop]) > parseInt(b[prop])) ? 1 : ((parseInt(a[prop]) < parseInt(b[prop])) ? -1 : 0);
        } else {
          return (parseInt(b[prop]) > parseInt(a[prop])) ? 1 : ((parseInt(b[prop]) < parseInt(a[prop])) ? -1 : 0);
        }
      });
      break;
    default:
      obj = obj.sort(function (a, b) {
        if (asc) {
          return (a[prop].toLowerCase() > b[prop].toLowerCase()) ? 1 : ((a[prop].toLowerCase() < b[prop].toLowerCase()) ? -1 : 0);
        } else {
          return (b[prop].toLowerCase() > a[prop].toLowerCase()) ? 1 : ((b[prop].toLowerCase() < a[prop].toLowerCase()) ? -1 : 0);
        }
      });
  }
};
