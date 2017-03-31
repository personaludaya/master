package com.brands.core.analytics.models;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

public class UserProfileModel {
	public static final String DATE_FORMAT_FORMS = "dd/mm/yy";
	public static final String CONST_GENDER = "gender";
	public static final String CONST_COUNTRY = "country";
	public static final String CONST_MARKETINGEMAILS = "marketing"; //checkbox to receive newsletters
	public static final String CONST_DOB = "dateofbirth";
	private static final String CONST_MALE = "male";
	private static final String CONST_FEMALE = "female";
	
	private static final Map<String, String> genderMap = new HashMap<String, String>();
	
	private String customerType = "0_0"; //<member>_<newsletter> (default 0_0)
	private String customerId;
	private String customerAge;
	private String customerGender;
	private String customerCountryCode;
	
	public UserProfileModel(){
		genderMap.put("0", CONST_FEMALE);
		genderMap.put("1", CONST_MALE);
	}
	
	public String getCustomerType() {
		return customerType;
	}
	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerAge() {
		return customerAge;
	}
	public void setCustomerAge(String customerAge) {
		this.customerAge = customerAge;
	}
	public String getCustomerGender() {
		return customerGender;
	}
	public void setCustomerGender(String customerGender) {
		this.customerGender = genderMap.get(customerGender);
	}
	public String getCustomerCountryCode() {
		return customerCountryCode;
	}
	public void setCustomerCountryCode(String customerCountryCode) {
		this.customerCountryCode = customerCountryCode;
	}
	
	
	/**
	 * Get age from date (dd/mm/yy)
	 * @param date
	 * @return
	 */
	public String getAgeFromDate(String date, String format){ 
		String age = "";
		SimpleDateFormat df = new SimpleDateFormat(format);
		try {
			if(StringUtils.isNotBlank(date)){
				Date dateObj = df.parse(date); 
				Calendar cal = Calendar.getInstance();
				int currentYear = cal.get(Calendar.YEAR);
				cal.setTime(dateObj);
				int birthYear = cal.get(Calendar.YEAR);
				return String.valueOf(currentYear-birthYear);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return age;
	}
}
