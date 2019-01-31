package web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;

/**
 * Servlet implementation class addLecture
 */
@WebServlet("/addLecture")
public class addLecture extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addLecture() {
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
	    String major = request.getParameter("major");
		String lecNo = request.getParameter("lecNo");
		String lecName = request.getParameter("lecName");
		String classNo = request.getParameter("classNo");
		String professor = request.getParameter("professor");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		String campus = request.getParameter("campus");
		String building = request.getParameter("building");
		String classroom = request.getParameter("classroom");

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		String result = DBUtil.addLecture (conn, lecNo, lecName, classNo, professor, day, time, campus, building, classroom, major);
		
		if (result=="null") response.getWriter().println("<script>alert('강의 추가 완료.');location.href='addLecture.jsp';</script>");
		else response.getWriter().println("<script>alert(\"강의 추가 실패: "+result+"\");location.href='addLecture.jsp';</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
