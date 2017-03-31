package com.brands.core.utils;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;

/**
 * CX Query Builder Wrapper.
 *
 */
public final class QueryUtil {

	/**
	 * These are the possible metadata names
	 */
	/**
	 * JCR_TITLE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String JCR_TITLE = "jcr:title";
	/**
	 * NAV_TITLE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String NAV_TITLE = "navTitle";
	/**
	 * OFF_TIME // @TODO need to change these to use ConfigUtil.
	 */
	public static final String OFF_TIME = "offTime";
	/**
	 * ON_TIME // @TODO need to change these to use ConfigUtil.
	 */
	public static final String ON_TIME = "onTime";
	/**
	 * HIDE_IN_NAV // @TODO need to change these to use ConfigUtil.
	 */
	public static final String HIDE_IN_NAV = "hideInNav";
	/**
	 * LAST_PUB_DATE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String LAST_PUB_DATE = "cq:lastPublished";
	/**
	 * LAST_PUB_BY // @TODO need to change these to use ConfigUtil.
	 */
	public static final String LAST_PUB_BY = "cq:lastPublishedBy";
	/**
	 * RESOURCE_TYPE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String RESOURCE_TYPE = "sling:resourceType";
	/**
	 * CREATED_DATE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String CREATED_DATE = "jcr:created";
	/**
	 * CREATED_BY // @TODO need to change these to use ConfigUtil.
	 */
	public static final String CREATED_BY = "jcr:createdBy";
	/**
	 * LAST_MODIFIED_DATE // @TODO need to change these to use ConfigUtil.
	 */
	public static final String LAST_MODIFIED_DATE = "cq:lastModified";
	/**
	 * LAST_MODIFIED_BY // @TODO need to change these to use ConfigUtil.
	 */
	public static final String LAST_MODIFIED_BY = "cq:lastModifiedBy";

	/**
	 * Hide constructor.
	 */
	private QueryUtil() {
	}

	/**
	 * Logger of this class.
	 */
	private static final Logger LOG = LoggerFactory.getLogger(QueryUtil.class);

	/**
	 * wrapper class for QueryBuilder.createQuery(session).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @return Query Query
	 */
	public static Query createQuery(final ResourceResolver resourceResolver) {

		if (resourceResolver == null) {
			LOG.warn("createQuery(resourceResolver):resourceResolver is null");
			return null;
		}

		Session session = resourceResolver.adaptTo(Session.class);
		QueryBuilder builder = resourceResolver.adaptTo(QueryBuilder.class);
		return builder.createQuery(session);
	}

	/**
	 * wrapper class for QueryBuilder.createQuery(predicates, session).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param predicates
	 *            predicates
	 * @return Query
	 */
	public static Query createQuery(final ResourceResolver resourceResolver,
			final PredicateGroup predicates) {

		if (resourceResolver == null) {
			LOG.warn("createQuery(resourceResolver, predicates): "
					+ "resourceResolver is null");
			return null;
		}

		if (predicates == null) {
			LOG.warn("createQuery(resourceResolver, predicates): "
					+ "predicates is null");
			return null;
		}

		Session session = resourceResolver.adaptTo(Session.class);
		QueryBuilder builder = resourceResolver.adaptTo(QueryBuilder.class);
		return builder.createQuery(predicates, session);
	}

	/**
	 * helper class for:
	 * CXQueryBuilder.createQuery(resourceResolver,predicates).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param searchMap
	 *            searchMap
	 * @return Query
	 */
	public static Query createQuery(final ResourceResolver resourceResolver,
			final Map<String, String> searchMap) {

		if (searchMap == null) {
			LOG.warn("createQuery(resourceResolver, searchMap): "
					+ "searchMap is null");
			return null;
		}

		// null checking for other parameters is done in:
		// CXQueryBuilder.createQuery(resourceResolver, predicates)
		return QueryUtil.createQuery(resourceResolver,
				PredicateGroup.create(searchMap));
	}

