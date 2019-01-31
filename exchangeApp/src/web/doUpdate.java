package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;

/**
 * Servlet implementation class doUpdate
 */
@WebServlet("/doUpdate")
public class doUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public doUpdate() {
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
	    String passwd = request.getParameter("passwd");
	    String name = request.getParameter("name");
	    String major = request.getParameter("major");
	    String phone = request.getParameter("phone");
	    String stu_no = String.valueOf(request.getSession().getAttribute("stu_no"));
	    
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		PrintWriter out = response.getWriter();
		
		String result = DBUtil.updateUser(conn, passwd, name, major, stu_no, phone);
			
		if (result=="success") {
			out.println("<script type='text/javascript'>"
					+ "alert('회원정보가 수정되었습니다. 다시 로그인해주세요.');location.href='main.html';"
					+ "</script>");
			request.getSession().invalidate();
		} else {
			out.println("<script type='text/javascript'>"
					+ "alert('정보를 수정할 수 없습니다:"+result+"');location.href='updateInfo.jsp';"
					+ "</script>");
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
