package adtl.ast;

import java.lang.reflect.Field;

import org.stringtemplate.v4.ST;

import adtl.STGLoader;


public class ASTToString extends Visitor<String> {
	protected static STGLoader templates = new STGLoader(ASTToString.class);

	public static ASTToString stringer = new ASTToString();

	public String toString(Node node) {
		return node.accept(this);
	}

	@Override
	protected String handle(Node node) {
		// Use reflection to get the name of the template - should be the same
		// as the name of the AST node class.
		ST template = templates.load(node.getClass().getSimpleName());
		if (template == null)
			throw new Error("Missing or bad template for " + node.getClass().getSimpleName());

		// Get the names of the template attributes and then use reflection
		// to set the values of the corresponding fields in the node object.
		for (String formalArg : template.impl.formalArguments.keySet()) {
			try {
				Field attributeFIeld = node.getClass().getField(formalArg);
				Object fieldValue = attributeFIeld.get(node);
				template.add(formalArg, fieldValue);
			} catch (NoSuchFieldException | IllegalArgumentException
					| IllegalAccessException | SecurityException e) {
				e.printStackTrace();
			}
		}
		return template.render();
	}

	public boolean hasArgument(ST template, String arg) {
		return template.impl.formalArguments != null
				&& template.impl.formalArguments.containsKey(arg);
	}
}