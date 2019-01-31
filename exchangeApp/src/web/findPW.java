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
 * Servlet implementation class findPW
 */
@WebServlet("/findPW")
public class findPW extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public findPW() {
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
		
	    // �̸���, ����ó ���
		String email = request.getParameter("email");
		String stu_no = request.getParameter("stu_no");
		String sendTime = String.valueOf(System.currentTimeMillis());
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		ResultSet rs = DBUtil.findPW(conn, email, stu_no);
		
		PrintWriter out = response.getWriter();

		if (rs != null) {
			try {
				if(rs.next()) { 
					// existing user
					String checkStu_no = rs.getString(1);
					
					if (checkStu_no.equals(stu_no)){
						
						request.setAttribute("sendTime", sendTime);//보낸시간을 sendTime으로 넘겨줌
						request.setAttribute("email", email);//email을 넘겨줌
						
						RequestDispatcher view = request.getRequestDispatcher("MailSend.jsp");
						view.forward(request, response);
						}
					else {
						// Wrong Info
						out.println("<script type='text/javascript'>"
								+ "alert('이메일 주소와 학번을 다시 확인하세요.');location.href='findEmailPW.html'"
								+ "</script>");				
					}
				}
				else {
					// invalid user
					out.println("<script type='text/javascript'>"
							+ "alert('등록된 이메일 주소가 아닙니다.');location.href='findEmailPW.html'"
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
