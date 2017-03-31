package com.brands.core.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.Property;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.ValueFormatException;
import javax.servlet.ServletException;
import org.apache.felix.scr.annotations.sling.SlingServlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceMetadata;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.apache.sling.api.resource.ResourceUtil;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.api.wrappers.ValueMapDecorator;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.adobe.granite.ui.components.ds.DataSource;
import com.adobe.granite.ui.components.ds.SimpleDataSource;
import com.adobe.granite.ui.components.ds.ValueMapResource;

@SlingServlet(resourceTypes = "brands/GetKeyValueList")
public class KeyValueListServlet extends SlingAllMethodsServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger LOG = LoggerFactory
			.getLogger(KeyValueListServlet.class);

	@Override
    protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response)
            throws ServletException, IOException {
		
        List<Resource> themes = new ArrayList<Resource>();
        ValueMap vm = null; 
        BundleContext bundleContext = FrameworkUtil.getBundle(KeyValueListServlet.class).getBundleContext();
        ServiceReference factoryRef = bundleContext.getServiceReference(ResourceResolverFactory.class.getName());
        ResourceResolverFactory resolverFactory = (ResourceResolverFactory) bundleContext.getService(factoryRef);
        
        ResourceResolver resourceResolver = null;
        try {
            resourceResolver = resolverFactory.getAdministrativeResourceResolver(null);
        } catch (Exception e){
        	LOG.error("MyError:" + e.getMessage());
        }
        
       String jsonPath = getJsonFilePath(resourceResolver,request);
       String jsonFile = getJsonFile(resourceResolver, jsonPath);
       
       LOG.info("*** jsonPath:" + jsonPath);
       LOG.info("*** jsonFile:" + jsonFile);
       
		JSONObject jsonObject;
		try {
			jsonObject = new JSONObject(jsonFile);
			
			JSONArray output= jsonObject.getJSONArray("key-value-set");
			
			for(int i=0;i<output.length();i++){
	            JSONObject ob= output.getJSONObject(i);
	          
	            vm = new ValueMapDecorator(new HashMap<String, Object>());
	            vm.put("value", ob.get("value"));
				vm.put("text", ob.get("text"));
				themes.add(new ValueMapResource(resourceResolver,
						new ResourceMetadata(), "nt:unstructured", vm));
	        }
			
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			LOG.error("CustomError:" + e1.getMessage());
			e1.printStackTrace();
		}

		DataSource dataSource = new SimpleDataSource(themes.iterator());
		request.setAttribute(DataSource.class.getName(), dataSource);
    }
	
	private String getJsonFilePath(ResourceResolver resourceResolver, SlingHttpServletRequest request) {
		Resource datasource = request.getResource().getChild("datasource");
		ValueMap dsProperties = ResourceUtil.getValueMap(datasource);
		String path = dsProperties.get("path", String.class);
		return path;
	}
	
	private String getJsonFile(ResourceResolver resourceResolver, String jsonPath) {
		Session session = resourceResolver.adaptTo(Session.class);
		String sKeyVenuesDefMarker = null;
		
		try {
			if(session.nodeExists(jsonPath)) {
			    Node node = session.getNode(jsonPath);
			    if(node.hasProperty("jcr:data")) {
			        Property jcrData = node.getProperty("jcr:data");
			        sKeyVenuesDefMarker = jcrData.getString();
			   }
			}
		} catch (PathNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ValueFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RepositoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sKeyVenuesDefMarker;
	}
	
}
