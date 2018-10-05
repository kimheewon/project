package com.interntraining.member.common.database;

import java.io.IOException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

//----------------------------------------------------------------------
/**
 * ■MybatisConfig(추상클래스) ■ymjo ■2017. 4. 13.
 */
//----------------------------------------------------------------------
public abstract class AbstractMybatisConfig {

	@Value("${mybatis.config-location}")
	private String strMybatisConfigLocation;

	@Value("${mybatis.mapper-location}")
	private String strMybatisMapperLocation;

	public abstract SqlSessionFactory dbSqlSessionFactory(DataSource objDataSource) throws Exception;
	public abstract SqlSession dbSqlSession(SqlSessionFactory objSqlSessionFactory) throws Exception;

	//----------------------------------------------------------------------
	/**
	 * ■ymjo ■2017. 4. 18.
	 * @param objSqlSessionFactoryBean
	 * @param objDataSource
	 * @throws IOException
	 * @version 1.0
	 * @see
	 */
	//----------------------------------------------------------------------
	protected void configureSqlSessionFactory(SqlSessionFactoryBean objSqlSessionFactoryBean, DataSource objDataSource) throws IOException {
		PathMatchingResourcePatternResolver objPathResolver = new PathMatchingResourcePatternResolver();

		objSqlSessionFactoryBean.setDataSource(objDataSource);
		objSqlSessionFactoryBean.setConfigLocation(objPathResolver.getResource(strMybatisConfigLocation));
		objSqlSessionFactoryBean.setMapperLocations(objPathResolver.getResources(strMybatisMapperLocation));
		objSqlSessionFactoryBean.setTypeAliasesPackage("com.interntraining.member.**.domain");
		objSqlSessionFactoryBean.setVfs(SpringBootVFS.class);
	}
}
