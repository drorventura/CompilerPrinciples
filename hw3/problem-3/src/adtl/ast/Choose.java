package adtl.ast;

/**
 * A choice expression.
 * 
 * @author romanm
 */
public class Choose extends Expr {
	public final Expr setExpr;

	public Choose(Expr columnExpr, String index, StmtList stmts) {
		this.setExpr = columnExpr;
	}

	public Choose(Expr setExpr) {
		this.setExpr = setExpr;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}