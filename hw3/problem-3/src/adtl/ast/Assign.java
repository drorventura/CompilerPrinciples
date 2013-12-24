package adtl.ast;

/**
 * A node type for an assignment to a variable or a field.
 * 
 * @author romanm
 */
public class Assign extends Stmt {
	public final PathExpr lhs;
	public final Expr rhs;

	public Assign(PathExpr lhs, Expr rhs) {
		this.lhs = lhs;
		this.rhs = rhs;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}