package com.interntraining.member.common.database;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@EnableTransactionManagement
public class DataConfig {
	@Bean
	@ConfigurationProperties(prefix="maindb")
	public HikariConfig config() {
		return new HikariConfig();
	}

	@Bean(name="mainDBDataSource", destroyMethod="close")
	public DataSource dataSource() {
		return new HikariDataSource(config());
	}

	@Bean(name="mainDBTransactionManager")
	DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
}