	/**
	 * helper class for:
	 * CXQueryBuilder.createQuery(resourceResolver,predicates).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param searchMap
	 *            searchMap
	 * @return SearchResult
	 */
	public static SearchResult searchGetResult(
			final ResourceResolver resourceResolver,
			final Map<String, String> searchMap) {

		return QueryUtil.searchGetResult(resourceResolver, searchMap, (long) 0);
	}

	/**
	 * helper class for:
	 * CXQueryBuilder.createQuery(resourceResolver,predicates).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param searchMap
	 *            searchMap
	 * @param offsetNum
	 *            offsetNum
	 * @return SearchResult
	 */
	public static SearchResult searchGetResult(
			final ResourceResolver resourceResolver,
			final Map<String, String> searchMap, final Long offsetNum) {

		if (offsetNum == null) {
			LOG.warn("searchGetResult(resourceResolver, searchMap, offsetNum"
					+ "): offsetNum is null");
			return null;
		}

		Query query = QueryUtil.createQuery(resourceResolver, searchMap);
		query.setStart(offsetNum);
		SearchResult result = query.getResult();

		return result;
	}

	/**
	 * helper class for:
	 * CXQueryBuilder.createQuery(resourceResolver,predicates).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param searchMap
	 *            searchMap
	 * @param offsetNum
	 *            offsetNum
	 * @return List<Hit>
	 */
	public static List<Hit> searchGetHits(
			final ResourceResolver resourceResolver,
			final Map<String, String> searchMap, final Long offsetNum) {

		SearchResult result = QueryUtil.searchGetResult(resourceResolver,
				searchMap, offsetNum);
		List<Hit> hits = result.getHits();

		return hits;
	}

	/**
	 * helper class for: QueryBuilder.createQuery(resourceResolver,predicates).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param searchMap
	 *            searchMap
	 * @return List<Hit>
	 */
	public static List<Hit> searchGetHits(
			final ResourceResolver resourceResolver,
			final Map<String, String> searchMap) {

		return QueryUtil.searchGetHits(resourceResolver, searchMap, (long) 0);
	}

	/**
	 * wrapper class for QueryBuilder.loadQuery(path, session).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param path
	 *            path
	 * @return Query
	 */
	public static Query loadQuery(final ResourceResolver resourceResolver,
			final String path) {

		if (resourceResolver == null) {
			LOG.warn("loadQuery(resourceResolver, path): "
					+ "resourceResolver is null");
			return null;
		}

		if (StringUtils.isEmpty(path)) {
			LOG.warn("loadQuery(resourceResolver, path): " + "path is empty");
			return null;
		}

		Session session = resourceResolver.adaptTo(Session.class);
		QueryBuilder builder = resourceResolver.adaptTo(QueryBuilder.class);
		try {
			return builder.loadQuery(path, session);
		} catch (RepositoryException e) {
			LOG.error(e.getMessage());
		} catch (IOException e) {
			LOG.error(e.getMessage());
		}

		return null;
	}

	/**
	 * wrapper class for. QueryBuilder.storeQuery(query, path, createFile,
	 * session).
	 * 
	 * @param resourceResolver
	 *            resourceResolver
	 * @param query
	 *            query
	 * @param path
	 *            path
	 * @param createFile
	 *            createFile
	 */
	public static void storeQuery(final ResourceResolver resourceResolver,
			final Query query, final String path, final boolean createFile) {

		if (resourceResolver == null) {
			LOG.warn("storeQuery(resourceResolver, query, path, createFile): "
					+ "resourceResolver is null");
			return;
		}

		if (query == null) {
			LOG.warn("storeQuery(resourceResolver, query, path, createFile): "
					+ "query is null");
			return;
		}

		if (StringUtils.isEmpty(path)) {
			LOG.warn("storeQuery(resourceResolver, query, path, createFile): "
					+ "path is empty");
			return;
		}

		Session session = resourceResolver.adaptTo(Session.class);
		QueryBuilder builder = resourceResolver.adaptTo(QueryBuilder.class);
		try {
			builder.storeQuery(query, path, createFile, session);
		} catch (RepositoryException e) {
			LOG.error(e.getMessage());
		} catch (IOException e) {
			LOG.error(e.getMessage());
		}

	}
}
