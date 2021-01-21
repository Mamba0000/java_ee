package com.yuanben.hjjdatatool;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yuanben.hjjdatatool.login.model.User;
import com.yuanben.hjjdatatool.login.service.UserService;
import lombok.val;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

@SpringBootTest
class HjjDataToolApplicationTests {

    @Autowired
    private UserService userService;

    @Test
    void contextLoads() {


    }

    @Test
    void save() {
        final val user = new User();
        user.setPassword("123456");
        user.setUsername("robinxx");
        userService.save(user);
    }

    @Test
    void saveBatch() {
        final val user = new User();
        user.setPassword("123456");
        user.setUsername("robinxx001");

        final val user2 = new User();
        user2.setPassword("123456");
        user2.setUsername("robinxx002");

        ArrayList<User> list = new ArrayList<User>();
        list.add(user);
        list.add(user2);

        userService.saveBatch(list);
    }


    @Test
    void saveOrUpdateBatch() {
        final val user = new User();
        user.setId(21L);
        user.setPassword("123456");
        user.setUsername("robinxx001kk");

        final val user2 = new User();
        user2.setId(22L);
        user2.setPassword("123456");
        user2.setUsername("robinxx002xx");

        final val user3 = new User();
        user3.setPassword("123456");
        user3.setUsername("robinxx003");

        ArrayList<User> list = new ArrayList<User>();
        list.add(user);
        list.add(user2);
        list.add(user3);


        userService.saveOrUpdateBatch(list);
    }

    @Test
    void removeById() {
        userService.removeById(23);
    }

    @Test
    void removeByMap() {
        Map<String, Object> columnMap = new HashMap<>();
        columnMap.put("usename","robin%*");
        userService.removeByMap(columnMap);
    }


    @Test
    void queryWrapper() {
        QueryWrapper<User> wrapper = new QueryWrapper<>();

        wrapper.last("limit 0, 10");

        List<User> userList =  userService.list(wrapper);
        System.out.printf("---", userList);
    }







}
