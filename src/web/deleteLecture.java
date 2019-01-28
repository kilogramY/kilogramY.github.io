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
 * Servlet implementation class deleteLecture
 */
@WebServlet("/deleteLecture")
public class deleteLecture extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteLecture() {
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
			    String lecNo = request.getParameter("lecNo");
			    String classNo = request.getParameter("classNo");
				String flag = request.getParameter("flag"); 
				
				ServletContext sc = getServletContext();
				Connection conn= (Connection) sc.getAttribute("DBconnection");
				
				PrintWriter out = response.getWriter();
				
				if (flag!=null) {
					String result = DBUtil.removeLecture (conn, lecNo, classNo);
					
					if (result == null) {
					out.println("<script type='text/javascript'>"
								+ "alert('해당 강의를 삭제했습니다."+"');location.href='removeLecture.jsp';"
								+ "</script>");
					} else {
						out.println("<script type='text/javascript'>"
								+ "alert('강의를 삭제할 수 없습니다:"+result+"');location.href='removeLecture.jsp';"
								+ "</script>");
					}
				} else {
					out.println("<script type='text/javascript'>"
							+ "alert('먼저 삭제하려는 강의를 검색해주세요.');location.href='removeLecture.jsp';"
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
