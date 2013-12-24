package adtl.ast;

import java.util.ArrayList;

/**
 * A node type for lists of statements.
 * 
 * @author romanm 
 */
public class StmtList extends Stmt {
	public final ArrayList<Stmt> stmts = new ArrayList<Stmt>();

	public StmtList() {
	}

	public StmtList(Stmt stmt) {
		stmts.add(stmt);
	}

	public void append(Stmt stmt) {
		stmts.add(stmt);
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}