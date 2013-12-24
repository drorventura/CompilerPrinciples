package adtl.ast;

import java.util.ArrayList;

/**
 * A node type for a path expression.
 * 
 * @author romanm
 */
public class PathExpr extends Expr {
	public final ArrayList<PathElement> positions = new ArrayList<>();

	public PathExpr(PathElement e) {
		positions.add(e);
	}
	
	public void append(PathElement e) {
		positions.add(e);
	}	
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}