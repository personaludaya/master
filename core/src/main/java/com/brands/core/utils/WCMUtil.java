package com.brands.core.utils;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.Property;
import javax.jcr.Value;
import javax.servlet.http.HttpServletRequest;

import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.commons.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;
import com.day.cq.wcm.foundation.Paragraph;
import com.day.cq.wcm.foundation.ParagraphSystem;
import com.day.cq.tagging.TagManager;
import com.day.cq.tagging.Tag;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;

import java.util.*;
import java.lang.Object;

import com.day.text.Text;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.ValueMap;

public class WCMUtil {
	/**
	 * Logger of this class.
	 */
	private static final Logger LOG = LoggerFactory.getLogger(WCMUtil.class);

	/**
	 * Hide constructor.
	 */
	private WCMUtil() {

	}

	public static List<Node> getMultiCompositePropertyNodeList(
			Node currentNode, String key) {
		List<Node> multiCompositeNodeList = new ArrayList<Node>();

		Node keyNode = null;
		try {
			keyNode = currentNode.getNode(key);
		} catch (Exception e) {
			// no inputs yet, return the empty map
			keyNode = null;
			LOG.error(e.getMessage());
		}

		if (keyNode != null) {
			try {
				NodeIterator keyNodeIter = keyNode.getNodes();
				while (keyNodeIter.hasNext()) {
					Node itemNode = keyNodeIter.nextNode();
					multiCompositeNodeList.add(itemNode);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage());
			}
		}

		return multiCompositeNodeList;
	}

	public static List<Node> getMultiCompositePropertyNodeList(Page page,
			String key) {
		List<Node> multiCompositeNodeList = new ArrayList<Node>();
		if (page != null) {
			Node currentNode = (Node) page.getContentResource().adaptTo(
					Node.class);
			Node keyNode = null;
			try {
				keyNode = currentNode.getNode(key);
			} catch (Exception e) {
				// no inputs yet, return the empty map
				keyNode = null;
				LOG.error(e.getMessage());
			}

			if (keyNode != null) {
				try {
					NodeIterator keyNodeIter = keyNode.getNodes();
					while (keyNodeIter.hasNext()) {
						Node itemNode = keyNodeIter.nextNode();
						multiCompositeNodeList.add(itemNode);
					}
				} catch (Exception e) {
					LOG.error(e.getMessage());
				}
			}
		}
		return multiCompositeNodeList;
	}

