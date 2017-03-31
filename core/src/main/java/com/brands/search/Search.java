package com.brands.search;

import com.brands.core.utils.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.Value;
import javax.jcr.query.Query;
import javax.jcr.query.RowIterator;

import org.apache.jackrabbit.commons.query.GQL;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.Resource;

import com.day.cq.commons.jcr.JcrConstants;
import com.day.cq.dam.api.DamConstants;
import com.day.cq.search.Predicate;
import com.day.cq.search.SimpleSearch;
import com.day.cq.search.Trends;
import com.day.cq.search.facets.Facet;
import com.day.cq.search.result.ResultPage;
import com.day.cq.search.result.SearchResult;
import com.day.cq.wcm.api.NameConstants;
import com.day.cq.wcm.api.components.Component;
import com.day.cq.wcm.commons.WCMUtils;

/**
 * The <code>Search</code> class implements the search logic used in the
 * foundation search component and exposes the query result in a scripting
 * friendly object structure.
 * <p/>
 * This class does a fulltext query, which means wildcards like '*' and '?' will
 * be filtered out. Please use {@link QueryBuilder} or execute a query directly
 * on the JCR Session if wildcard support is needed.
 */
public final class Search {
	
	private static final Logger LOG = LoggerFactory.getLogger(Search.class);
    /**
     * The name for the query parameter.
     */
    private static final String QUERY_PARAM_NAME = "q";

    /**
     * The name for the start parameter.
     */
    private static final String START_PARAM_NAME = "start";

    /**
     * The name for the language facet parameter.
     */
    private static final String LANGUAGE_FACET_PARAM_NAME = "language";

    /**
     * The name for the tag facet parameter.
     */
    private static final String TAG_FACET_PARAM_NAME = "tag";

    /**
     * The name for the mime type facet parameter.
     */
    private static final String MIME_TYPE_FACET_PARAM_NAME = "mimeType";

    /**
     * The name for the last modified facet parameter, which specifies the
     * lower bound of the date range.
     */
    private static final String FROM_FACET_PARAM_NAME = "from";

    /**
     * The name for the last modified facet parameter, which specifies the
     * upper bound of the date range.
     */
    private static final String TO_FACET_PARAM_NAME = "to";

    /**
     * HTML extension.
     */
    private static final String HTML_EXT = "html";

    /**
     * The query template to check the spelling of a fulltext query statement.
     */
    private static final String SPELLCHECK_QUERY = "/jcr:root[rep:spellcheck('${query}')]/(rep:spellcheck())";

    /**
     * The current request.
     */
    private final SlingHttpServletRequest request;

    /**
     * The underlying search instance.
     */
    private final SimpleSearch search;

    /**
     * The current resource.
     */
    private final Resource resource;

    /**
     * The query result. Initially <code>null</code>.
     */
    private Result result;

    /**
     * The result pages.
     */
    private List<Page> resultPages;

    /**
     * The raw query as read from the request or manually set.
     */
    private String query;

    /**
     * Set to <code>true</code> if there was a tag predicate set in the request.
     */
    private boolean tagPredicateSet;

    /**
     * The name for the sortby parameter.
     */
    private static final String SORTBY_PARAM_NAME = "sortby";
    
    /**
     * The name for the showall parameter.
     */
    private static final String SHOWALL_PARAM_NAME = "showall";
    
    /**
     * The value for Predicate.ORDER_BY either score or lastModified.
     */
    private int orderByPredicate;

    /**
     * The value for paths to search in.
     */
    private String[] searchInPaths;
    
    /**
     * Creates a new search based on the given <code>request</code>.
     *
     * @param request the current request.
     */
    public Search(SlingHttpServletRequest request) {
        this.request = request;
        this.resource = request.getResource();
        this.search = resource.adaptTo(SimpleSearch.class);
        this.orderByPredicate = 0;
        this.searchInPaths = null;
    	this.doSearch();
    }
    
