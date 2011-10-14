package com.loyalty;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class StartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    
    public StartServlet() {
        super();
       
    }
	public void init(ServletConfig config) throws ServletException {
		
/*		Configuration cfg = new Configuration();
		SessionFactory factory = cfg.configure().buildSessionFactory();
		session=factory.openSession();
*/	}
	public void destroy() {
/*		session.flush();
		session.close();
*/	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String clientUser = request.getParameter("username");
		String clientPass = request.getParameter("userpass");
		
		try
		{  
			response.sendRedirect("CommonServlet?Pagename=login&us="+clientUser+"&ps="+clientPass);	
		}
		catch(Exception e)
		{
		e.printStackTrace();
		}
		
	}

}
