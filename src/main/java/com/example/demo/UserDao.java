package com.example.demo;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class UserDao {
	private JdbcTemplate jdbcTemplate;

	public UserDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public User selectById(String id) {
		List<User> results = jdbcTemplate.query("select * from user where id = '" + id + "'", new RowMapper<User>() {
			@Override
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User user = new User(rs.getString("id"), rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				return user;
			}
		});
		return results.isEmpty() ? null : results.get(0);
	}

	public void update(User user) {
		jdbcTemplate.update("update user set password=?, name=?, email=? where id=?", user.getPassword(),
				user.getName(), user.getEmail(), user.getId());
	}

	public void insert(final User user) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("insert into user values (?,?,?,?)",
						new String[] { "ID" });
				pstmt.setString(1, user.getId());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setString(4, user.getEmail());
				return pstmt;
			}
		}, keyHolder);
	}

	public void delete(String id) {
		jdbcTemplate.update("delete from user where id = ?", id);
	}
}