    /**
     * Creates a new search based on the given <code>request</code>.
     *
     * @param request the current request.
     * @param searchInPaths string array of paths to search in.
     */
    public Search(SlingHttpServletRequest request, String[] searchInPaths) {
        this.request = request;
        this.resource = request.getResource();
        this.search = resource.adaptTo(SimpleSearch.class);
        this.orderByPredicate = 0;
        this.searchInPaths = searchInPaths;
    	this.doSearch();
    }
    
    /**
     * 
     */
    private void doSearch() { 
        if (request.getParameter(QUERY_PARAM_NAME) != null) {
            try {
                //setQuery(new String(request.getParameter(QUERY_PARAM_NAME).getBytes("ISO-8859-1"), "UTF-8"));
                String qValue = new String(URLDecoder.decode(new String(request.getParameter(QUERY_PARAM_NAME).getBytes("ISO-8859-1"), "UTF-8"), "UTF-8"));
                setQuery(qValue);
            } catch (UnsupportedEncodingException e) {
                // ignore
            	LOG.error(e.getMessage());
            }
        }
        if (request.getParameter(START_PARAM_NAME) != null) {
            try {
                this.search.setStart(Long.parseLong(request.getParameter(START_PARAM_NAME)));
            } catch (NumberFormatException e) {
                // ignore
            	LOG.error(e.getMessage());
            }
        }
        if (request.getParameter(SORTBY_PARAM_NAME) != null) {
            try {
                this.orderByPredicate = Integer.parseInt(request.getParameter(SORTBY_PARAM_NAME));
            } catch (Exception e) {
                // ignore
            	LOG.error(e.getMessage());
            }
        }
        
        // Note: the predicate names (first param to Predicate constructor) are the same
        // as in the facets returned and used in search.jsp
        Predicate languagePredicate = new Predicate("languages", "language");
        languagePredicate.set("language", request.getParameter(LANGUAGE_FACET_PARAM_NAME));
        this.search.addPredicate(languagePredicate);

        if (null != this.searchInPaths) {
            Predicate pathsPredicate = new Predicate("paths", "path");
            for (String apath : this.searchInPaths) {
                pathsPredicate.set("path", apath);
            }
            this.search.addPredicate(pathsPredicate);
        }

        Predicate tagPredicate = new Predicate("tags", "tagid");
        tagPredicate.set("property", JcrConstants.JCR_CONTENT + "/" + NameConstants.PN_TAGS);
        try {
        	//tagPredicate.set("tagid", request.getParameter(TAG_FACET_PARAM_NAME));        	
        	String tagPredicateValue = new String(URLDecoder.decode(request.getParameter(TAG_FACET_PARAM_NAME), "UTF-8"));
        	tagPredicate.set("tagid", tagPredicateValue);
        } catch (Exception e) {
        	// ignore
        	LOG.error(e.getMessage());
        }
        this.search.addPredicate(tagPredicate);
        this.tagPredicateSet = tagPredicate.get("tagid") != null;
        
        Predicate restrictSearchPredicate = new Predicate("hide-in-search", "property");
        restrictSearchPredicate.set("property", JcrConstants.JCR_CONTENT + "/" + "hide-in-search");
        restrictSearchPredicate.set("value", "not");
        restrictSearchPredicate.set("operation", "not");
        this.search.addPredicate(restrictSearchPredicate);

        Predicate mimeTypePredicate = new Predicate("mimeTypes", "property");
        mimeTypePredicate.set("property", JcrConstants.JCR_CONTENT + "/" + JcrConstants.JCR_MIMETYPE);
        mimeTypePredicate.set("value", request.getParameter(MIME_TYPE_FACET_PARAM_NAME));
        this.search.addPredicate(mimeTypePredicate);

        Predicate lastModPredicate = new Predicate("lastModified", "daterange");
        lastModPredicate.set("property", JcrConstants.JCR_CONTENT + "/" + NameConstants.PN_PAGE_LAST_MOD);
        // TODO: consider lowerOperation/upperOperation (has to be additional request params)
        lastModPredicate.set("lowerBound", request.getParameter(FROM_FACET_PARAM_NAME));
        lastModPredicate.set("upperBound", request.getParameter(TO_FACET_PARAM_NAME));
        this.search.addPredicate(lastModPredicate);
        
        if (this.orderByPredicate == 1) {
            Predicate orderByLastModified = new Predicate("orderByLastModified", Predicate.ORDER_BY);
            orderByLastModified.set(Predicate.ORDER_BY, "@jcr:content/jcr:lastModified");
            orderByLastModified.set("orderby.index", "true");
            orderByLastModified.set(Predicate.PARAM_SORT, Predicate.SORT_DESCENDING);
            this.search.addPredicate(orderByLastModified);
        } else {
            Predicate orderByScore = new Predicate("orderByScore", Predicate.ORDER_BY);
            orderByScore.set(Predicate.ORDER_BY, "@jcr:score");
            orderByScore.set(Predicate.PARAM_SORT, Predicate.SORT_DESCENDING);
            this.search.addPredicate(orderByScore);
        }
    }

