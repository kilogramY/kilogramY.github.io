package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	
	public static ResultSet findUser(Connection con, String uemail) {
		String sqlSt = "SELECT passwd,major,stu_no,name FROM user WHERE email=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + uemail + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet findEmail(Connection con, String name, String phone) {
		String sqlSt = "SELECT email FROM user WHERE name=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + name + "' AND phone='"+phone+"'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet findPW(Connection con, String email, String stu_no) {
		String sqlSt = "SELECT stu_no,name FROM user WHERE email=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + email + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;		
	}
	
	
	public static ResultSet updatePW(Connection conn, String passwd, String email) {
		PreparedStatement pstmt=null;
		String sqlSt = "UPDATE user SET passwd=? WHERE email=?";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, passwd);
			pstmt.setString(2, email);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
	
	public static String updateUser(Connection conn, String passwd, String name, String major, String stu_no, String phone) {
		PreparedStatement pstmt=null;
		String sqlSt = "UPDATE user SET passwd=?, name=?, major=?, phone=? WHERE stu_no=?";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, passwd);
			pstmt.setString(2, name);
			pstmt.setString(3, major);
			pstmt.setString(4, phone);
			pstmt.setString(5, stu_no);
			
			pstmt.executeUpdate();
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		
		return "success";
	}
	
	public static String insertUser (Connection conn, String email, String passwd, String name, String major, String stu_no, String phone) {
		PreparedStatement pstmt=null;
		String sqlSt = "INSERT INTO user VALUES(?,?,?,?,?,?)";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, email);
			pstmt.setString(2, passwd);
			pstmt.setString(3, name);
			pstmt.setString(4, major);
			pstmt.setString(5, stu_no);
			pstmt.setString(6, phone);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		
		
		return "null";
	}
	
	public static ResultSet isExist(Connection con, String stu_no) {
		String sqlSt = "SELECT * FROM user WHERE stu_no=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String addLecture (Connection conn, String lecNo, String lecName, String classNo, String professor, String day, String time, String campus, String building, String classroom, String major) {
		PreparedStatement pstmt=null;
		String sqlSt = "INSERT INTO lectures VALUES(?,?,?,?,?,?,?,?,?)";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, major);
			pstmt.setString(2, lecNo);
			pstmt.setString(3, lecName);
			pstmt.setString(4, classNo);
			pstmt.setString(5, day);
			pstmt.setString(6, time);
			pstmt.setString(7, professor);
			pstmt.setString(8, building+" "+classroom+"호");
			pstmt.setString(9, campus);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return e.toString();

		}
		return "null";
	}
	
	public static ResultSet getLecture(Connection con) {
		String sqlSt = "SELECT DISTINCT major FROM lectures";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt)) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet getLecture(Connection con, String major) {
		String sqlSt = "SELECT DISTINT lecName FROM lectures WHERE major='";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt+major+"'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet getLecture(Connection con, String lecNo, String classNo) {
		String sqlSt = "SELECT * FROM lectures WHERE lecNo=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + lecNo + "' AND classNo='"+classNo+"'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String removeLecture (Connection con, String lecNo, String classNo) {
			String sqlSt = "DELETE FROM lectures WHERE lecNo=";

			Statement st;
			try {
				st = con.createStatement();

				if (st.execute(sqlSt + "'" + lecNo + "' AND classNo='"+classNo+"'")) {

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return e.toString();
			}
			return null;
	}
	
	public static String updateLecture (Connection conn, String lecNo, String lecName, String classNo, String professor, String day, String time, String campus, String classroom, String major) {
		PreparedStatement pstmt=null;
		String sqlSt = "UPDATE lectures SET lecName=?, professor=?, day=?, time=?, campus=?, classroom=?, major=? WHERE lecNo=? AND classNo=?";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, lecName);
			pstmt.setString(2, professor);
			pstmt.setString(3, day);
			pstmt.setString(4, time);
			pstmt.setString(5, campus);
			pstmt.setString(6, classroom);
			pstmt.setString(7, major);
			pstmt.setString(8, lecNo);
			pstmt.setString(9, classNo);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return e.toString();

		}
		return "null";
	}
	
	public static ResultSet loadTimetable(Connection con, String stu_no) {
		String sqlSt = "SELECT lectures.lecNo, lecName, classNo, day, time, professor FROM sugang , lectures WHERE sugang.lecNo=lectures.lecNo AND sugang.class=lectures.classNo AND stu_no=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String addMyLecList (Connection conn, String stu_no, String lecNo, String classNo) {
		PreparedStatement pstmt=null;
		String sqlSt = "INSERT INTO sugang VALUES(?,?,?)";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, stu_no);
			pstmt.setString(2, lecNo);
			pstmt.setString(3, classNo);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return e.toString();

		}
		return "null";
	}
	
	public static String removeMyLecList (Connection conn, String stu_no, String lecNo, String classNo) {
		String sqlSt = "DELETE FROM sugang WHERE stu_no=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "' AND lecNo='"+lecNo+"' AND class="+classNo)) {

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		return "null";
	}
	
	public static int countClass (Connection conn, String lecNo) {
		String sqlSt = "SELECT count(*) from lectures where lecNo=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + lecNo + "'")) {

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	
	public static ResultSet getAllClass (Connection conn, String lecNo) {
		String sqlSt = "SELECT * from lectures where lecNo=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + lecNo + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet getNumberOfClass (Connection conn, String lecNo) {
		String sqlSt = "SELECT count(*) from lectures where lecNo=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + lecNo + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String exchangeClass (Connection conn, String stu_no, String lecNo, String classNow, String classWants) {
		ResultSet forReturn = null;
		String sqlSt = "SELECT * FROM matching WHERE lecNo=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + lecNo + "' AND classNow='"+classWants+"' AND classWants='"+classNow+"' order by registeredTime")) {
					if (st.getResultSet().next()) {
					forReturn = st.getResultSet();
					String exchangewith = forReturn.getString(1);
				
					//log에 변경 이력 추가하기
					st.execute("INSERT INTO logs VALUES('"+exchangewith+"','"+stu_no+"','"+lecNo+"',"+classNow+","+classWants+",NOW())");
					
					//교환한 사람들 수강정보 바꾸기
					PreparedStatement pstmt=null;
					String updateSt = "UPDATE sugang SET class=? WHERE stu_no=? AND lecNo=?";
					
					try {
						pstmt=(PreparedStatement) conn.prepareStatement(updateSt);
						//신청자의 수강정보 바꾸기
						pstmt.setString(1, classWants);
						pstmt.setString(2, stu_no);
						pstmt.setString(3, lecNo);
						
						pstmt.executeUpdate();
						
						//대기자의 수강정보 바꾸기
						pstmt.setString(1, classNow);
						pstmt.setString(2, exchangewith);
						pstmt.setString(3, lecNo);
						
						pstmt.executeUpdate();
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						 e.printStackTrace();
					}
					
					//검색해서 매칭된 row 삭제하기
					st.execute("DELETE FROM matching WHERE lecNo='" + lecNo + "' AND classNow='"+classWants+"' AND classWants='"+classNow+"' AND stu_no='"+exchangewith+"'");
										
				} else {
				//교환할 row 존재 안함
					return "waiting";
				} 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		return "success";
	}
	
	public static String addtoMatching (Connection conn, String stu_no, String lecNo, String classNow, String classWants) {
		PreparedStatement pstmt=null;
		String waitingSt = "INSERT INTO matching VALUES(?,?,?,?,NOW())";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(waitingSt);
			pstmt.setString(1, stu_no);
			pstmt.setString(2, lecNo);
			pstmt.setString(3, classNow);
			pstmt.setString(4, classWants);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return e.toString();

		}
		return "null";
	}
	
	public static String removeUser (Connection conn, String stu_no) {
		String sqlSt = "DELETE FROM user WHERE stu_no=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "'")) {

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		return "null";
	}
	
	public static ResultSet searchMatching (Connection conn, String stu_no, String lecNo) {
		String sqlSt = "SELECT * from matching WHERE stu_no=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "' AND lecNo='"+lecNo+"'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet searchLogs (Connection conn, String stu_no, String lecNo) {
		String sqlSt = "SELECT * from logs WHERE (waiter=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "' OR dealer='"+stu_no+"') AND lecNo='"+lecNo+"'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String removeFromMatching (Connection conn, String stu_no, String lecNo, String classWants) {
		String sqlSt = "DELETE FROM matching WHERE stu_no=";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt + "'" + stu_no + "' AND lecNo='"+lecNo+"' AND classWants="+classWants)) {

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.toString();
		}
		return "null";
	}
	
	public static ResultSet getSettingTime (Connection conn) {
		String sqlSt = "SELECT DATE_FORMAT(CURDATE( ), '%Y%m%d' ),start,end FROM settingtime";

		Statement st;
		try {
			st = conn.createStatement();

			if (st.execute(sqlSt)) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static String setTime (Connection conn, String start, String end) {
		PreparedStatement pstmt=null;
		String sqlSt = "UPDATE settingtime SET start=?, end=? WHERE no=?";
		
		try {
			pstmt=(PreparedStatement) conn.prepareStatement(sqlSt);
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			pstmt.setString(3, "1");
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			 return e.toString();

		}
		return "null";
	}
}
