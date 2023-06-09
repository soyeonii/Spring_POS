package com.example.demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class ReceiveDao {
	private JdbcTemplate jdbcTemplate;

	public ReceiveDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<Receive> selectAll() {
		List<Receive> results = jdbcTemplate.query(
				"select * from receiverecord",
				(ResultSet rs, int rowNum) -> {
					Receive receive = new Receive();
					receive.setCode(rs.getString("code"));
					receive.setCount(rs.getInt("count"));
					receive.setRegDate(rs.getString("regDate"));
					return receive;
				});
		return results;
	}

	public void insert(final Product product) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("insert into receiveRecord values (?, ?, now())",
						new String[] { "ID" });
				pstmt.setString(1, product.getCode());
				pstmt.setInt(2, product.getUnitsInStock());
				return pstmt;
			}
		}, keyHolder);
	}
}
