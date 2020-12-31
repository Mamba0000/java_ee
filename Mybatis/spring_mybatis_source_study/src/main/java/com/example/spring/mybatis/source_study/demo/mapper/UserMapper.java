package com.example.spring.mybatis.source_study.demo.mapper;


import com.example.spring.mybatis.source_study.demo.pojo.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public List<User> studyIf2(String name);
}

