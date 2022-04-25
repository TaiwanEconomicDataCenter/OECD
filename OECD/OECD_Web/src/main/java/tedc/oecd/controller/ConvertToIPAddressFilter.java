package tedc.oecd.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class ConvertToIPAddressFilter
 */
@WebFilter("/*")
public class ConvertToIPAddressFilter implements Filter {
	private String ipAddress,hostName;
    /**
     * Default constructor. 
     */
    public ConvertToIPAddressFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest)request;
        StringBuffer url = httpRequest.getRequestURL();
        //System.out.println("url = " + url);
        if(ipAddress==null) ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
        if(hostName==null) hostName = java.net.InetAddress.getLocalHost().getHostName().toLowerCase();
        //System.out.println("hostName = " + hostName);
        if(url.indexOf("//localhost")>0 || url.indexOf("//"+hostName)>0){
            String location;
            if(url.indexOf("//localhost")>0){
                 location = url.toString().replace("//localhost", "//"+ipAddress);
            }else{
                 location = url.toString().replace("//"+hostName, "//"+ipAddress);
            }
            ((HttpServletResponse)response).sendRedirect(location);
            return;
        }else{
            chain.doFilter(request, response);
        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
