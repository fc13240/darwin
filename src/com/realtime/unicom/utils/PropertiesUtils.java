package com.realtime.unicom.utils;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtils {
	private static Properties properties = null;
	
	public static void setProperties(String propertiesPath) {
		Properties propertiesTemp = new Properties();
		InputStream inputStream  = PropertiesUtils.class.getResourceAsStream(propertiesPath);
		try {
			propertiesTemp.load(inputStream);
        } catch (IOException e1) {
	        e1.printStackTrace();
        }
		PropertiesUtils.properties = propertiesTemp;
	} 
	
	public static String getPropertiesValue(String key) {
	   Properties properties = PropertiesUtils.properties;
	   return properties.getProperty(key);
	}
	/**
	 * 保存属性到文件中
	 * 
	 * @param pro
	 * @param file
	 */
	public static void saveProperties(Properties pro, String file) {
		if (pro == null) {
			return;
		}
		FileOutputStream oFile = null;
		try {
			oFile = new FileOutputStream(file, false);
			pro.store(oFile, "modify properties file");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (oFile != null) {
					oFile.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
