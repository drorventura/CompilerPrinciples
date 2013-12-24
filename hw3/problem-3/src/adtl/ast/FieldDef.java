package adtl.ast;

/**
 * A node type for a method definition.
 * 
 * @author romanm
 * 
 */
public class FieldDef extends Element {
	public final String name;
	public final Type type;

	public FieldDef(String name, Type type) {
		this.name = name;
		this.type = type;
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}