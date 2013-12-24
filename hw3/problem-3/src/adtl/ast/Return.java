package adtl.ast;

/**
 * A node type for a return statement.
 * 
 * @author romanm
 */
public class Return extends Stmt {
	public final Expr retExpr;

	public Return(Expr retExpr) {
		this.retExpr = retExpr;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}