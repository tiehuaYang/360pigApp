package com.pig.authority.service;

import java.util.List;

import com.pig.authority.vo.PermissionModule;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserVO;

public interface AuthorityService {

   /**
    * 扫描RequiresPermissions和RequiresRoles注解
    * 
    * @param pkg
    * 需要扫描的package
    */
   void initFormPackage(String pkg);

   /**
    * 检查最基础的权限,确保admin用户-admin角色-(用户增删改查-权限增删改查)这一基础权限设置
    * 
    * @param admin
    */
   void checkBasicRoles(UserVO admin);

   /**
    * 添加一个权限
    */
   void addPermission(String permission);

   /**
    * 添加一个角色
    */
   Role addRole(String role);

   /**
    * 扫描Module表中的记录，并遍历出对应的所有权限因子，并根据当前角色获取权限状态
    * 
    * @param companyId 对应的企业ID
    */
   public List<PermissionModule> queryPermissionList(Role role, String companyId);
}
