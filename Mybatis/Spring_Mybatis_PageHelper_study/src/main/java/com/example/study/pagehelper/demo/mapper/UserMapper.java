package com.example.study.pagehelper.demo.mapper;

import com.example.study.pagehelper.demo.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface UserMapper {

  public List<User> selectByPage();

  public List<User> selectByPage2();


}

