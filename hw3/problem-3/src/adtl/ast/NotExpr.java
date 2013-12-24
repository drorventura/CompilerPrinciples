package adtl.ast;

/**
 * A logical negation node type.
 * 
 * @author romanm
 * 
 */
public class NotExpr extends Expr {
	public final Expr subExpr;

	public NotExpr(Expr subExpr) {
		this.subExpr = subExpr;
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}