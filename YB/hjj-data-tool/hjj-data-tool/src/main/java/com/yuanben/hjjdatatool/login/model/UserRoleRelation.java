package com.yuanben.hjjdatatool.login.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * <p>
 * 用户和角色关系表
 * </p>
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("tb_user_role_relation")
@ApiModel(value = "UserRoleRelation对象", description = "用户和角色关系表")
public class UserRoleRelation implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long adminId;

    private Long roleId;


}
