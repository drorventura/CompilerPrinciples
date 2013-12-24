package adtl.ast;

/**
 * Enumeration of operator types that may appear in expressions.
 * @author romanm
 */
public enum Ops {
	PLUS,	// +
	MINUS,	// -
	TIMES,	// *
	DIVIDE,	// /
	LT,		// <
	LTE,	// <=
	GT,		// >
	GTE,	// >=
	EQ,		// ==
	IN,		// in
	NEQ,	// !=
	NOT,	// !
	LAND,	// &&
	LOR;	// ||
	
	public boolean isAssociative() {
		switch (this) {
		case PLUS: 		return true;
		case MINUS:		return true;
		case TIMES:		return true;
		case DIVIDE:	return false;
		case LT:		return false;
		case LTE:		return false;
		case GT:		return false;
		case GTE:		return false;
		case EQ:		return false;
		case IN:		return false;
		case NEQ:		return false;
		case NOT:		return false;
		case LAND:		return true;
		case LOR:		return true;
			default:
				throw new Error("Encountered unknown operator : " + super.toString());
		}		
	}
	
	public String toString() {
		switch (this) {
		case PLUS: 		return "+";
		case MINUS:		return "-";
		case TIMES:		return "*";
		case DIVIDE:	return "/";
		case LT:		return "<";
		case LTE:		return "<=";
		case GT:		return ">";
		case GTE:		return ">=";
		case EQ:		return "==";
		case IN:		return "in";
		case NEQ:		return "!=";
		case NOT:		return "!";
		case LAND:		return "&&";
		case LOR:		return "||";
			default:
				throw new Error("Encountered unknown operator : " + super.toString());
		}
	}
}