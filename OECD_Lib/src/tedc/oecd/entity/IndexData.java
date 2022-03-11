package tedc.oecd.entity;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class IndexData {
	private Index index;
	private Map<Object, Double> dataMap = new TreeMap<>();
	
	public Index getIndex() {
		return index;
	}
	public void setIndex(Index index) {
		this.index = index;
	}
	public int size() {
		return dataMap.size();
	}
	public boolean isEmpty() {
		return dataMap.isEmpty();
	}
	public Double getData(Object key) {
		return dataMap.get(key);
	}
	public Double inputData(Object key, Double value) {
		return dataMap.put(key, value);
	}
	public Double remove(Object key) {
		return dataMap.remove(key);
	}
	public Set<Object> getTimeSet() {
		return new HashSet<>(dataMap.keySet());
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((index == null) ? 0 : index.hashCode());
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
		IndexData other = (IndexData) obj;
		if (index == null) {
			if (other.index != null)
				return false;
		} else if (!index.equals(other.index))
			return false;
		return true;
	}
	
}
