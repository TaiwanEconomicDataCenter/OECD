package tedc.oecd.controller;

import java.io.IOException;
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
			for(Index index:indexSet) {
				String checked = request.getParameter(index.getName());
				if(checked!=null) {
					cart.addToCart(index);
				}else {
					cart.remove(index);
				}
			}
		} catch (TEDCException e) {
			this.log("加入索取清單失敗", e);
		} catch (Exception e) {
			this.log("加入索取清單，發生非預期錯誤", e);
		}
		//System.out.println(cart);
		//3.redirect to: /oecd/list/index_list.jsp
		response.sendRedirect(current_url);
	}

}
