package com.yuanben.hjjdatatool.login.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yuanben.hjjdatatool.login.model.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 用户角色表 Mapper 接口
 * </p>
 *
 */

public interface RoleMapper extends BaseMapper<Role> {

    /**
     * 获取用户所有角色
     */
    List<Role> getRoleList(@Param("adminId") Long adminId);

}
