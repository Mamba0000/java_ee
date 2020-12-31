package com.example.study.pagehelper.demo.controller;

import com.example.study.pagehelper.demo.mapper.UserMapper;
import com.example.study.pagehelper.demo.pojo.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class TestController {

    @Resource
    UserMapper userMapper;

    @GetMapping("/selectByPage/{pageNum}/{pageSize}")
    public PageInfo<User> selectByPage(@PathVariable int pageNum, @PathVariable int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> list = userMapper.selectByPage(); //得到从pageNum开始的pageSize条数据
        //如果直接返回list，得到了分页的数据，如果添加下面步骤，返回pageInfo，则能得到包括list在内的分页信息
        PageInfo<User> pageInfo = new PageInfo<User>(list);
        return pageInfo;
    }

    @GetMapping("/selectByPage2/{pageNum}/{pageSize}")
    public PageInfo<User> selectByPage2(@PathVariable int pageNum, @PathVariable int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> list = userMapper.selectByPage(); //得到从pageNum开始的pageSize条数据
        //如果直接返回list，得到了分页的数据，如果添加下面步骤，返回pageInfo，则能得到包括list在内的分页信息
        PageInfo<User> pageInfo = new PageInfo<User>(list);
        return pageInfo;
    }
}
