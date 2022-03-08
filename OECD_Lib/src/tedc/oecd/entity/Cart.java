package tedc.oecd.entity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import tedc.oecd.exception.TEDCException;

public class Cart {
	private Map<Frequency, Set<Index>> cartMap = new HashMap<>();

	public int size() {
		return cartMap.size();
	}

	public boolean isEmpty() {
		return cartMap.isEmpty();
	}

	public Set<Index> getSetByFrequency(Frequency freq) {
		return cartMap.get(freq);
	}

	public int getSetSizeByFrequency(Frequency freq) {
		if(cartMap.get(freq)!=null) {
			return cartMap.get(freq).size();
		}else {
			return 0;
		}
	}
	public int getTotalSize() {
		int sum = 0;
		for(Frequency freq: Frequency.values()) {
			sum += this.getSetSizeByFrequency(freq);
		}
		return sum;
	}
	
	public void addToCart(Frequency freq, Set<Index> indexList) throws TEDCException {
		if(freq==null) throw new IllegalArgumentException("頻率不得為null!");
		cartMap.put(freq, indexList);
	}
	public void addToCart(Index index) throws TEDCException {
		if(index==null) throw new IllegalArgumentException("索引不得為null!");
		if(index.getTimeRange()==null) throw new IllegalArgumentException("索引時間範圍不得為null!");
		Frequency freq = index.getTimeRange().getFreq();
		
		Set<Index> indexSet = null;
		Set<Index> originalSet = cartMap.get(freq);
		if(originalSet!=null) {
			indexSet = originalSet;
		}else {
			indexSet = new HashSet<>();
		}
		indexSet.add(index);
		cartMap.put(freq, indexSet);
	}

	public void remove(Frequency freq) {
		cartMap.remove(freq);
	}
	public void remove(Index index) throws TEDCException {
		if(index==null) throw new IllegalArgumentException("索引不得為null!");
		if(index.getTimeRange()==null) throw new IllegalArgumentException("索引時間範圍不得為null!");
		Frequency freq = index.getTimeRange().getFreq();
		if(freq==null) throw new IllegalArgumentException("頻率不得為null!");
		
		Set<Index> set = cartMap.get(freq);
		set.remove(index);
		cartMap.put(freq, set);
	}

	public Set<Frequency> keySet() {
		return new HashSet<>(cartMap.keySet());
	}

	@Override
	public String toString() {
		return "Cart [cartMap=" + cartMap + "]";
	}
	
}
