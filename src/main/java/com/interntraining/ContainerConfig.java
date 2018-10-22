package com.interntraining;
import org.apache.catalina.connector.Connector;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//----------------------------------------------------------------------
/**
 * ■Embedded Tomcat AJP 설정 ■ymjo ■2017. 6. 21.
 */
//---------------------------------------------------------------------
@Configuration
public class ContainerConfig {
    @Value("${server.ajp.port}")
    Integer intAJPPort;

    @Bean
    public ServletWebServerFactory servletWebServerFactory() {
        TomcatServletWebServerFactory objTomcat = new TomcatServletWebServerFactory();
        Connector objAJPconnector = new Connector("AJP/1.3");

        objAJPconnector.setScheme("http");
        objAJPconnector.setPort(intAJPPort);
        objAJPconnector.setSecure(false);
        objAJPconnector.setAllowTrace(false);

        objTomcat.addAdditionalTomcatConnectors(objAJPconnector);

        return objTomcat;
    }
}
