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

public class ProductDao {
	private JdbcTemplate jdbcTemplate;

	public ProductDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<Product> selectAll() {
		List<Product> results = jdbcTemplate.query("select * from product", (ResultSet rs, int rowNum) -> {
			Product product = new Product(rs.getString("code"), rs.getString("name"), rs.getInt("price"),
					rs.getInt("unitsInStock"), rs.getString("manufacturer"));
			return product;
		});
		return results;
	}

	public List<Product> selectByCode(String code) {
		List<Product> results = jdbcTemplate.query("select * from product where code = '" + code + "'",
				new RowMapper<Product>() {
					@Override
					public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
						Product product = new Product(rs.getString("code"), rs.getString("name"), rs.getInt("price"),
								rs.getInt("unitsInStock"), rs.getString("manufacturer"));
						return product;
					}
				});
		return results;
	}

	public int count() {
		Integer count = jdbcTemplate.queryForObject("select count(*) from product", Integer.class);
		return count;
	}

	public void update(Product product) {
		jdbcTemplate.update("update product set name=?, price=?, unitsInStock=?, manufacturer=? where code=?",
				product.getName(), product.getPrice(), product.getUnitsInStock(), product.getManufacturer(),
				product.getCode());
	}

	public void insert(final Product product) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("insert into product values (?, ?, ?, ?, ?)",
						new String[] { "ID" });
				pstmt.setString(1, product.getCode());
				pstmt.setString(2, product.getName());
				pstmt.setInt(3, product.getPrice());
				pstmt.setInt(4, product.getUnitsInStock());
				pstmt.setString(5, product.getManufacturer());
				return pstmt;
			}
		}, keyHolder);
	}

	public void delete(String code) {
		jdbcTemplate.update("set foreign_key_checks = 0");
		jdbcTemplate.update("delete from product where code = ?", code);
		jdbcTemplate.update("set foreign_key_checks = 1");
		
	}
}