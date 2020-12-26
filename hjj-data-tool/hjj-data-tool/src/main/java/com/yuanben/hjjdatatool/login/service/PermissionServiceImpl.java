package com.yuanben.hjjdatatool.login.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.mapper.PermissionMapper;
import com.yuanben.hjjdatatool.login.model.Permission;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 权限管理Service实现类
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {

    @Override
    public boolean create(Permission permission) {
        permission.setCreateTime(new Date());
        return save(permission);
    }

    @Override
    public boolean update(Long id, Permission permission) {
        permission.setId(id);
        boolean success = updateById(permission);
        return success;
    }

    @Override
    public boolean delete(Long id) {
        boolean success = removeById(id);
        return success;
    }

    @Override
    public Page<Permission> list(Long categoryId, String nameKeyword, String urlKeyword, Integer pageSize, Integer pageNum) {
        Page<Permission> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Permission> wrapper = new QueryWrapper<>();
        LambdaQueryWrapper<Permission> lambda = wrapper.lambda();
        if (categoryId != null) {
            lambda.eq(Permission::getCategoryId, categoryId);
        }
        if (StrUtil.isNotEmpty(nameKeyword)) {
            lambda.like(Permission::getName, nameKeyword);
        }
        if (StrUtil.isNotEmpty(urlKeyword)) {
            lambda.like(Permission::getValue, urlKeyword);
        }
        return page(page, wrapper);
    }
}
