package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;

/**
 * Servlet implementation class checkAndGo
 */
@WebServlet("/checkAndGo")
public class checkAndGo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkAndGo() {
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
	    
		String passwd = request.getParameter("passwd");
		String stu_no = String.valueOf(request.getSession().getAttribute("stu_no"));
		
		ServletContext sc = getServletContext();
		Connection conn = (Connection) sc.getAttribute("DBconnection");
		
		ResultSet rs = DBUtil.isExist(conn, stu_no);
		
		PrintWriter out = response.getWriter();
		
		if (rs != null) {
			try {
				if(rs.next()) { 
					// existing user
					String checkpw = rs.getString(2);
					
					if (checkpw.equals(passwd)){
						out.println("<script>alert('회원 정보 변경 페이지로 이동합니다.');location.href='updateInfo.jsp'</script>");
					} else {
						out.println("<script>alert('비밀번호가 올바르지 않습니다. 다시 확인해주세요.');location.href='checkPW.jsp'</script>");
					}
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
