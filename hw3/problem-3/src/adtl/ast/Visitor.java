package adtl.ast;

/**
 * An AST visitor class.
 * 
 * @author romanm
 * 
 * @param <R>
 *            The result type of visiting nodes.
 */
public class Visitor<R> {
	public R visit(Args node) {
		return handle(node);
	}

	public R visit(AssignedArgs node) {
		return handle(node);
	}

	public R visit(Assert node) {
		return handle(node);
	}

	public R visit(Assign node) {
		return handle(node);
	}

	public R visit(BinaryExpr node) {
		return handle(node);
	}

	public R visit(Choose node) {
		return handle(node);
	}

	public R visit(Condition node) {
		return handle(node);
	}

	public R visit(ElementList node) {
		return handle(node);
	}

	public R visit(ExprList node) {
		return handle(node);
	}
	
	public R visit(FieldDef node) {
		return handle(node);
	}
	
	public R visit(Lock node) {
		return handle(node);
	}

	public R visit(MethodDef node) {
		return handle(node);
	}

	public R visit(NewExpr node) {
		return handle(node);
	}
	
	public R visit(NotExpr node) {
		return handle(node);
	}

	public R visit(INT node) {
		return handle(node);
	}

	public R visit(PathExpr node) {
		return handle(node);
	}

	public R visit(ADT node) {
		return handle(node);
	}
	
	public R visit(PathElement node) {
		return handle(node);
	}

	public R visit(Return node) {
		return handle(node);
	}
	
	public R visit(Size node) {
		return handle(node);
	}
	
	public R visit(StmtList node) {
		return handle(node);
	}

	public R visit(Type node) {
		return handle(node);
	}
	
	/**
	 * A default node handling method.
	 */
	protected R handle(Node node) {
		return null;
	}
}