package sandbox.ui;

import java.util.ArrayList;
import java.util.List;

public enum ElementUI {
	BUTTON("Button"), CHECKBOX("CheckBox"), LABEL("Label"), RADIO("Radio"), SELECTBOX(
			"SelectBox"), TEXTBOX("TextBox");

	private String text;

	ElementUI(String text) {
		this.text = text;
	}

	public String getText() {
		return this.text;
	}

	public static ElementUI fromString(String text) {
		ElementUI state = null;
		if (text != null) {
			for (ElementUI e : ElementUI.values()) {
				if (text.equalsIgnoreCase(e.text)) {
					state = e;
				}
			}
		}
		if (state == null) {
			throw new RuntimeException("Element '" + text
					+ "' not found in list: " + ElementUI.list());
		}
		return state;
	}

	public static String list() {
		List<String> lista = new ArrayList<String>();
		for (ElementUI e : ElementUI.values()) {
			lista.add(e.text);
		}
		return lista.toString();
	}
}
