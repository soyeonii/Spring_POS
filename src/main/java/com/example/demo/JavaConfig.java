package com.example.demo;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JavaConfig {
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/springdb?characterEncoding=utf8&serverTimezone=UTC");
		ds.setUsername("spring5");
		ds.setPassword("spring5");
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
		return ds;
	}

	@Bean
	public ProductDao productDao() {
		return new ProductDao(dataSource());
	}

	@Bean
	public UserDao userDao() {
		return new UserDao(dataSource());
	}
	
	@Bean
	public SaleDao saleDao() {
		return new SaleDao(dataSource());
	}
	
	@Bean
	public ReceiveDao receiveDao() {
		return new ReceiveDao(dataSource());
	}
}