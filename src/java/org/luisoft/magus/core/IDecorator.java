package org.luisoft.magus.core;

import java.io.IOException;

import freemarker.template.TemplateException;

public interface IDecorator {

	/**
	 * @return The full path (including file name) of the decorated class.
	 */
	String getFullPath();

	/**
	 * @return
	 * @throws IOException
	 * @throws TemplateException
	 */
	String decorate() throws IOException, TemplateException;

}
