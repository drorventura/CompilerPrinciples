package adtl.ast;

/**
 * A node type for integer literals.
 * 
 * @author romanm
 */
public class INT extends Expr {
	public final int value;

	public INT(int value) {
		this.value = value;
	}

	public String toString() {
		return "" + value;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}