package com.interntraining.admin.sample.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.interntraining.admin.sample.domain.Sample;
import com.interntraining.admin.sample.service.SampleService;

//----------------------------------------------------------------------
/**
 * ■샘플 컨트롤러 ■ymkang ■2018. 09. 03.
 */
//----------------------------------------------------------------------
@Controller
@RequestMapping(value = "/")
public class SampleController {
	@Autowired
    private SampleService sampleService;

	//----------------------------------------------------------------------
	/**
	 * ■샘플 진입 함수 ■ymkang ■2018. 09. 03.
	 */
	//----------------------------------------------------------------------
	@RequestMapping(value = "/")
    public String initPage() throws Exception {

		Sample sample = new Sample();
		List<Sample> sampleList = sampleService.selectSampleList(sample);

		return "sample";
    }

    //----------------------------------------------------------------------
    /**
     * ■샘플 목록 조회 함수 ■ymkang ■2018. 09. 03.
     */
    //----------------------------------------------------------------------
    @ResponseBody
    @PostMapping(value = "/selectSample")
    public ModelAndView selectSample(@RequestBody Sample sample) throws Exception {
        ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());

    	List<Sample> sampleList = sampleService.selectSampleList(sample);

    	mav.addObject("data", sampleList);
    	mav.addObject("text", "PAYLETTER");

        return mav;
    }
}
