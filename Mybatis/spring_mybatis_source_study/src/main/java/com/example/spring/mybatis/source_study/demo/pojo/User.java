package com.example.spring.mybatis.source_study.demo.pojo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.ArrayList;

@Data
@Alias("mUser") // 别名 还需设置 type-aliases-package 指明包位置
public class User {
    private int id;
    private String name;
    private String pwd;
    // 性别
    private Gender gender;

}
