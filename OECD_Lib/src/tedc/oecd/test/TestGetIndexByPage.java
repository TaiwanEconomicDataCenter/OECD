package tedc.oecd.test;

import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;
import tedc.oecd.service.IndexService;

public class TestGetIndexByPage {

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.println("Bank:");
		String bank = scanner.next();
		System.out.println("page:");
		String pageString = scanner.next();
		int page = Integer.valueOf(pageString);
		scanner.close();
		
		IndexService iService = new IndexService();
		try {
			List<Index> list = iService.getIndexByPage(bank, page, Index.pageLimit);
			for(Index index:list) {
				System.out.println(index);
			}
		} catch (TEDCException e) {
			Logger.getLogger("以頁數查詢索引").log(Level.SEVERE, e.getMessage(), e);
			System.out.println("以頁數查詢索引發生錯誤: "+e.getMessage()); //for user(呈現在網頁上)
		} catch (Exception e) {
			Logger.getLogger("以頁數查詢索引").log(Level.SEVERE, "粉絲資料修改發生錯誤: "+e.getMessage(), e);
			System.out.println("以頁數查詢索引發生錯誤: "+e.getMessage()); //for user(呈現在網頁上)
		}
		
		System.out.println("\n\n程式結束");
		
	}

}
