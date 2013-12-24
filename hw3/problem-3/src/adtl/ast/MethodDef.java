package adtl.ast;

/**
 * A node type for a method definition.
 * 
 * @author romanm
 * 
 */
public class MethodDef extends Element {
	public final String name;
	public final Args args;
	public final StmtList stmts;

	public MethodDef(String name, Args args, StmtList stmts) {
		this.name = name;
		this.args = args;
		this.stmts = stmts;
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}