package adtl;

/**
 * A generic ordered-pair-of-elements type.
 * 
 * @author romanm
 * 
 * @param <Type1>
 *            The type of the first element.
 * @param <Type2>
 *            The type of the second element.
 */
public class Pair<Type1, Type2> {
	public final Type1 first;
	public final Type2 second;

	public Pair(Type1 first, Type2 second) {
		this.first = first;
		this.second = second;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((first == null) ? 0 : first.hashCode());
		result = prime * result + ((second == null) ? 0 : second.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		@SuppressWarnings("unchecked")
		Pair<Type1, Type2> other = (Pair<Type1, Type2>) obj;
		if (first == null) {
			if (other.first != null)
				return false;
		} else if (!first.equals(other.first))
			return false;
		if (second == null) {
			if (other.second != null)
				return false;
		} else if (!second.equals(other.second))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "(" + first + ", " + second + ")";
	}
}