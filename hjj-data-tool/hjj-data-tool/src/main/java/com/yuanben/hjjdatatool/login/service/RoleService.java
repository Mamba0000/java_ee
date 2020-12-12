package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yuanben.hjjdatatool.login.model.Menu;
import com.yuanben.hjjdatatool.login.model.Permission;
import com.yuanben.hjjdatatool.login.model.Role;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 角色管理Service
 */
public interface RoleService extends IService<Role> {
    /**
     * 添加角色
     */
    boolean create(Role role);

    /**
     * 批量删除角色
     */
    boolean delete(List<Long> ids);

    /**
     * 分页获取角色列表
     */
    Page<Role> list(String keyword, Integer pageSize, Integer pageNum);

    /**
     * 根据管理员ID获取对应菜单
     */
    List<Menu> getMenuList(Long adminId);

    /**
     * 获取角色相关菜单
     */
    List<Menu> listMenu(Long roleId);

    /**
     * 获取角色相关权限
     */
    List<Permission> listResource(Long roleId);

    /**
     * 给角色分配菜单
     */
    @Transactional
    int allocMenu(Long roleId, List<Long> menuIds);

    /**
     * 给角色分配权限
     */
    @Transactional
    int allocResource(Long roleId, List<Long> resourceIds);
}
