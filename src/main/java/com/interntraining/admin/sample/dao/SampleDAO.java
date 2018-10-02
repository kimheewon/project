package com.interntraining.admin.sample.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.interntraining.admin.sample.domain.Sample;

@Repository("sampleDAO")
public class SampleDAO {
    @Autowired
    @Qualifier("mainDBSqlSession")
    private SqlSession sqlSession;

    public void insertSample() throws Exception {
    	sqlSession.insert("sample.insertSample");
    }

	public List<Sample> selectSampleList(Sample sample) throws Exception {
		return sqlSession.selectList("sample.selectSample", sample);
	}
}
