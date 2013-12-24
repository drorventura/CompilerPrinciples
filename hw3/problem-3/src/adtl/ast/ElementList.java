package adtl.ast;

import java.util.ArrayList;

/**
 * A node type for lists of elements.
 * 
 * @author romanm
 */
public class ElementList extends Node {
	public final ArrayList<Element> elements = new ArrayList<Element>();

	public ElementList() {
	}

	public ElementList(Element e) {
		elements.add(e);
	}

	public void append(Element e) {
		elements.add(e);
	}
	
	@Override
	public <R> R accept(Visitor<R> v) {
		return v.visit(this);
	}
}