package com.yuanben.hjjdatatool.login.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * <p>
 * 角色权限关系表
 * </p>
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("tb_role_permission_relation")
@ApiModel(value="RolePermissionRelation对象", description="角色权限关系表")
public class RolePermissionRelation implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty(value = "角色ID")
    private Long roleId;

    @ApiModelProperty(value = "权限ID")
    private Long resourceId;


}
