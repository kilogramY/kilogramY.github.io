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
 * Servlet implementation class searchLecture
 */
@WebServlet("/searchLecture")
public class searchLecture extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchLecture() {
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
		String from = request.getParameter("from");
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		PrintWriter out = response.getWriter();
		
		ResultSet rs = DBUtil.getLecture (conn, lecNo, classNo);
		
		if (rs != null) {
			try {
				if (rs.next()) {
					request.setAttribute("flag","done");
					request.setAttribute("major",rs.getString(1));
					request.setAttribute("lecNo",rs.getString(2));
					request.setAttribute("lecName",rs.getString(3));
					request.setAttribute("classNo",rs.getString(4));
					request.setAttribute("day",rs.getString(5));
					request.setAttribute("time",rs.getString(6));
					request.setAttribute("professor",rs.getString(7));
					request.setAttribute("classroom",rs.getString(8));
					request.setAttribute("campus",rs.getString(9));
					
					RequestDispatcher view = request.getRequestDispatcher(from);
					view.forward(request, response);
				} else {
					out.println("<script type='text/javascript'>"
							+ "alert('해당 강의를 찾을 수 없습니다.');location.href='"+from+"';"
							+ "</script>");	
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
