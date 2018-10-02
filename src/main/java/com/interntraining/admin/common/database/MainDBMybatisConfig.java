package com.interntraining.admin.common.database;

import javax.sql.DataSource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

//----------------------------------------------------------------------
/**
 * ■MainDBMybatisConfig ■ymjo ■2017. 4. 13.
 */
//----------------------------------------------------------------------
@Configuration
public class MainDBMybatisConfig extends AbstractMybatisConfig {
    private static final Logger objLogger = LoggerFactory.getLogger(MainDBMybatisConfig.class);

    //----------------------------------------------------------------------
    /**
     * ■ymjo ■2017. 4. 18.
     * @param objDataSource
     * @return SqlSessionFactory
     * @throws Exception
     * @version 1.0
     * @see
     */
    //----------------------------------------------------------------------
    @Override
    @Primary
    @Bean(name="mainDBSqlSessionFactory")
    public SqlSessionFactory dbSqlSessionFactory(DataSource objDataSource) throws Exception {
        SqlSessionFactoryBean objSqlSessionFactoryBean = new SqlSessionFactoryBean();

        configureSqlSessionFactory(objSqlSessionFactoryBean, objDataSource);

        if (objLogger.isDebugEnabled()) {
            objLogger.debug(objSqlSessionFactoryBean.toString());
        }

        return objSqlSessionFactoryBean.getObject();
    }

    //----------------------------------------------------------------------
    /**
     * ■ymjo ■2017. 4. 18.
     * @param objSqlSessionFactory
     * @return SqlSession
     * @throws Exception
     * @version 1.0
     * @see
     */
    //----------------------------------------------------------------------
    @Primary
    @Bean(name="mainDBSqlSession")
    public SqlSession dbSqlSession(@Qualifier("mainDBSqlSessionFactory") SqlSessionFactory objSqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(objSqlSessionFactory);
    }
}
