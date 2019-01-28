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
 * Servlet implementation class addLecture
 */
@WebServlet("/removeMyLecList")
public class removeMyLecList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public removeMyLecList() {
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
	    String classNo = request.getParameter("classNo");
		String stu_no =String.valueOf(se.getAttribute("stu_no"));
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		PrintWriter out = response.getWriter();
		
		String result = DBUtil.removeMyLecList (conn, stu_no ,lecNo, classNo);
			
			if (result == "null") {
			out.println("<script type='text/javascript'>"
						+ "alert('수강목록에서 삭제하였습니다."+"');location.href='myPage.jsp';"
						+ "</script>");
			} else {
				out.println("<script>"
						+ "alert('삭제할 수 없습니다:"+result+"');location.href='myPage.jsp';"
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
