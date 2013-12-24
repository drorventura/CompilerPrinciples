package adtl.ast;

import java.util.ArrayList;

/**
 * The AST root node type.
 * 
 * @author romanm
 */
public class ADT extends Node {
	public final String name;
	public final ArrayList<Element> elements;

	public ADT(String name, ElementList elements) {
		this.name = name;
		this.elements = elements.elements;
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}