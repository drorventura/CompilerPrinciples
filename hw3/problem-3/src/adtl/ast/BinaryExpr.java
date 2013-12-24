package adtl.ast;

/**
 * A node for all types of binary expressions.
 * 
 * @author romanm
 */
public class BinaryExpr extends Expr {
	public final Expr lhs;
	public final Expr rhs;
	public final Ops op;

	public BinaryExpr(Ops op, Expr lhs, Expr rhs) {
		assert op != null && lhs != null && rhs != null;
		this.op = op;
		this.lhs = lhs;
		this.rhs = rhs;
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}