package adtl.ast;

/**
 * A node type for a size expression (size of a set).
 * 
 * @author romanm
 */
public class Size extends Expr {
	public final Expr sizeExpr;

	public Size(Expr expr) {
		this.sizeExpr = expr;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}

}