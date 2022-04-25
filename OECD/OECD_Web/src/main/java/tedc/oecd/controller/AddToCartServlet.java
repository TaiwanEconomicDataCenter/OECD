package tedc.oecd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tedc.oecd.entity.Cart;
import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add_to_cart.do")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		List<String> errors = new ArrayList<>();
		String current_url = (String)session.getAttribute("current_url");
		
		//1.取得Form Data
		Set<Index> indexSet = (Set<Index>)session.getAttribute("indexSet");
		if(indexSet==null) {
			System.err.println("不存在indexSet!");
			response.sendRedirect(current_url);
			return;
		}
		Cart cart = (Cart)session.getAttribute("cart");
		if(cart==null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		
		//2.呼叫商業邏輯
		try {
			boolean legal = true;
			int currentSize = cart.getTotalSize();
			for(Index index:indexSet) {
				String checked = request.getParameter(index.getName());
				if(checked!=null&&!cart.contains(index)) currentSize+=1;
				else if(checked==null&&cart.contains(index)) currentSize-=1;
				if(currentSize>Cart.maxTotalSize) {
					errors.add("加入索取清單失敗，超過資料筆數上限: "+Cart.maxTotalSize+" (Adding items fail due to maximum size limit: "+Cart.maxTotalSize+")");
					legal = false;
					break;
				}
			}
			if(legal) {
				for(Index index:indexSet) {
					String checked = request.getParameter(index.getName());
					if(checked!=null) {
						cart.addToCart(index);
					}else {
						cart.remove(index);
					}
				}
			}
			
		} catch (TEDCException e) {
			this.log("加入索取清單失敗", e);
		} catch (Exception e) {
			this.log("加入索取清單，發生非預期錯誤", e);
		}
		//System.out.println(cart);
		
		if(errors.size()>0) {
			System.out.println(errors);
			session.setAttribute("error_message", errors);
		}else {
			session.removeAttribute("error_message");
		}
		
		//3.redirect to: /oecd/list/index_list.jsp
		String ajax = request.getParameter("ajax");
		//System.out.println("ajax: "+ajax);
		if(ajax==null) {
			if(errors.size()>0) {
				response.sendRedirect(current_url+"&error");
			}else {
				response.sendRedirect(current_url);
			}
		}else {
			//System.out.println("small_cart");
			request.getRequestDispatcher("/cart/small_cart.jsp").forward(request, response);
		}
		
	}

}
