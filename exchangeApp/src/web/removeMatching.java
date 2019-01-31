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
import javax.servlet.http.HttpSession;

import model.DBUtil;

/**
 * Servlet implementation class removeMatching
 */
@WebServlet("/removeMatching")
public class removeMatching extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public removeMatching() {
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
	    HttpSession se = request.getSession();
	    
		// 입력 정보 얻어오기
	    String lecNo = request.getParameter("lecNo");
	    String classWants = request.getParameter("classWants");
		String stu_no =String.valueOf(se.getAttribute("stu_no"));
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		PrintWriter out = response.getWriter();
		
		String result = DBUtil.removeFromMatching (conn, stu_no ,lecNo, classWants);
		
		if (result == "null") {
			out.println("<script type='text/javascript'>"
					+ "alert('교환 신청을 취소했습니다.');location.href='main.jsp';"
					+ "</script>");
		} else {
			out.println("<script type='text/javascript'>"
					+ "alert('ERROR:"+result+"');location.href='main.jsp';"
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
