package ADTL;

import java.lang.reflect.Field;

import java_cup.runtime.Symbol;

/**
 * A basic lexical unit.
 * 
 */
public class Token extends Symbol
{
	public final int line;
	protected int number;
	protected String quote;
	private String text;

	public Token(int id, int line)
    {
		super(id, null);
		this.line = line;
	}

	public Token(String text, int id, int line)
    {
		super(id, null);
		this.line = line;
		this.text = text;
	}

	public Token(String text, int id, int line, String value)
    {
		super(id, value);
		this.line = line;
		this.quote = value;
		this.text = text;
	}

	public Token(String text, int id, int line, int value)
    {
		super(id, value);
		this.line = line;
		this.number = value;
		this.text = text;
	}

	public String toText()
    {
		return text;
	}

	public String toString()
    {
		Field[] fields = ADTL.sym.class.getFields();
		for (Field field : fields) {
			try {
				int val = field.getInt(field);
				if (val == sym) {
					String result = field.getName();
					if (sym == ADTL.sym.QUOTE || sym == ADTL.sym.ID)
						result += "(" + quote + ")";
					else if (sym == ADTL.sym.INT)
						result += "(" + number + ")";
					return result;
				}
			}
            catch (IllegalArgumentException | IllegalAccessException e)
            {
				e.printStackTrace();
			}
		}
		return null;
	}
}