    /**
     * @return query trends (popular queries).
     */
    public Trends getTrends() {
        return search.getTrends();
    }

    /**
     * @return the query result or <code>null</code> if there is neither a query
     *         parameter set nor a tag predicate.
     * @throws RepositoryException if an exception occurs while executing the
     *                             query.
     */
    public Result getResult() throws RepositoryException {
        if (result == null
                && (search.getQuery().length() > 0 || tagPredicateSet)
                && search.getResult() != null) {
            result = new Result(search.getResult());
        }
        return result;
    }
    
    /**
     * @return queries that are related to the current one.
     * @throws RepositoryException if an error occurs while reading from
     *                             the repository.
     */
    public List<String> getRelatedQueries() throws RepositoryException {
        return search.getRelatedQueries();
    }

    /**
     * @return the query supplied by the user or an empty String if none is
     *         provided.
     */
    public String getQuery() {
        return query != null ? query : "";
    }

    /**
     * Sets a new fulltext query that will be executed.
     *
     * @param query the fulltext query.
     */
    public void setQuery(String query) {
        this.query = query;
        // use GQL to filter out wildcards
        try {
            final StringBuilder sb = new StringBuilder();
            GQL.parse(query, request.getResourceResolver().adaptTo(Session.class),
                    new GQL.ParserCallback() {
                        public void term(String property, String value, boolean optional)
                                throws RepositoryException {
                            sb.append(" ");
                            if (optional) {
                                sb.append("OR ");
                            }
                            if (property.length() > 0) {
                                sb.append(property).append(":");
                            }
                            sb.append(value);
                        }
            });
            search.setQuery(sb.toString().trim());
        } catch (RepositoryException e) {
            search.setQuery("");
            LOG.error(e.getMessage());
        }
    }

    /**
     * @return the number of hits to display per page.
     */
    public long getHitsPerPage() {
        return search.getHitsPerPage();
    }

    /**
     * @param num the number of hits to display on a page.
     */
    public void setHitsPerPage(long num) {
        search.setHitsPerPage(num);
    }
    
    public SearchResult getSearchResult() throws RepositoryException {
        if (null != search.getResult()) {
            return search.getResult();
        } else {
        	return null;
        }
    }

