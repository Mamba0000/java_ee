package com.yuanben.hjjdatatool.login.dto;

import com.yuanben.hjjdatatool.login.model.Menu;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 菜单节点封装
 */
@Getter
@Setter
public class MenuNode extends Menu {
    @ApiModelProperty(value = "子级菜单")
    private List<MenuNode> children;
}
