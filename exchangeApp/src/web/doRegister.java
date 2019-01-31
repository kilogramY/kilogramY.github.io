package web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;

/**
 * Servlet implementation class doRegister
 */
@WebServlet("/doRegister")
public class doRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public doRegister() {
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
		
		// 입력 정보 얻어오기
		String uEmail = request.getParameter("email");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		String major = request.getParameter("major");
		String stu_no = request.getParameter("stu_no");
		String phone = request.getParameter("phone1")+request.getParameter("phone2")+request.getParameter("phone3");
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		String rs = DBUtil.insertUser(conn, uEmail, passwd, name, major, stu_no, phone);
		
		if (rs == "null") {
			response.getWriter().println("<script>alert('가입이 완료되었습니다. 로그인하세요.');location.href='main.html';</script>");
		} else {
			response.getWriter().println("<script>alert('가입 실패:"+rs+"');location.href='main.html';</script>");
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
