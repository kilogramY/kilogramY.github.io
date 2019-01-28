package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;

/**
 * Servlet implementation class findEmail
 */
@WebServlet("/findEmail")
public class findEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public findEmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html");		
		
		// 이름, 전화번호 얻기
		String name = request.getParameter("uname");
		String phone = request.getParameter("phone1")+request.getParameter("phone2")+request.getParameter("phone3");
		System.out.println(name+phone);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		ResultSet rs = DBUtil.findEmail(conn, name, phone);
		
		if (rs != null) {
			try {
				if(rs.next()) { 
					// existing user
					request.setAttribute("result", rs.getString(1));
					
					RequestDispatcher view = request.getRequestDispatcher("findEmailPopup.jsp");
					view.forward(request, response);					
				} else {
					// invalid user
					request.setAttribute("result", "invalid");
					
					RequestDispatcher view = request.getRequestDispatcher("findEmailPopup.jsp");
					view.forward(request, response);
				}			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
