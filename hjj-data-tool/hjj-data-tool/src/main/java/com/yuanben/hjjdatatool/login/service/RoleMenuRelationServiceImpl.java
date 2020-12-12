package com.yuanben.hjjdatatool.login.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yuanben.hjjdatatool.login.mapper.RoleMenuRelationMapper;
import com.yuanben.hjjdatatool.login.model.RoleMenuRelation;
import org.springframework.stereotype.Service;

/**
 * 角色菜单关系管理Service实现类
 */
@Service
public class RoleMenuRelationServiceImpl extends ServiceImpl<RoleMenuRelationMapper, RoleMenuRelation> implements RoleMenuRelationService {
}
