package com.interntraining.admin.sample.service;

import java.util.List;

import com.interntraining.admin.sample.domain.Sample;


//----------------------------------------------------------------------
/**
 * ■샘플 인터페이스 ■ymkang ■2018. 09. 03.
 */
//----------------------------------------------------------------------
public interface SampleService {
    public List<Sample> selectSampleList(Sample sample) throws Exception;
}
