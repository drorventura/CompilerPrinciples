package adtl.ast;

/**
 * A node type for an element in a path expression.
 * 
 * @author romanm
 */
public class PathElement extends Element {
	public final String name;
	public final boolean reversed;
	public final boolean marked;

	public PathElement(String name, boolean reversed, boolean marked) {
		this.name = name;
		this.reversed = reversed;
		this.marked = marked;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}

}