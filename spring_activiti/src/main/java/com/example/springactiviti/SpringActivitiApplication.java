package com.example.springactiviti;

import org.activiti.spring.boot.SecurityAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class SpringActivitiApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringActivitiApplication.class, args);
    }

}
