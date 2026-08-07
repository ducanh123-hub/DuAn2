package com.hotel.util;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateUtil {

    private static final String DEFAULT_PATTERN = "yyyy-MM-dd";
    private static final String DISPLAY_PATTERN = "dd/MM/yyyy";

    public static Date toDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        try {
            return Date.valueOf(dateStr);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String toString(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(DISPLAY_PATTERN);
        return sdf.format(date);
    }

    public static String toDatabaseString(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(DEFAULT_PATTERN);
        return sdf.format(date);
    }

    public static int calculateDaysBetween(Date checkIn, Date checkOut) {
        if (checkIn == null || checkOut == null) {
            return 0;
        }
        LocalDate localCheckIn = checkIn.toLocalDate();
        LocalDate localCheckOut = checkOut.toLocalDate();
        return (int) ChronoUnit.DAYS.between(localCheckIn, localCheckOut);
    }
}