    public Map<String, Map<String, String>> getResultFilterCount(String showall, Map<String, Map<String, String>> mapSearchFilters) throws RepositoryException {
    	Map<String, Map<String, String>> mapFilters = new HashMap<String, Map<String, String>>();
    	SearchResult result = null;
    	result = getSearchResult();
    	if (null != result) {
    		List<com.day.cq.search.result.Hit> hits = result.getHits();
    		LOG.info("#### search result filter hits.size is " + hits.size());
			for (Map.Entry<String, Map<String, String>> entry : mapSearchFilters.entrySet()) {
			    String key = entry.getKey();
			    Map<String, String> value = entry.getValue();				    
				long from 	= Long.valueOf(value.get("from"));
				long to 	= Long.valueOf(value.get("to"));
				long count	= Long.valueOf(value.get("count"));
				
		    	for (com.day.cq.search.result.Hit ahit : hits) {	    		
		    		long lastMod = 0;
		    		if (null != ahit.getProperties().get("cq:lastModified")) {
		    			lastMod = ((Calendar) ahit.getProperties().get("cq:lastModified")).getTimeInMillis();
		    		}
	    			if (lastMod >= from && lastMod <= to) {
	    				count = count + 1;	    				
	    			}
		    	}
    			Map<String, String> newvalue = new HashMap<String, String>();
    			newvalue.put("from", Long.toString(from));
    			newvalue.put("to", Long.toString(to));
    			newvalue.put("count", Long.toString(count));	    			
    			mapFilters.put(key, newvalue);
			}
    	}
    	return mapFilters;
    }
      
    /**
     * A search result.
     */
    public final class Result {

        /**
         * The underyling CQ search result instance.
         */
        private final SearchResult result;

        /**
         * The hits on the current result page.
         */
        private final List<Hit> hits;

        /**
         * The spell suggestion. Set only when requested. An empty string
         * indicates that a suggestion was returned by the spellcheck, but
         * does not return results for the current query.
         * See {@link #getSpellcheck()}.
         */
        private String spellSuggestion;

        /**
         * Creates a new result based on the given CQ search result.
         *
         * @param result the CQ search result.
         */
        private Result(SearchResult result) {
            this.result = result;
            this.hits = new ArrayList<Hit>();
            for (com.day.cq.search.result.Hit h : result.getHits()) {
                this.hits.add(new Hit(h));
            }
        }

        /**
         * @return a List of {@link Page}es to display the navigation through the
         *         result pages.
         * @throws RepositoryException if an error occurs while reading from
         *              the query result.
         */
        public List<Page> getResultPages() throws RepositoryException {
            if (resultPages == null) {
                resultPages = new ArrayList<Page>();
                for (com.day.cq.search.result.ResultPage rp : result.getResultPages()) {
                    resultPages.add(new Page(rp));
                }
            }
            return resultPages;
        }

        /**
         * @return the page, which contains the information about the previous page.
         *         Returns <code>null</code> if there is no previous page (i.e. the
         *         current page is the first page).
         * @throws RepositoryException if an error occurs while reading from
         *              the query result.
         */
        public Page getPreviousPage() throws RepositoryException {
            ResultPage previous = result.getPreviousPage();
            if (previous != null) {
                return new Page(previous);
            } else {
                return null;
            }
        }

        /**
         * @return the page, which contains the information about the next page.
         *         Returns <code>null</code> if there is no next page (i.e. the
         *         current page is the last page).
         * @throws RepositoryException if an error occurs while reading from
         *              the query result.
         */
        public Page getNextPage() throws RepositoryException {
            ResultPage next = result.getNextPage();
            if (next != null) {
                return new Page(next);
            } else {
                return null;
            }
        }

