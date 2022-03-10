package tedc.oecd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tedc.oecd.entity.Cart;
import tedc.oecd.entity.Frequency;
import tedc.oecd.entity.Index;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		
		if(cart!=null && cart.size()>0) {
			String frequency = request.getParameter("frequency");
			if(frequency!=null && Frequency.checkFrequency(frequency)) {
				Frequency freq = Frequency.valueOf(frequency);
				String deleteAll = request.getParameter("deleteAll");
				if(deleteAll!=null) {
					cart.remove(freq);
					response.sendRedirect(request.getContextPath()+"/cart/cart.jsp?freq="+frequency);
					
					return;
				}else {
					for(Index index:cart.getSetByFrequency(freq)) {
						String delete = request.getParameter(index.getName());
						if(delete!=null) {
							cart.remove(index);
						}
					}
					response.sendRedirect(request.getContextPath()+"/cart/cart.jsp?freq="+frequency);
					
					return;
				}
			}
		}
		response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
	}

}