	public static Node getNode(PageManager pageManager, String pageHandle,
			String parName) {
		Node node = null;
		try {
			Page glossarypage = pageManager.getPage(pageHandle);

			if (glossarypage != null) {
				ParagraphSystem parsys = new ParagraphSystem(
						glossarypage.getContentResource());
				// List pars = parsys.paragraphs();
				List<Paragraph> pars = parsys.paragraphs();
				for (int i = 0; i < pars.size(); i++) {
					Paragraph par = (Paragraph) pars.get(i);
					if (par.getPath().endsWith(parName)) {
						node = (Node) par.adaptTo(Node.class);
					}
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return node;
	}
	
	public static String[] getInheritedPagePropertiesValues (Page currentPage, String propertyName){
		/** Returns the page property value. If it does not exist on the current page, iterate upwards till a value is found, then stop.
            If the current page and all pages above do not have the value, return {}
		 **/
		Page tempPage = currentPage;
		String[] value = tempPage.getProperties().get(propertyName, String[].class);
		while((tempPage != null) && (null == value) && (tempPage.getDepth() > 0)) {
			tempPage = tempPage.getParent();
			if (tempPage != null){
				value = tempPage.getProperties().get(propertyName, String[].class);
			}
		}
		return value;
	}


	public static Map<String, String> getTagCountMap(Page rootPage, String namespace, ResourceResolver resourceResolver, List<Node> tagNodeList, PageManager pageManager) {
		Map<String, String> tagCountMap = new HashMap<String, String>();

		if (tagNodeList != null) {
			for (int i=0;i<tagNodeList.size();i++) {
				Node thisTagNode = tagNodeList.get(i);
				try {
					TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
					Tag thisTag = tagManager.resolve(thisTagNode.getPath());
					String tagId = namespace + ":" + thisTag.getLocalTagID();

					Map<String, String> searchMap = new HashMap<String, String>();
					searchMap.put("path", rootPage.getPath());
					searchMap.put("type", "cq:Page");
					searchMap.put("tagid", tagId);
					searchMap.put("tagid.property", "jcr:content/cq:tags");

					SearchResult result = QueryUtil.searchGetResult(resourceResolver, searchMap, (long)0);
					List<Hit> hits = result.getHits();

					if (!hits.isEmpty()) {
						String thisTagName = thisTag.getName();
						String hitSize = Integer.toString(hits.size());
						tagCountMap.put(thisTagName, hitSize);
					}
				} catch (Exception e){
					LOG.error(e.getMessage());
				}
			}
		}

		return tagCountMap;
	}

	public static List<Node> getTagNodeList(String namespace, ResourceResolver resourceResolver, HttpServletRequest request) {
		List<Node> tagNodeList = new ArrayList<Node>();
		try {
			String tagRootPath = "/etc/tags/" + namespace;
			Node tagRootNode = resourceResolver.resolve(request, tagRootPath).adaptTo(Node.class); 
			NodeIterator tagRootIter = tagRootNode.getNodes();
			while (tagRootIter.hasNext()) {
				Node thisTagNode = tagRootIter.nextNode();
				if (thisTagNode != null) {
					tagNodeList.add(thisTagNode);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		// sort tag node list
		Collections.sort(tagNodeList, new Comparator<Node>() {
			public int compare(Node n1, Node n2) {
				try {
					return n1.getName().compareToIgnoreCase(n2.getName());
				} catch (Exception e){
					LOG.error(e.getMessage());
					return 0;
				}
			}
		});

		return tagNodeList;
	}

	public static String[] getPagePropertiesValues (Page currentPage, String propertyName){
		/** Returns the page property value.
		 **/
		Page tempPage = currentPage;
		String[] value = tempPage.getProperties().get(propertyName, String[].class);
		return value;
	}

	public static boolean isFirstNodeInParagraph(Node currentNode) {
		try {
			Node parentNode = currentNode.getParent();
			NodeIterator iterator = parentNode.getNodes();
			Node firstNode = iterator.nextNode();

			if (currentNode.isSame(firstNode)) return true;
		} catch (Exception e) {
			LOG.error(e.getMessage());
			return false;
		}
		return false;
	}
	
	public static String getPrimaryTag (Page page, Locale locale, String key){
		Tag[] tags = getTags(page, key);
		String primaryTag = "";
		if (null != tags && tags.length > 0){
			primaryTag = tags[0].getLocalizedTitle(locale);
		}
		return primaryTag;
	}

	public static List<String> getTagList(Page page, Locale locale, String key) {
		Tag[] tags = getTags(page, key);
		//String[] primaryTag = new String[tags.length];
		List<String> primaryTag = new ArrayList<String>();
		
		for (Tag tag : tags) {
			primaryTag.add(tag.getLocalizedTitle(locale));	
		}
		return primaryTag;
	}
	
	public static Map<String, String> getTagMapList(Page page, Locale locale, String key) {
		Tag[] tags = getTags(page, key);
		//String[] primaryTag = new String[tags.length];
		Map<String, String> primaryTagMap = new HashMap<String, String> ();
		
		for (Tag tag : tags) {
			if(tag != null)
			primaryTagMap.put(tag.getTagID(), tag.getLocalizedTitle(locale));
		}
		return primaryTagMap;
	}

	public static Tag[] getTags(Page page, String key) {
		Resource r = page.adaptTo(Resource.class);
		ResourceResolver rr = r.getResourceResolver();
		TagManager tagManager = rr.adaptTo(TagManager.class);
		ArrayList<Tag> tags = new ArrayList<Tag>();
		String[] tagsStr = WCMUtil.getPagePropertiesValues(page, key);
		if (null != tagsStr) {
			for (String tagString : tagsStr) {
				Tag aTag = tagManager.resolve(tagString);
				tags.add(aTag);
			}
		}
		Tag[] tagsArray = tags.toArray(new Tag[tags.size()]);
		return tagsArray;
	}
	
	public static Map<String, String> getDialogTagMapList(Page page, Locale locale, String[] keys) {
		Tag[] tags = getDialogTags(page, keys);
		Map<String, String> primaryTagMap = new HashMap<String, String> ();
		
		for (Tag tag : tags) {
			primaryTagMap.put(tag.getTagID(), tag.getLocalizedTitle(locale));
		}
		return primaryTagMap;
	}
	
	public static Tag[] getDialogTags(Page page, String[] keys) {
		Resource r = page.adaptTo(Resource.class);
		ResourceResolver rr = r.getResourceResolver();
		TagManager tagManager = rr.adaptTo(TagManager.class);
		ArrayList<Tag> tags = new ArrayList<Tag>();
		
		if (null != keys) {
			for (String tagString : keys) {
				Tag aTag = tagManager.resolve(tagString);
				tags.add(aTag);
			}
		}
		Tag[] tagsArray = tags.toArray(new Tag[tags.size()]);
		return tagsArray;
	}

	public static String getNodePropertyValue(final Node node, final String key) {
		String value = "";
		try {
			if (node.hasProperty(key)) {
				value = node.getProperty(key).getString();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return value;
	}

	public static String[] getNodePropertyValues(final Node node, final String key) {
		String[] values = {};

		try {
			if (node.hasProperty(key)) {
				if (node.getProperty(key).isMultiple()) {
					// if property is multi field
					Property prop = node.getProperty(key);
					int propertyLen = prop.getValues().length;
					values = new String[propertyLen];
					int counter = 0;
					//put into array
					for (Value v : prop.getValues()) {
						values[counter] = v.getString();
						counter++;
					}
				} else {
					// multi fields will become single-field when there is only
					// one value, do the check here and return array for
					// consistency.
					// if is single-field
					values = new String[1];
					values[0] = WCMUtil.getNodePropertyValue(node, key);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return values;
	}

	public static Node getNodePropertyValueByPage(Page aPage, String nodeName) {
		try {
			Node childPageNode = aPage.adaptTo(Node.class);
			Node jcrNode = childPageNode.getNode("jcr:content");
			if (null != jcrNode) {
				Node parNode = jcrNode.getNode("par");

				if (null != parNode) {
					return parNode.getNode(nodeName);

				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}

		return null;
	}
	 
	public static String getURL(Page page, char s, Boolean arg1) {
		if (page != null) {
			return getURL(Text.escape(page.getPath(), s, arg1));
		} else {
			return "";
		}
	}
	
	public static String getURL(Page page, boolean isAuthor){
		if (isAuthor){
			return getURL(page);
		} else {
			String path = rewrite(page.getPath());
			return getURL(path);
		}
	}

	public static String getURL(String path, boolean isAuthor){
		if (isAuthor){
			return getURL(path);
		} else {
			path = rewrite(path);
		}
		return getURL(path);
	}
	
	public static String rewrite(String path){
		
		if (path.startsWith("/content/desktop")){
			path = path.replaceFirst("/content/desktop", "");
		}
		if (path.startsWith("/content/mobile")){
			path = path.replaceFirst("/content/mobile", "");
		}
		if (path.length() > 3 && path.startsWith("/en/")){
			path = path.replaceFirst("/en/", "/");
		}
		if (StringUtil.isEmpty(path)){
			path = "/";
		}
		
		return path;
	}
	
	public static String getURL(Page page, char s) {
		return getURL(page, s, true);
	}

	public static String getURL(Page page){
		return getURL(page.getPath());
	}

	public static String getURL(String path) {
		if(StringUtils.isBlank(path)) return "";
		int protocolIndex = path.indexOf(":/");
		int queryIndex = path.indexOf('?');
		int javascriptIndex = path.indexOf("javascript:");

		//if ( protocolIndex > -1 && (queryIndex == -1 || queryIndex > protocolIndex) ) {
		//external URL || an external/internal URL with query parameters || javascript call
		if ( protocolIndex > -1 || queryIndex > 0 || javascriptIndex > -1 ) { 
			return path;
		} else if(path.endsWith(".html") || path.endsWith(".htm") || path.contains(".html#") || path.contains(".htm#") || path.endsWith(".jpg") || path.endsWith(".png") || path.endsWith(".js")) {
			return path;
		} else if(path.startsWith("/content/dam/")) {
			return path;
		} else {
			if (!path.equals("/")){
				path = path.concat(".html");
			}
			return path;
		}
	}
	
	public static String getPagePropertyValue(Page page, String property){
		String value = "";
		if (null != page){
			ValueMap vm = page.getProperties();
			value = vm.get(property, "");
		}
		return value;
	}
	
	public static String[] getPagePropertyValues(Page page, String property){
		String value[] = null;
		if (null != page){
			ValueMap vm = page.getProperties();
			value = vm.get(property, String[].class);
		}
		return value;
	}
	
	public static String getLanguageCode(final String path){
		/*
		 * /content/desktop/en/pages
		 * will return en
		 */        
		String rtnStr = "en";

		try {
			final String[] split = path.split("/");
			rtnStr = split[3];
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return rtnStr;
	}
	
	public static String getProductStageIcon(final String key){
		
		if (key.equals("women")) {
			return "icon-female"; 
		} else if (key.equals("seniors")) {
			return "icon-senior";
		} else if (key.equals("kids")) {
			return "icon-kid";
		} else if (key.equals("busy-adults")) {
			return "icon-busy-adult";
		} else if (key.equals("active-people")) {
			return "icon-active-people";
		} else if (key.equals("students")) {
			return "icon-student";
		} else if (key.equals("beauty-seekers")) {
			return "icon-beauty-seeker";
		} else
			return "";
	}
	
	public static String getNavTitle(Page page) {
        String untitled = "";
        if(page == null) return untitled;

        if(page.getNavigationTitle() != null && !page.getNavigationTitle().equals(""))
            return StringUtil.htmlEncode(page.getNavigationTitle());

        return StringUtil.htmlEncode(page.getTitle());
    }
	
	public static String getKeywords(Page page, String propertyName) {
		if(page == null || StringUtil.isEmpty(propertyName)) return "";

		String keywords = "";

		try {
			ValueMap valueMap = page.getProperties();
			if(valueMap != null && valueMap.containsKey(propertyName)) {
				String[] tagsArr = valueMap.get(propertyName, String[].class);

				if(tagsArr != null) {
					for(int i = 0; i < tagsArr.length; i++) {
						String tag = tagsArr[i];

						if(tag.lastIndexOf(":") > 0)
							tag = tag.substring(tag.lastIndexOf(":") + 1);

						if(tag.lastIndexOf("/") > 0)
							tag = tag.substring(tag.lastIndexOf("/") + 1);

						if(i != (tagsArr.length - 1))
							keywords += tag + ",";
						else
							keywords += tag;
					}
				}
			}
		} catch(Exception ex) {}

		return keywords;
	}
	
	public static String getKeywords(Page page, String propertyName, ResourceResolver resourceResolver) {
		if(page == null || StringUtil.isEmpty(propertyName)) return "";

		String keywords = "";

		try {
			TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
			Locale thisLocale = page.getLanguage(false);

			ValueMap valueMap = page.getProperties();
			if(valueMap != null && valueMap.containsKey(propertyName)) {
				String[] tagsArr = valueMap.get(propertyName, String[].class);

				if(tagsArr != null) {
					for(int i = 0; i < tagsArr.length; i++) {
						String tag = tagsArr[i];

						Tag thisTag = tagManager.resolve(tag);

						String localizedTitle = thisTag.getLocalizedTitle(thisLocale);
						if (StringUtil.isEmpty(localizedTitle)) {
							localizedTitle = thisTag.getTitle();
						}

						if(i != (tagsArr.length - 1))
							keywords += localizedTitle + ",";
						else
							keywords += localizedTitle;
					}
				}
			}
		} catch(Exception ex) {}

		return keywords;
	}
	
	public static String getTagKeyByTags(String tag) {
		String[] tags = tag.split("/");
		return tags[tags.length-1];
		
	}
	
	public static List<Map<String, String>> getMultiFieldPanelValues(Resource resource, String name) {
        ValueMap map = resource.adaptTo(ValueMap.class);
        List<Map<String, String>> results = new ArrayList<Map<String, String>>();
        if (map != null && map.containsKey(name)) {
            String[] values = map.get(name, new String[0]);
            for (String value : values) {

                try {
                    JSONObject parsed = new JSONObject(value);
                    Map<String, String> columnMap = new HashMap<String, String>();
                    for (Iterator<String> iter = parsed.keys(); iter.hasNext();) {
                        String key = iter.next();
                        String innerValue = parsed.getString(key);
                        columnMap.put(key, innerValue);
                    }

                    results.add(columnMap);

                } catch (JSONException e) {
                	LOG.error(
                            String.format("Unable to parse JSON in %s property of %s", name, resource.getPath()),
                            e);
                }

            }
        }
        return results;
    }
	
	
}
