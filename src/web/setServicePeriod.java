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
 * Servlet implementation class setServicePeriod
 */
@WebServlet("/setServicePeriod")
public class setServicePeriod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public setServicePeriod() {
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
	    String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		ServletContext sc = getServletContext();
		Connection conn = (Connection) sc.getAttribute("DBconnection");

		String result = DBUtil.setTime(conn, start, end);
		
		if (result == "null") {
			response.getWriter().println("<script>alert('시스템 기간 설정이 완료되었습니다.');location.href='adminSetting.jsp';</script>");
		} else {
			response.getWriter().println("<script type='text/javascript'>"
					+ "alert(\"시스템 기간 설정에 실패했습니다:"+start+end+result+"\");location.href='adminSetting.jsp';"
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
