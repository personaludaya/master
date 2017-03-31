package com.brands.core.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.sling.api.resource.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConfigUtil {
	/**
	 * Logger of this class.
	 */
	private static final Logger LOG = LoggerFactory.getLogger(ConfigUtil.class);
	
	/**
	 * Hide constructor.
	 */
	private ConfigUtil() {
	}

	/**
     * This method is used if the properties file is stored in CRX.
     * @param resource - current resource
     * @param filePath - file path of the properties file in CRX
     * @param propKey - key of the property
     * @return String - value of the property
     * @throws IOException - IOException
     */
	public static String getProperty(final Resource resource,
			final String filePath, final String propKey) throws IOException {
		Properties prop = new Properties();
		String propValue = null;
		try {
			Resource res = resource.getResourceResolver().getResource(filePath);
			InputStream ins = res.adaptTo(InputStream.class);
			prop.load(ins);
			propValue = prop.getProperty(propKey.trim());
			if (propValue != null) {
				propValue = propValue.trim();
			}
		} catch (IOException e) {
			LOG.error("", e);
		}
		return propValue;
	}
}
