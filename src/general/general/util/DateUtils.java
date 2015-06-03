package general.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public final class DateUtils {

	/**
	 * @param format
	 *            Format mask to apply to current date.
	 * @return Current date according to the format mask.
	 */
	public static String getToday(String format) {
		return new SimpleDateFormat(format).format(new Date());
	}
}
