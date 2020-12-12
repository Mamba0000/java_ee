package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yuanben.hjjdatatool.login.dto.UserParam;
import com.yuanben.hjjdatatool.login.dto.UpdateUserPasswordParam;
import com.yuanben.hjjdatatool.login.model.User;
import com.yuanben.hjjdatatool.login.model.Permission;
import com.yuanben.hjjdatatool.login.model.Role;
import javafx.scene.control.Pagination;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Wrapper;
import java.util.List;

/**
 * 管理员管理Service
 */
public interface UserService extends IService<User> {
    /**
     * 根据用户名获取管理员
     */
    User getAdminByUsername(String username);

    /**
     * 注册功能
     */
    User register(UserParam userParam);

    /**
     * 登录功能
     * @param username 用户名
     * @param password 密码
     * @return 生成的JWT的token
     */
    String login(String username,String password);

    /**
     * 刷新token的功能
     * @param oldToken 旧的token
     */
    String refreshToken(String oldToken);

    /**
     * 根据用户名或昵称分页查询用户
     */
    Page<User> list(String keyword, Integer pageSize, Integer pageNum);

    /**
     * 修改指定用户信息
     */
    boolean update(Long id, User admin);

    /**
     * 删除指定用户
     */
    boolean delete(Long id);

    /**
     * 修改用户角色关系
     */
    @Transactional
    int updateRole(Long adminId, List<Long> roleIds);

    /**
     * 获取用户对于角色
     */
    List<Role> getRoleList(Long adminId);

    /**
     * 获取指定用户的可访问权限
     */
    List<Permission> getResourceList(Long adminId);

    /**
     * 修改密码
     */
    int updatePassword(UpdateUserPasswordParam updatePasswordParam);

//    IPage<User> selectMyUsers(int i, Page page);

    // UserVo 参数可以自定义
    IPage<User> selectMyUsers(Page<User> page , @Param("user") User user);


}