        /**
         * @return the script for query and result tracking.
         */
        public String getTrackerScript() {
            StringBuffer sb = new StringBuffer();
            String contextPath = request.getContextPath();
            sb.append("<script type='text/javascript'>");
            if (!search.getQuery().startsWith(SimpleSearch.RELATED_PREFIX)) {
                sb.append("var trackim=new Image();");
                sb.append("trackim.src='").append(contextPath);
                sb.append("/bin/statistics/tracker/query");
                sb.append("?q=").append(encodeURL(search.getQuery()));
                sb.append("&nr=").append(getTotalMatches());
                sb.append("&et=").append(getExecutionTimeMillis());
                sb.append("&").append(System.currentTimeMillis()).append("';\n");
            }
            sb.append("function trackSelectedResult(obj, position, query) {\n");
            sb.append("  var trackim=new Image();\n");
            sb.append("  var regExp = /^((\\w+):\\/\\/\\/?)?((\\w+):?(\\w+)?@)?([^\\/\\?:]+):?(\\d+)?(\\/?[^\\?#;\\|]+)?([;\\|])?([^\\?#]+)?\\??([^#]+)?#?(\\w*)/;\n");
            sb.append("  var uri = regExp.exec(obj.href);\n");
            sb.append("  var imgSrc = '").append(contextPath).append("/bin/statistics/tracker/result?p=';\n");
            sb.append("  imgSrc += encodeURIComponent(uri[8].substring(");
            sb.append(contextPath.length()).append(", uri[8].lastIndexOf('.')));\n");
            sb.append("  imgSrc += '&po=' + position + '&q=");
            sb.append(encodeURL(search.getQuery().toLowerCase()));
            sb.append("&' + Math.random();\n");
            sb.append("  trackim.src = imgSrc;\n");
            sb.append("}");
            sb.append("</script>");
            return sb.toString();
        }

        /**
         * @return the result of a spell check or <code>null</code> if spell
         *         checking is not supported or the repository thinks the spelling
         *         is correct.
         */
        @SuppressWarnings("deprecation")
		public String getSpellcheck() {
            if (spellSuggestion == null) {
                try {
                    Session session = request.getResourceResolver().adaptTo(Session.class);
                    RowIterator rows = session.getWorkspace().getQueryManager().createQuery(
                            SPELLCHECK_QUERY.replaceAll("\\$\\{query\\}",
                                    Matcher.quoteReplacement(getQuery())),
                            Query.XPATH).execute().getRows();
                    String suggestion = null;
                    if (rows.hasNext()) {
                        Value v = rows.nextRow().getValue("rep:spellcheck()");
                        if (v != null) {
                            suggestion = v.getString();
                        }
                    }
                    if (suggestion == null) {
                        return null;
                    }

                    // set query term to suggestion and run query again
                    search.setQuery(suggestion);
                    if (search.getResult().getTotalMatches() > 0) {
                        spellSuggestion = suggestion;
                    } else {
                        spellSuggestion = "";
                    }
                } catch (RepositoryException e) {
                    spellSuggestion = "";
                    LOG.error(e.getMessage());
                }
            }
            if (spellSuggestion.length() == 0) {
                return null;
            } else {
                return spellSuggestion;
            }
        }

        /**
         * @return the start index. i.e. from where to start to display the hits.
         */
        public long getStartIndex() {
            return result.getStartIndex();
        }

        /**
         * @return the total number of matches.
         */
        public long getTotalMatches() {
            return result.getTotalMatches();
        }

        /**
         * Returns the execution time in fractions of a second.
         * <br/>
         * Example: 0.08 (means, the query took 80 milliseconds to execute).
         * @return the execution time of the query.
         */
        public String getExecutionTime() {
            return result.getExecutionTime();
        }

        /**
         * Returns the execution time in milliseconds.
         *
         * @return the execution time of the query.
         */
        public long getExecutionTimeMillis() {
            return result.getExecutionTimeMillis();
        }

        /**
         * Returns the facets for this search result.
         *
         * @return the facets for this search result.
         * @throws RepositoryException if an error occurs while executing the query
         *          or calculating the facets.
         */
        public Map<String, Facet> getFacets() throws RepositoryException {
            return result.getFacets();
        }

        /**
         * @return a List of {@link Hit}s to display on the result page.
         */
        public List<Hit> getHits() {
            return hits;
        }
    }

    /**
     * A hit within the search result.
     */
    public final class Hit {

        /**
         * The underlying CQ hit.
         */
        private final com.day.cq.search.result.Hit hit;

        /**
         * Creates a new hit based on the given CQ <code>hit</code>.
         *
         * @param hit the CQ hit to wrap.
         */
        private Hit(com.day.cq.search.result.Hit hit) {
            this.hit = hit;
        }

