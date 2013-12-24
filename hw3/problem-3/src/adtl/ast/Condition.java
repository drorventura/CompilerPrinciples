package adtl.ast;

/**
 * A node type for condition statements.
 * 
 * @author romanm
 */
public class Condition extends Stmt {
	public final Expr cond;
	public final Stmt thenStmt;
	public final Stmt elseStmt;

	/**
	 * An if-then-else condition.
	 */
	public Condition(Expr cond, Stmt thenExpr, Stmt elseExpr) {
		this.cond = cond;
		this.thenStmt = thenExpr;
		this.elseStmt = elseExpr;
	}

	/**
	 * An if-then condition.
	 */
	public Condition(Expr cond, Stmt thenExpr) {
		this.cond = cond;
		this.thenStmt = thenExpr;
		this.elseStmt = null;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}