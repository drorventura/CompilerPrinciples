package adtl;

import java.lang.reflect.Field;
import java.net.URL;
import java.util.ArrayList;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

/**
 * A utility for reading string templates from string template group (.stg)
 * files.
 * 
 * @author romanm
 */
public class STGLoader {
	protected STGroup templateGroup;

	public STGLoader(Class<?> cls) {
		this(cls, null);
	}

	public STGLoader(Class<?> cls, String fileName) {
		if (fileName == null)
			fileName = cls.getSimpleName() + ".stg";
		if (!fileName.contains(".stg"))
			fileName += ".stg";

		URL groupURL = cls.getResource(fileName);
		if (groupURL == null)
			throw new Error("Unable to find resource " + fileName
					+ " for class " + cls.getName() + "!");
		try {
			String groupFile = groupURL.getFile();
			groupFile = groupFile.replaceAll("%20", " "); // For windows
			templateGroup = new STGroupFile(groupFile, '$', '$');
		} catch (Throwable t) {
			throw new Error(t.getMessage());
		}
	}

	/**
	 * Instantiates a named template from the group.
	 */
	public ST load(String name) {
		if (!templateGroup.isDefined(name))
			return null;
		ST template = templateGroup.getInstanceOf(name);
		return template;
	}

	public ArrayList<String> getTemplateNames(String prefix) {
		return getTemplateNames(prefix, true);
	}

	/**
	 * Returns the set of templates in this group whose name starts with the
	 * given prefix.
	 */
	public ArrayList<String> getTemplateNames(String prefix, boolean mangleName) {
		// For some reason StringTemplate adds forward slash to template names.
		if (mangleName) {
			prefix = "/" + prefix;
		}
		ArrayList<String> result = new ArrayList<String>();
		for (String templateName : templateGroup.getTemplateNames()) {
			if (templateName.startsWith(prefix))
				result.add(templateName);
		}
		return result;
	}

	/**
	 * Renders a given object by using the corresponding template in the group.
	 * 
	 * @param o
	 *            An object to render.
	 * @return The rendered object.
	 */
	protected <T> String render(T o) {
		// Use reflection to get the name of the template - should be the same
		// as the name of the input object class.
		ST template = load(o.getClass().getSimpleName());
		if (template == null)
			throw new Error("Missing or bad template for " + o.getClass().getSimpleName());

		// Get the names of the template attributes and then use reflection
		// to set the values of the corresponding fields in the input object.
		for (String formalArg : template.impl.formalArguments.keySet()) {
			try {
				Field attributeFIeld = o.getClass().getField(formalArg);
				Object fieldValue = attributeFIeld.get(o);
				template.add(formalArg, fieldValue);
			} catch (NoSuchFieldException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			}
		}
		return template.render();
	}

	public static boolean hasArgument(ST template, String arg) {
		return template.impl.formalArguments != null
				&& template.impl.formalArguments.containsKey(arg);
	}
}