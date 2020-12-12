package com.yuanben.hjjdatatool.login.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yuanben.hjjdatatool.common.api.CommonPage;
import com.yuanben.hjjdatatool.common.api.CommonResult;
import com.yuanben.hjjdatatool.login.dto.MenuNode;
import com.yuanben.hjjdatatool.login.model.Menu;
import com.yuanben.hjjdatatool.login.service.MenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 菜单管理Controller
 */
@Controller
@Api(tags = "MenuController", description = "菜单管理")
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @ApiOperation("添加菜单")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult create(@RequestBody Menu menu) {
        boolean success = menuService.create(menu);
        if (success) {
            return CommonResult.success(null);
        } else {
            return CommonResult.failed();
        }
    }

    @ApiOperation("修改菜单")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult update(@PathVariable Long id,
                               @RequestBody Menu menu) {
        boolean success = menuService.update(id, menu);
        if (success) {
            return CommonResult.success(null);
        } else {
            return CommonResult.failed();
        }
    }

    @ApiOperation("根据ID获取菜单详情")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<Menu> getItem(@PathVariable Long id) {
        Menu menu = menuService.getById(id);
        return CommonResult.success(menu);
    }

    @ApiOperation("根据ID删除菜单")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult delete(@PathVariable Long id) {
        boolean success = menuService.removeById(id);
        if (success) {
            return CommonResult.success(null);
        } else {
            return CommonResult.failed();
        }
    }

    @ApiOperation("分页查询菜单")
    @RequestMapping(value = "/list/{parentId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<Menu>> list(@PathVariable Long parentId,
                                               @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                               @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        Page<Menu> menuList = menuService.list(parentId, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(menuList));
    }

    @ApiOperation("树形结构返回所有菜单列表")
    @RequestMapping(value = "/treeList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<MenuNode>> treeList() {
        List<MenuNode> list = menuService.treeList();
        return CommonResult.success(list);
    }

    @ApiOperation("修改菜单显示状态")
    @RequestMapping(value = "/updateHidden/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateHidden(@PathVariable Long id, @RequestParam("hidden") Integer hidden) {
        boolean success = menuService.updateHidden(id, hidden);
        if (success) {
            return CommonResult.success(null);
        } else {
            return CommonResult.failed();
        }
    }
}
