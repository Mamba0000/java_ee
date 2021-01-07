/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : springboot-rabbitmq

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 07/01/2021 15:10:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for broker_message_log
-- ----------------------------
DROP TABLE IF EXISTS `broker_message_log`;
CREATE TABLE `broker_message_log` (
  `message_id` varchar(255) NOT NULL COMMENT '消息唯一ID',
  `message` varchar(4000) NOT NULL COMMENT '消息内容',
  `try_count` int(4) DEFAULT '0' COMMENT '重试次数',
  `status` varchar(10) DEFAULT '' COMMENT '消息投递状态 0投递中，1投递成功，2投递失败',
  `next_retry` timestamp NOT NULL DEFAULT '1970-01-01 10:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '下一次重试时间',
  `create_time` timestamp NOT NULL DEFAULT '1970-01-01 10:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '1970-01-01 10:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of broker_message_log
-- ----------------------------
BEGIN;
INSERT INTO `broker_message_log` VALUES ('1609988313464$36bc1f11-e7fe-4aff-8b4e-323929879fd8', '{\"id\":2018092102,\"messageId\":\"1609988313464$36bc1f11-e7fe-4aff-8b4e-323929879fd8\",\"name\":\"测试订单1\"}', 0, '1', '2021-01-07 10:58:35', '2021-01-07 10:58:35', '2021-01-07 10:58:36');
INSERT INTO `broker_message_log` VALUES ('1610000015644$4d05d91b-a62a-41a0-b38e-78979f41ac83', '{\"id\":2018092103,\"messageId\":\"1610000015644$4d05d91b-a62a-41a0-b38e-78979f41ac83\",\"name\":\"测试订单1\"}', 0, '1', '2021-01-07 14:13:36', '2021-01-07 14:13:36', '2021-01-07 14:13:37');
INSERT INTO `broker_message_log` VALUES ('1610000138856$3f4e4a85-960d-4286-af2f-26839f457f75', '{\"id\":2018092105,\"messageId\":\"1610000138856$3f4e4a85-960d-4286-af2f-26839f457f75\",\"name\":\"测试订单1\"}', 2, '1', '2021-01-07 14:17:03', '2021-01-07 14:17:03', '2021-01-07 14:17:04');
COMMIT;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2018092106 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
BEGIN;
INSERT INTO `t_order` VALUES (2018092102, '测试订单1', '1609988313464$36bc1f11-e7fe-4aff-8b4e-323929879fd8');
INSERT INTO `t_order` VALUES (2018092103, '测试订单1', '1610000015644$4d05d91b-a62a-41a0-b38e-78979f41ac83');
INSERT INTO `t_order` VALUES (2018092105, '测试订单1', '1610000138856$3f4e4a85-960d-4286-af2f-26839f457f75');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
