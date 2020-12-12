package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.dto.MenuNode;
import com.yuanben.hjjdatatool.login.mapper.MenuMapper;
import com.yuanben.hjjdatatool.login.model.Menu;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 菜单管理Service实现类
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu>implements MenuService {

    @Override
    public boolean create(Menu menu) {
        menu.setCreateTime(new Date());
        updateLevel(menu);
        return save(menu);
    }

    /**
     * 修改菜单层级
     */
    private void updateLevel(Menu menu) {
        if (menu.getParentId() == 0) {
            //没有父菜单时为一级菜单
            menu.setLevel(0);
        } else {
            //有父菜单时选择根据父菜单level设置
            Menu parentMenu = getById(menu.getParentId());
            if (parentMenu != null) {
                menu.setLevel(parentMenu.getLevel() + 1);
            } else {
                menu.setLevel(0);
            }
        }
    }

    @Override
    public boolean update(Long id, Menu menu) {
        menu.setId(id);
        updateLevel(menu);
        return updateById(menu);
    }

    @Override
    public Page<Menu> list(Long parentId, Integer pageSize, Integer pageNum) {
        Page<Menu> page = new Page<>(pageNum,pageSize);
        QueryWrapper<Menu> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(Menu::getParentId,parentId)
                .orderByDesc(Menu::getSort);
        return page(page,wrapper);
    }

    @Override
    public List<MenuNode> treeList() {
        List<Menu> menuList = list();
        List<MenuNode> result = menuList.stream()
                .filter(menu -> menu.getParentId().equals(0L))
                .map(menu -> covertMenuNode(menu, menuList)).collect(Collectors.toList());
        return result;
    }

    @Override
    public boolean updateHidden(Long id, Integer hidden) {
        Menu menu = new Menu();
        menu.setId(id);
        menu.setHidden(hidden);
        return updateById(menu);
    }

    /**
     * 将UmsMenu转化为UmsMenuNode并设置children属性
     */
    private MenuNode covertMenuNode(Menu menu, List<Menu> menuList) {
        MenuNode node = new MenuNode();
        BeanUtils.copyProperties(menu, node);
        List<MenuNode> children = menuList.stream()
                .filter(subMenu -> subMenu.getParentId().equals(menu.getId()))
                .map(subMenu -> covertMenuNode(subMenu, menuList)).collect(Collectors.toList());
        node.setChildren(children);
        return node;
    }
}
