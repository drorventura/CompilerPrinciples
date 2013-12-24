package adtl.ast;

import java.util.ArrayList;

import adtl.Pair;


/**
 * A node type for a elements of formal arguments.
 * 
 * @author romanm
 */
public class Args extends Node {
	public final ArrayList<Pair<String, Type>> args = new ArrayList<>();

	public Args() {
	}

	public Args(String arg, Type t) {
		args.add(new Pair<>(arg, t));
	}

	public void append(String arg, Type t) {
		args.add(new Pair<>(arg, t));
	}

	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}