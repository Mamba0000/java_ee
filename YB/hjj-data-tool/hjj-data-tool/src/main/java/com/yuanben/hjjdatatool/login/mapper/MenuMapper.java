package com.yuanben.hjjdatatool.login.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yuanben.hjjdatatool.login.model.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 菜单表 Mapper 接口
 * </p>
 */

public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 根据用户ID获取菜单
     */
    List<Menu> getMenuList(@Param("userId") Long userId);

    /**
     * 根据角色ID获取菜单
     */
    List<Menu> getMenuListByRoleId(@Param("roleId") Long roleId);

}
