package adtl.ast;

/**
 * A node type for assertions.
 * 
 * @author romanm
 */
public class Assert extends Stmt {
	public final Expr cond;
	public final String message;

	public Assert(Expr cond, String message) {
		this.cond = cond;
		this.message = message;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}