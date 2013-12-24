package adtl.ast;

/**
 * A node type for variable and field types.
 * 
 * @author romanm
 */
public class Type extends Element {
	public static final String setTypeName = "set";

	public final String name;

	public Type(String name) {
		this.name = name;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}