package adtl.ast;

import java.util.ArrayList;

/**
 * A node type for lists of expressions.
 * 
 * @author romanm
 * 
 */
public class ExprList extends Node {
	public final ArrayList<Expr> list = new ArrayList<Expr>();

	public ExprList() {
	}

	public ExprList(Expr e) {
		list.add(e);
	}

	public void append(Expr e) {
		list.add(e);
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}