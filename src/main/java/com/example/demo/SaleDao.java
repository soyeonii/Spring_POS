package com.example.demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class SaleDao {
	private JdbcTemplate jdbcTemplate;

	public SaleDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<Sale> selectAll() {
		List<Sale> results = jdbcTemplate.query(
				"select number, sum(price * count) as 'price', saleDate from salerecord group by number",
				(ResultSet rs, int rowNum) -> {
					Sale sale = new Sale();
					sale.setNumber(rs.getInt("number"));
					sale.setPrice(rs.getInt("price"));
					sale.setSaleDate(rs.getString("saleDate"));
					return sale;
				});
		return results;
	}
	
	public List<Sale> getTotalByDate() {
		List<Sale> results = jdbcTemplate.query(
				"select date(saleDate) as 'date', sum(price * count) as 'sum' from salerecord group by date",
				(ResultSet rs, int rowNum) -> {
					Sale sale = new Sale();
					sale.setPrice(rs.getInt("sum"));
					sale.setSaleDate(rs.getString("date"));
					return sale;
				});
		return results;
	}
	
	public List<Sale> selectByNumber(String number) {
		List<Sale> results = jdbcTemplate.query(
				"select code, count from salerecord where number = '" + number + "'",
				(ResultSet rs, int rowNum) -> {
					Sale sale = new Sale();
					sale.setCode(rs.getString("code"));
					sale.setCount(rs.getInt("count"));
					return sale;
				});
		return results;
	}
	
	public Sale selectByDate(Date date) {
		List<Sale> results = jdbcTemplate.query("select * from saleRecord where saleDate = '" + date + "'",
				new RowMapper<Sale>() {
					@Override
					public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
						Sale sale = new Sale();
						sale.setNumber(rs.getInt("number"));
						sale.setCode(rs.getString("code"));
						sale.setPrice(rs.getInt("price"));
						sale.setCount(rs.getInt("count"));
						sale.setSaleDate(rs.getString("saleDate"));
						return sale;
					}
				});
		return results.isEmpty() ? null : results.get(0);
	}

	public int getNumber() {
		List<Sale> results = jdbcTemplate.query("select number from saleRecord order by number desc limit 1",
				new RowMapper<Sale>() {
					@Override
					public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
						Sale sale = new Sale();
						sale.setNumber(rs.getInt("number"));
						return sale;
					}
				});
		if (results.isEmpty())
			return 1;
		else
			return results.get(0).getNumber() + 1;
	}

	public int getSum(String period) {
		List<Sale> results = null;
		if (period.equals("day")) {
			results = jdbcTemplate.query(
					"select sum(price * count) as 'sum' from salerecord where date(saleDate) = date(now())",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setPrice(rs.getInt("sum"));
							return sale;
						}
					});
		} else if (period.equals("week")) {
			results = jdbcTemplate.query(
					"select sum(price * count) as 'sum' from salerecord where yearweek(saleDate) = yearweek(now())",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setPrice(rs.getInt("sum"));
							return sale;
						}
					});
		} else if (period.equals("month")) {
			results = jdbcTemplate.query(
					"select sum(price * count) as 'sum' from salerecord where month(saledate) = month(now())",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setPrice(rs.getInt("sum"));
							return sale;
						}
					});
		}
		return results.isEmpty() ? null : results.get(0).getPrice();
	}

	public List<Sale> getBest(String period) {
		List<Sale> results = null;
		if (period.equals("day")) {
			results = jdbcTemplate.query(
					"select code, sum(count) as 'sum' from salerecord where date(saleDate) = date(now()) group by code order by sum desc limit 3",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setCode(rs.getString("code"));
							sale.setCount(rs.getInt("sum"));
							return sale;
						}
					});
		} else if (period.equals("week")) {
			results = jdbcTemplate.query(
					"select code, sum(count) as 'sum' from salerecord where yearweek(saledate) = yearweek(now()) group by code order by sum desc limit 3",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setCode(rs.getString("code"));
							sale.setCount(rs.getInt("sum"));
							return sale;
						}
					});
		} else if (period.equals("month")) {
			results = jdbcTemplate.query(
					"select code, sum(count) as 'sum' from salerecord where month(saledate) = month(now()) group by code order by sum desc limit 3",
					new RowMapper<Sale>() {
						@Override
						public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
							Sale sale = new Sale();
							sale.setCode(rs.getString("code"));
							sale.setCount(rs.getInt("sum"));
							return sale;
						}
					});
		}
		return results;
	}

	public void insert(final Sale sale) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement("insert into saleRecord values (?,?,?,?,?)",
						new String[] { "ID" });
				pstmt.setInt(1, sale.getNumber());
				pstmt.setString(2, sale.getCode());
				pstmt.setInt(3, sale.getPrice());
				pstmt.setInt(4, sale.getCount());
				pstmt.setString(5, sale.getSaleDate());
				return pstmt;
			}
		}, keyHolder);
	}

	public void delete(String number) {
		jdbcTemplate.update("delete from saleRecord where number = ?", number);
	}
}
