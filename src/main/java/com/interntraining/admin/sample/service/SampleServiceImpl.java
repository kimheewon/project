package com.interntraining.admin.sample.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.interntraining.admin.sample.dao.SampleDAO;
import com.interntraining.admin.sample.domain.Sample;

//----------------------------------------------------------------------
/**
 * ■샘플 인터페이스 구현부 ■ymkang ■2018. 09. 03.
 */
//----------------------------------------------------------------------
@Service()
public class SampleServiceImpl implements SampleService {
    @Resource(name = "sampleDAO")
    private SampleDAO sampleDAO;

    @Autowired
    @Qualifier("mainDBTransactionManager")
    private DataSourceTransactionManager transactionManager;

    //----------------------------------------------------------------------
    /**
     * ■샘플 목록 조회 서비스 ■ymkang ■2018. 09. 03.
     */
    //----------------------------------------------------------------------
    @Override
    @Transactional
    public List<Sample> selectSampleList(Sample sample) throws Exception {
    	sampleDAO.insertSample();

    	if(1 == 1)
    		transactionManager.rollback(null);

        return sampleDAO.selectSampleList(sample);
    }

}
