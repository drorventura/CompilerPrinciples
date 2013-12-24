package adtl.ast;

import java_cup.runtime.Symbol;

/**
 * The base class of all AST node types.
 * 
 * @author romanm
 */
public abstract class Node extends Symbol {
	public Node() {
		super(0);
	}

	public Node(int sym_num) {
		super(sym_num);
	}

	/**
	 * A counterpart for the corresponding visit method in {@link Visitor}.
	 * 
	 * @param v
	 *            A visitor.
	 * @return The result of visiting this node.
	 */
	public abstract <R> R accept(Visitor<R> v);
	
	@Override
	public String toString() {
		return ASTToString.stringer.toString(this);
	}
}