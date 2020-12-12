package com.yuanben.hjjdatatool.login.service;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.common.exception.Asserts;
import com.yuanben.hjjdatatool.common.shiro.JWTUtil;
import com.yuanben.hjjdatatool.login.dto.UserParam;
import com.yuanben.hjjdatatool.login.dto.UpdateUserPasswordParam;
import com.yuanben.hjjdatatool.login.mapper.UserMapper;
import com.yuanben.hjjdatatool.login.mapper.PermissionMapper;
import com.yuanben.hjjdatatool.login.mapper.RoleMapper;
import com.yuanben.hjjdatatool.login.model.*;
import io.jsonwebtoken.Claims;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 管理员管理Service实现类
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
    //    @Autowired
//    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private UserRoleRelationService adminRoleRelationService;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public User getAdminByUsername(String username) {
        User admin ;
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(User::getUsername,username);
        List<User> adminList = list(wrapper);
        if (adminList != null && adminList.size() > 0) {
            admin = adminList.get(0);
            return admin;
        }
        return null;
    }

    @Override
    public User register(UserParam userParam) {
        User user = new User();
        BeanUtils.copyProperties(userParam, user);
        user.setCreateTime(new Date());
        user.setStatus(1);
        //查询是否有相同用户名的用户
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(User::getUsername, user.getUsername());
        List<User> userList = list(wrapper);
        if (userList.size() > 0) {
            return null;
        }
        //将密码进行加密操作
        user.setPassword(user.getPassword());
        baseMapper.insert(user);
        return user;
    }

    @Override
    public String login(String username, String password) {
        String token = null;
        //密码需要客户端加密后传递
        try {
            User user = getAdminByUsername(username);
            if(!user.getPassword().equals(password)){
                Asserts.fail("密码不正确");
            }
            token = JWTUtil.sign(user.getUsername(), user.getPassword());
            updateLoginTimeByUsername(username);
        } catch (Exception e) {
            LOGGER.warn("登录异常:{}", e.getMessage());
        }
        return token;
    }

    /**
     * 根据用户名修改登录时间
     */
    private void updateLoginTimeByUsername(String username) {
        User record = new User();
        record.setLoginTime(new Date());
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(User::getUsername,username);
        update(record,wrapper);
    }

    @Override
    public String refreshToken(String oldToken) {
        return JWTUtil.refreshHeadToken(oldToken);
    }

    public String refreshHeadToken(String oldToken) {
      return  JWTUtil.refreshHeadToken(oldToken);
    }

    @Override
    public Page<User> list(String keyword, Integer pageSize, Integer pageNum) {
        Page<User> page = new Page<>(pageNum,pageSize);
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        LambdaQueryWrapper<User> lambda = wrapper.lambda();
        if(StrUtil.isNotEmpty(keyword)){
            lambda.like(User::getUsername,keyword);
            lambda.or().like(User::getNickName,keyword);
        }
        return page(page,wrapper);
    }

    @Override
    public boolean update(Long id, User admin) {
        admin.setId(id);
        User rawAdmin = getById(id);
        if(rawAdmin.getPassword().equals(admin.getPassword())){
            //与原加密密码相同的不需要修改
            admin.setPassword(null);
        }else{
            //与原加密密码不同的需要加密修改
            if(StrUtil.isEmpty(admin.getPassword())){
                admin.setPassword(null);
            }else{
                admin.setPassword(admin.getPassword());
            }
        }
        boolean success = updateById(admin);
        return success;
    }

    @Override
    public boolean delete(Long id) {
        boolean success = removeById(id);
        return success;
    }

    @Override
    public int updateRole(Long adminId, List<Long> roleIds) {
        int count = roleIds == null ? 0 : roleIds.size();
        //先删除原来的关系
        QueryWrapper<UserRoleRelation> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(UserRoleRelation::getAdminId,adminId);
        adminRoleRelationService.remove(wrapper);
        //建立新关系
        if (!CollectionUtils.isEmpty(roleIds)) {
            List<UserRoleRelation> list = new ArrayList<>();
            for (Long roleId : roleIds) {
                UserRoleRelation roleRelation = new UserRoleRelation();
                roleRelation.setAdminId(adminId);
                roleRelation.setRoleId(roleId);
                list.add(roleRelation);
            }
            adminRoleRelationService.saveBatch(list);
        }
        return count;
    }

    @Override
    public List<Role> getRoleList(Long adminId) {
        return roleMapper.getRoleList(adminId);
    }

    @Override
    public List<Permission> getResourceList(Long adminId) {
        List<Permission> resourceList = null;
        if(CollUtil.isNotEmpty(resourceList)){
            return  resourceList;
        }
        resourceList = permissionMapper.getResourceList(adminId);
        if(CollUtil.isNotEmpty(resourceList)){
        }
        return resourceList;
    }

    @Override
    public int updatePassword(UpdateUserPasswordParam param) {
        if(StrUtil.isEmpty(param.getUsername())
                ||StrUtil.isEmpty(param.getOldPassword())
                ||StrUtil.isEmpty(param.getNewPassword())){
            return -1;
        }
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(User::getUsername,param.getUsername());
        List<User> adminList = list(wrapper);
        if(CollUtil.isEmpty(adminList)){
            return -2;
        }
        User user = adminList.get(0);
        if(!param.getOldPassword().equals(user.getPassword())){
            return -3;
        }
        user.setPassword(param.getNewPassword());
        updateById(user);
        return 1;
    }


    public IPage<User> selectMyUsers(Page<User> page , @Param("user") User user) {
        return (this.baseMapper.selectMyUsers(page,user));
    }

}