        /**
         * Returns the title for this hit. The returned string may contain
         * HTML tags, which means it must not be escaped when written to the
         * response.
         *
         * @return the title for this hit.
         * @throws RepositoryException if an error occurs while reading form the
         * repository.
          */
        public String getTitle() throws RepositoryException {
            String excerpt = hit.getExcerpts().get(JcrConstants.JCR_TITLE);
            if (excerpt != null) {
                return excerpt;
            }
            return getPageOrAsset().getName();
        }

        /**
         * @return the default excerpt for this hit.
         * @throws RepositoryException if an error occurs while building the
         * excerpt.
         */
        public String getExcerpt() throws RepositoryException {
            return hit.getExcerpt();
        }

        /**
         * @return the url for this hit.
         * @throws RepositoryException if an error occurs while reading from the
         *              query result.
         */
        public String getURL() throws RepositoryException {
            Node n = getPageOrAsset();
            String url = request.getContextPath() + n.getPath();
            if (isPage(n)) {
                url += "." + HTML_EXT;
            }
            return url;
        }
        
        /**
         * @return the url that displays similar pages for this hit.
         * @throws RepositoryException if an error occurs while reading from
         * the query result.
         */
        public String getSimilarURL() throws RepositoryException {
            StringBuffer url = new StringBuffer();
            url.append(request.getRequestURI());
            url.append("?").append(QUERY_PARAM_NAME);
            url.append("=").append(encodeURL(SimpleSearch.RELATED_PREFIX));
            url.append(encodeURL(hit.getPath()));
            return url.toString();
        }

        /**
         * Returns an icon image for this hit.
         *
         * @return an icon image for this hit.
         * @throws RepositoryException if an error occurs while reading from
         * the repository.
         */
        public String getIcon() throws RepositoryException {
            String url = getURL();
            int idx = url.lastIndexOf('.');
            if (idx == -1) {
                // no extension
                return "";
            }
            String ext = url.substring(idx + 1);
            if (ext.equals(HTML_EXT)) {
                // do not provide an icon for html
                return "";
            }
            String path = getIconPath(ext);
            if (path == null) {
                return "";
            }
            StringBuffer sb = new StringBuffer();
            sb.append("<img src='");
            sb.append(request.getContextPath());
            sb.append(path).append("'/>");
            return sb.toString();
        }

        /**
         * Returns the extension of the url of this hit.
         * @return the extension
         * @throws RepositoryException if an error occurs
         */
        public String getExtension() throws RepositoryException {
            String url = getURL();
            int idx = url.lastIndexOf('.');
            return idx >=0
                    ? url.substring(idx+1)
                    : "";
        }

        /**
         * @return the content properties on this hit.
         * @throws RepositoryException if an error occurs while reading from the
         * repository.
         */
        public Map getProperties() throws RepositoryException {
            return hit.getProperties();
        }

        public Resource getResource() throws RepositoryException {
            return hit.getResource();
        }

        /**
         * Returns <code>true</code> if the given node is either of type
         * <code>cq:Page</code>, <code>cq:PseudoPage</code>or
         * <code>dam:Asset</code>.
         *
         * @param n the node to check.
         * @return <code>true</code> if the node represents either a page or an
         *         asset; <code>false</code> otherwise.
         * @throws RepositoryException if an error occurs during the check.
         */
        private boolean isPageOrAsset(Node n) throws RepositoryException {
            return isPage(n) || n.isNodeType(DamConstants.NT_DAM_ASSET);
        }

        /**
         * Returns <code>true</code> if the given node is either of type
         * <code>cq:Page</code> or <code>cq:PseudoPage</code>.
         *
         * @param n the node to check.
         * @return <code>true</code> if the node represents a page;
         *         <code>false</code> otherwise.
         * @throws RepositoryException if an error occurs during the check.
         */
        private boolean isPage(Node n) throws RepositoryException {
            return n.isNodeType(NameConstants.NT_PAGE)
                    || n.isNodeType(NameConstants.NT_PSEUDO_PAGE);
        }

