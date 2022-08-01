package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn; // 커넥션 객체
	private PreparedStatement pstmt;  // 특정db에 sql문장 수행하도록 하는 class
	private ResultSet rs;  // sql 문장 수행이후 나온 결과값에 대해 처리하는 class
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassWord) {
		String SQL = "SELECT userPassWord FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // conn 객체에서 prepareStatement를 실행하도록 준비
			pstmt.setNString(1, userID); // sql 문장에 ? 값을 넣음
			rs = pstmt.executeQuery(); //실제로 SQL 문장을 데이터베이스에서 실행시킨 후 그 값을 rs에 담아준다.
			if (rs.next()) { // 검색이 되면 true
				if(rs.getNString(1).contentEquals(userPassWord)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, user.getUserID());
			pstmt.setNString(2, user.getUserPassWord());
			pstmt.setNString(3, user.getUserName());
			pstmt.setNString(4, user.getUserGender());
			pstmt.setNString(5, user.getUserEmail());
		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
