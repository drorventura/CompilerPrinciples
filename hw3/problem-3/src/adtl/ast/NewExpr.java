package adtl.ast;

import java.util.ArrayList;

import adtl.Pair;

/**
 * A node type for table access expressions.
 * 
 * @author romanm
 */
public class NewExpr extends Expr {
	public final Type type;
	public final ArrayList<Pair<String, Expr>> args;

	public NewExpr(Type type, AssignedArgs args) {
		this.type = type;
		this.args = args.args;
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}