        /**
         * Returns the page or asset node that contains the current hit node.
         *
         * @return the page or asset node that contains the current hit node.
         * @throws RepositoryException if an error occurs while reading from the
         *                             repository.
         */
        private Node getPageOrAsset() throws RepositoryException {
            Node n = hit.getNode();
            while (!isPageOrAsset(n) && n.getName().length() > 0) {
                n = n.getParent();
            }
            return n;
        }
    }

    /**
     * A result page.
     */
    public final class Page {

        /**
         * The underlying CQ result page.
         */
        private final ResultPage rp;

        /**
         * Creates a new page with the given CQ result page.
         *
         * @param rp the CQ result page.
         */
        private Page(ResultPage rp) {
            this.rp = rp;
        }

        /**
         * @return whether this page is currently displayed.
         */
        public boolean isCurrentPage() {
            return rp.isCurrentPage();
        }

        /**
         * @return zero based index of this result page.
         */
        public long getIndex() {
            return rp.getIndex();
        }

        /**
         * @return the URL to this search result page.
         */
        public String getURL() {
            StringBuffer url = new StringBuffer();
            url.append(request.getRequestURI());
            url.append("?").append(QUERY_PARAM_NAME);
            url.append("=").append(encodeURL(search.getQuery()));
            url.append("&").append(START_PARAM_NAME);
            url.append("=").append(rp.getStart());
            
            String lang = request.getParameter(LANGUAGE_FACET_PARAM_NAME);
            if (lang != null) {
                url.append("&").append(LANGUAGE_FACET_PARAM_NAME);
                url.append("=").append(lang);
            }
            String tag = request.getParameter(TAG_FACET_PARAM_NAME);
            if (tag != null) {
                url.append("&").append(TAG_FACET_PARAM_NAME);
                url.append("=").append(tag);
            }
            String mimeType = request.getParameter(MIME_TYPE_FACET_PARAM_NAME);
            if (mimeType != null) {
                url.append("&").append(MIME_TYPE_FACET_PARAM_NAME);
                url.append("=").append(mimeType);
            }
            String from = request.getParameter(FROM_FACET_PARAM_NAME);
            if (from != null) {
                url.append("&").append(FROM_FACET_PARAM_NAME);
                url.append("=").append(from);
            }
            String to = request.getParameter(TO_FACET_PARAM_NAME);
            if (to != null) {
                url.append("&").append(TO_FACET_PARAM_NAME);
                url.append("=").append(to);
            }
            String sortBy = request.getParameter(SORTBY_PARAM_NAME);
            if (sortBy != null) {
                url.append("&").append(SORTBY_PARAM_NAME);
                url.append("=").append(sortBy);
            }
            String showAll = request.getParameter(SHOWALL_PARAM_NAME);
            if (showAll != null) {
                url.append("&").append(SHOWALL_PARAM_NAME);
                url.append("=").append(showAll);
            }
            
            return url.toString();
        }
    }
    
    /**
     * Encodes the given <code>url</code> using {@link URLEncoder#encode(String, String)}
     * with a <code>UTF-8</code> encoding.
     *
     * @param url the url to encode.
     * @return the encoded url.
     */
    private static String encodeURL(String url) {
        try {
            return URLEncoder.encode(url, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // will never happen
        	LOG.error(e.getMessage());
            return url;
        }
    }

    /**
     * Returns the icon path for the given extension or <code>null</code> if
     * none is found for the given extension.
     *
     * @param extension the extension.
     * @return the icon path for the given extension or <code>null</code>.
     */
    private String getIconPath(String extension) {
        Component c = WCMUtils.getComponent(resource);
        if (c == null) {
            return null;
        }
        Resource icon = c.getLocalResource("resources/" + extension + ".gif");
        if (icon == null) {
            icon = c.getLocalResource("resources/default.gif");
        }
        return icon == null ? null : icon.getPath();
    }

}