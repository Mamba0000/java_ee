package com.yuanben.hjjdatatool.login.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yuanben.hjjdatatool.login.dto.MenuNode;
import com.yuanben.hjjdatatool.login.model.Menu;

import java.util.List;

/**
 * 菜单管理Service
 */
public interface MenuService extends IService<Menu> {
    /**
     * 创建菜单
     */
    boolean create(Menu menu);

    /**
     * 修改菜单
     */
    boolean update(Long id, Menu menu);

    /**
     * 分页查询菜单
     */
    Page<Menu> list(Long parentId, Integer pageSize, Integer pageNum);

    /**
     * 树形结构返回所有菜单列表
     */
    List<MenuNode> treeList();

    /**
     * 修改菜单显示状态
     */
    boolean updateHidden(Long id, Integer hidden);
}
