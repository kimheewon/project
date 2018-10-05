package com.interntraining.member.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;






@Repository("userDAO")
public class UserDAO {
	@Autowired
    @Qualifier("mainDBSqlSession")
	private SqlSession sqlSession;
		
	
}
