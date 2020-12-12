package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.mapper.RoleUserRelationMapper;
import com.yuanben.hjjdatatool.login.model.UserRoleRelation;
import org.springframework.stereotype.Service;

/**
 * 管理员角色关系管理Service实现类
 */
@Service
public class UserRoleRelationServiceImpl extends ServiceImpl<RoleUserRelationMapper, UserRoleRelation> implements UserRoleRelationService {


}
