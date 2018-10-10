package com.interntraining.admin.administrator.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.administrator.domain.AdministratorInfo;

@Repository("administratorDAO")
public class AdministratorDAO {

	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
	
	public List<AdministratorInfo> selectAdminList() {
		return sqlSession.selectList("administratorSql.selectAll");
	}

}
