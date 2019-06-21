package javasrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;
import com.sun.corba.se.spi.orbutil.fsm.State;

public class DBUtil {
	static Connection conn = null;
	static Statement stmt = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;
	public static Connection getMySQLConnection() {	
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/mucktip?useUnicode=true&characterEncoding=utf8";
			String user = "root";
			String password = "alflarhkgkrrh1!";
			conn = DriverManager.getConnection(url, user, password);
		}catch(ClassNotFoundException e) {
			System.out.println("MySQL드라이버가 없습니다.<br/>");
		}catch(MySQLDataException e) {
			System.out.println("데이터베이스가 없습니다.<br/>");
		}catch(SQLException e) {
			System.out.println("사용자 아이디 또는 비밀번호가 일치하지 않습니다.<br/>");
		}
		return conn;
	}
	
	public static void close() {
		try {
			if(conn!=null) {conn.close();}
			if(stmt!=null) {stmt.close();}
			if(pstmt!=null) {pstmt.close();}
			if(rs!=null) {rs.close();}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
}
