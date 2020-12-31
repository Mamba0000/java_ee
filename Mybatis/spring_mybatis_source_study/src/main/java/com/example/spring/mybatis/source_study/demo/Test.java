package com.example.spring.mybatis.source_study.demo;

import com.example.spring.mybatis.source_study.demo.mapper.UserMapper;
import com.example.spring.mybatis.source_study.demo.pojo.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.List;

public class Test {

    void contextLoads() {
        System.out.println("-----");
    }

    public static void main(String[] args) {
        new Test().findUserById();
    }

    public void findUserById() {
        SqlSession sqlSession = getSessionFactory().openSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        List<User> user = userMapper.studyIf2("robin");
    }

    //Mybatis 通过SqlSessionFactory获取SqlSession, 然后才能通过SqlSession与数据库进行交互
    private static SqlSessionFactory getSessionFactory() {
        SqlSessionFactory sessionFactory = null;
        String resource = "configuration.xml";
//        String resource = "application.yml";

        try {

            sessionFactory = new SqlSessionFactoryBuilder().build(Resources
                    .getResourceAsReader(resource));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sessionFactory;
    }


}
