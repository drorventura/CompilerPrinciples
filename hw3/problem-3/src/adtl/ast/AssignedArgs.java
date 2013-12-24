package adtl.ast;

import java.util.ArrayList;

import adtl.Pair;


/**
 * A node type for a elements of assignments to fields.
 * 
 * @author romanm
 */
public class AssignedArgs extends Node {
	public final ArrayList<Pair<String, Expr>> args = new ArrayList<>();

	public AssignedArgs() {
	}

	public AssignedArgs(String arg, Expr val) {
		args.add(new Pair<>(arg, val));
	}

	public void append(String arg, Expr val) {
		args.add(new Pair<>(arg, val));
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}
