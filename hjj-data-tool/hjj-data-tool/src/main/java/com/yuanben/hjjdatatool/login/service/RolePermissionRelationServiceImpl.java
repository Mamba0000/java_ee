package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.mapper.RolePermissionRelationMapper;
import com.yuanben.hjjdatatool.login.model.RolePermissionRelation;
import org.springframework.stereotype.Service;

/**
 * 角色权限关系管理Service实现类
 */
@Service
public class RolePermissionRelationServiceImpl extends ServiceImpl<RolePermissionRelationMapper, RolePermissionRelation> implements RolePermissionRelationService {
}
