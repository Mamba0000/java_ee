/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : spring_mybatis_pageHelper

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 27/12/2020 18:08:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Permission
-- ----------------------------
DROP TABLE IF EXISTS `Permission`;
CREATE TABLE `Permission` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of Permission
-- ----------------------------
BEGIN;
INSERT INTO `Permission` VALUES (1, '添加用户');
INSERT INTO `Permission` VALUES (2, '删除用户');
INSERT INTO `Permission` VALUES (3, '更新用户');
INSERT INTO `Permission` VALUES (4, '删除用户');
INSERT INTO `Permission` VALUES (5, '添加商品');
COMMIT;

-- ----------------------------
-- Table structure for User
-- ----------------------------
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of User
-- ----------------------------
BEGIN;
INSERT INTO `User` VALUES (2, 10, 'liyicheng02', '123456');
INSERT INTO `User` VALUES (3, 10, 'liyicheng03', '123456');
INSERT INTO `User` VALUES (4, 10, 'liyicheng04', '123456');
INSERT INTO `User` VALUES (5, 10, 'liyicheng05', '123456');
INSERT INTO `User` VALUES (6, 10, 'liyicheng06', '123456');
INSERT INTO `User` VALUES (7, 10, 'liyicheng07', '123456');
INSERT INTO `User` VALUES (8, 10, 'liyicheng08', '123456');
INSERT INTO `User` VALUES (9, 10, 'liyicheng09', '123456');
INSERT INTO `User` VALUES (10, 10, 'liyicheng10', '123456');
INSERT INTO `User` VALUES (11, 10, 'liyicheng11', '123456');
INSERT INTO `User` VALUES (12, 10, 'liyicheng12', '123456');
INSERT INTO `User` VALUES (1, 10, 'liyicheng01', '123456');
COMMIT;

-- ----------------------------
-- Table structure for User_Permision
-- ----------------------------
DROP TABLE IF EXISTS `User_Permision`;
CREATE TABLE `User_Permision` (
  `fk_user_id` int(11) DEFAULT NULL,
  `fk_permission_id` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of User_Permision
-- ----------------------------
BEGIN;
INSERT INTO `User_Permision` VALUES (1, 1);
INSERT INTO `User_Permision` VALUES (1, 2);
INSERT INTO `User_Permision` VALUES (2, 1);
INSERT INTO `User_Permision` VALUES (2, 3);
INSERT INTO `User_Permision` VALUES (3, 4);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
