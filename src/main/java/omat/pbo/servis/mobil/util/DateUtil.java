package omat.pbo.servis.mobil.util;

import java.sql.Date;
import java.sql.Time;

public class DateUtil {

    public static Date stringToSqlDate(String dateStr) {
        try {
            if (dateStr == null || dateStr.trim().isEmpty()) {
                return new Date(System.currentTimeMillis());
            }
            return Date.valueOf(dateStr);
        } catch (Exception e) {
            return new Date(System.currentTimeMillis());
        }
    }

    public static Time stringToSqlTime(String timeStr) {
        try {
            if (timeStr == null || timeStr.trim().isEmpty()) {
                return new Time(System.currentTimeMillis());
            }
            if (timeStr.length() == 5) {
                timeStr = timeStr + ":00";
            }
            return Time.valueOf(timeStr);
        } catch (Exception e) {
            return new Time(System.currentTimeMillis());
        }
    }
}
