package adtl.ast;

/**
 * A node type for a lock statement.
 * 
 * @author romanm
 */
public class Lock extends Stmt {
	public final PathExpr pathExpr;

	public Lock(PathExpr pathExpr) {
		this.pathExpr = pathExpr;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}