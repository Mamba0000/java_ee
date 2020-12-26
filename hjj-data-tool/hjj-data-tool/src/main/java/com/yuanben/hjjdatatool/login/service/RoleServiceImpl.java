package com.yuanben.hjjdatatool.login.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.mapper.MenuMapper;
import com.yuanben.hjjdatatool.login.mapper.PermissionMapper;
import com.yuanben.hjjdatatool.login.mapper.RoleMapper;
import com.yuanben.hjjdatatool.login.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 角色管理Service实现类
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private RoleMenuRelationService roleMenuRelationService;
    @Autowired
    private RolePermissionRelationService roleResourceRelationService;
    @Autowired
    private MenuMapper menuMapper;
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public boolean create(Role role) {
        role.setCreateTime(new Date());
        role.setAdminCount(0);
        role.setSort(0);
        return save(role);
    }

    @Override
    public boolean delete(List<Long> ids) {
        boolean success = removeByIds(ids);
        return success;
    }

    @Override
    public Page<Role> list(String keyword, Integer pageSize, Integer pageNum) {
        Page<Role> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Role> wrapper = new QueryWrapper<>();
        LambdaQueryWrapper<Role> lambda = wrapper.lambda();
        if (StrUtil.isNotEmpty(keyword)) {
            lambda.like(Role::getName, keyword);
        }
        return page(page, wrapper);
    }

    @Override
    public List<Menu> getMenuList(Long adminId) {
        return menuMapper.getMenuList(adminId);
    }

    @Override
    public List<Menu> listMenu(Long roleId) {
        return menuMapper.getMenuListByRoleId(roleId);
    }

    @Override
    public List<Permission> listResource(Long roleId) {
        return permissionMapper.getResourceListByRoleId(roleId);
    }

    @Override
    public int allocMenu(Long roleId, List<Long> menuIds) {
        //先删除原有关系
        QueryWrapper<RoleMenuRelation> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(RoleMenuRelation::getRoleId, roleId);
        roleMenuRelationService.remove(wrapper);
        //批量插入新关系
        List<RoleMenuRelation> relationList = new ArrayList<>();
        for (Long menuId : menuIds) {
            RoleMenuRelation relation = new RoleMenuRelation();
            relation.setRoleId(roleId);
            relation.setMenuId(menuId);
            relationList.add(relation);
        }
        roleMenuRelationService.saveBatch(relationList);
        return menuIds.size();
    }

    @Override
    public int allocResource(Long roleId, List<Long> resourceIds) {
        //先删除原有关系
        QueryWrapper<RolePermissionRelation> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(RolePermissionRelation::getRoleId, roleId);
        roleResourceRelationService.remove(wrapper);
        //批量插入新关系
        List<RolePermissionRelation> relationList = new ArrayList<>();
        for (Long resourceId : resourceIds) {
            RolePermissionRelation relation = new RolePermissionRelation();
            relation.setRoleId(roleId);
            relation.setResourceId(resourceId);
            relationList.add(relation);
        }
        roleResourceRelationService.saveBatch(relationList);
        return resourceIds.size();
    }
}
