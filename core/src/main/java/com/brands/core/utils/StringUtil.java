package com.brands.core.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.text.StringCharacterIterator;
import java.util.Calendar;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StringUtil {
	/**
	 * Logger of this class.
	 */
	private static final Logger LOG = LoggerFactory.getLogger(StringUtil.class);

	/**
	 * Check whether a given string is null or empty
	 * @param s
	 * @return boolean
	 */
	public static boolean isEmpty(String s) {
		if(s == null) return true;
		if("".equals(s.trim())) return true;
		return false;
	}
	
	public static String formatDate(String sDate) {
		return formatDate(sDate, "dd MMM yyyy", null);
	}
	
	public static String formatDate(String sDate, Locale locale) {
		return formatDate(sDate, "dd MMM yyyy", locale);
	}
	
	public static String formatDate(String sDate, String displayFormat, Locale locale) {
		String CQ_dateFormat = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(CQ_dateFormat);
		SimpleDateFormat sdf2 = new SimpleDateFormat(displayFormat);
		String sFormatDate = "";
		try {
			if (!StringUtil.isEmpty(sDate)) {
				Calendar cal = Calendar.getInstance();
	            cal.setTime(sdf.parse(sDate));
	            if (locale != null) {
	            	sdf2 = new SimpleDateFormat(displayFormat, locale);
	            }
				sFormatDate = sdf2.format(cal.getTime());
			}
			return sFormatDate;
		} catch (ParseException e) {
			LOG.error(e.getMessage());
		}
		return null;
	}
	
	 /**
     * Performs escaping of certain HTML characters that may be manipulated to
     * launch cross-site scripting attack.  By escaping off these characters,
     * the output string becomes relatively safe to be displayed onto the end-user
     * browser.
     * @param content - the original string, which may contain HTMl markups.
     * @return <type>String</type>
     */
    public static String htmlEncode(String content) {
        return htmlEncode(content, false);
    }
    
    /**
     * Performs escaping of certain HTML characters that may be manipulated to
     * launch cross-site scripting attack.  By escaping off these characters,
     * the output string becomes relatively safe to be displayed onto the end-user
     * browser.
     * @param content - the original string, which may contain HTMl markups.
     * @param expandNewLine - option to replace newline with br
     * @return <type>String</type>
     */
    public static String htmlEncode(String content, boolean expandNewLine)
    {
        if(content == null || content.trim().length() == 0)
            return "";
        final StringBuffer sb = new StringBuffer();
        final StringCharacterIterator iterator = new StringCharacterIterator(content);
        
        char c = iterator.current();
        while( c!=StringCharacterIterator.DONE ) {
            switch(c) {
                case '<'  : sb.append("&lt;");   break;
                case '>'  : sb.append("&gt;");   break;
                case '&'  : sb.append("&amp;");  break;
                case '\"' : sb.append("&quot;"); break;
                case '\'' : sb.append("&#39;");  break;
                case '%'  : sb.append("&#37;");  break;
                case ';'  : sb.append("&#59;");  break;
                case '('  : sb.append("&#40;");  break;
                case ')'  : sb.append("&#41;");  break;
                case '+'  : sb.append("&#43;");  break;
                case '-'  : sb.append("&#45;");  break;
                case '\n' : if( expandNewLine ) { sb.append("<br/>"); }
                            else { sb.append(c); }
                            break;
                default: sb.append(c);
            }
            c = iterator.next();
        }
        return sb.toString();
    }

}
