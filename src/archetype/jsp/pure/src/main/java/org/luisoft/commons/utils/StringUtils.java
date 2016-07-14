package org.luisoft.commons.utils;

public final class StringUtils {

    public static String uncapitalize(String str) {
        int strLen = str.length();
        if (str == null || strLen == 0) {
            return str;
        }
        return new StringBuffer(strLen).append(Character.toLowerCase(str.charAt(0))).append(str.substring(1)).toString();
    }
}
