/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost
 Source Database       : wxfqz

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : utf-8

 Date: 07/07/2017 11:52:49 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` varchar(32) NOT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `permission_id` varchar(32) DEFAULT NULL,
  `pid` varchar(32) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `html_id` varchar(64) DEFAULT NULL,
  `html_class` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `menu`
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES ('40288016572295d5015722b1fe72003f', '系统管理', '40288016572295d50157229bfa80000d', null, '8', '0', 'manage', 'menu-icon fa fa-tachometer'), ('40288016572295d5015722b36c410040', '用户管理', '40288016572295d50157229cd05a000e', '40288016572295d5015722b1fe72003f', '5', '1', 'userManage', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b3d0240041', '权限管理', '40288016572295d50157229fdb7e0014', '40288016572295d5015722b1fe72003f', '3', '1', 'permissionManage', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b43b1c0042', '角色管理', '40288016572295d5015722a0e8be0017', '40288016572295d5015722b1fe72003f', '4', '1', 'roleManage', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b4a0110043', '菜单管理', '40288016572295d5015722a2b7d6001c', '40288016572295d5015722b1fe72003f', '1', '1', 'menuManage', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b550900044', '模块管理', '40288016572295d5015722a4550f0020', '40288016572295d5015722b1fe72003f', '2', '1', 'moduleManage', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b5c0580045', '用户中心', '40288016572295d5015722a59b3f0024', null, '7', '0', 'user', 'menu-icon fa fa-user'), ('40288016572295d5015722b65a4c0046', '基础资料', '40288016572295d5015722a5fde10025', '40288016572295d5015722b5c0580045', '8', '1', 'basicData', 'menu-icon fa fa-caret-right'), ('40288016572295d5015722b702300047', '密码设置', '40288016572295d5015722a73ae60028', '40288016572295d5015722b5c0580045', '9', '1', 'passwordSettings', 'menu-icon fa fa-caret-right'), ('402880ae5ad5b9bf015ad5bae2b00001', '系统设置', '402880ae5ad5b9bf015ad5bbd4dd0003', '40288016572295d5015722b1fe72003f', '18', '1', 'systemManage', 'menu-icon fa fa-caret-right');
COMMIT;

-- ----------------------------
--  Table structure for `module`
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` varchar(32) NOT NULL,
  `sort` int(11) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `menu_id` varchar(32) DEFAULT NULL,
  `main_menu_permission_id` varchar(32) DEFAULT NULL,
  `code` int(4) DEFAULT NULL,
  `yes_code` varchar(255) DEFAULT NULL,
  `no_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `module`
-- ----------------------------
BEGIN;
INSERT INTO `module` VALUES ('402880165745901e01574593d9c80002', '1', '用户列表', '用户列表', '40288016572295d5015722b36c410040', '40288016572295d50157229bfa80000d', '1', null, '2-3'), ('402880165745901e015745942b820003', '2', '启/禁用用户', '启/禁用用户', '40288016572295d5015722b36c410040', '40288016572295d50157229bfa80000d', '2', '1', null), ('402880165745901e0157459484bd0005', '1', '权限列表', '权限列表', '40288016572295d5015722b3d0240041', '40288016572295d50157229bfa80000d', '4', null, '5-6-7'), ('402880165745901e01574594bf860006', '2', '添加权限', '添加权限', '40288016572295d5015722b3d0240041', '40288016572295d50157229bfa80000d', '5', '4-6-7', '6-7'), ('402880165745901e01574594f3c20007', '3', '删除权限', '删除权限', '40288016572295d5015722b3d0240041', '40288016572295d50157229bfa80000d', '6', '4-5-7', '5-7'), ('402880165745901e015745954bb90008', '1', '角色列表', '角色列表', '40288016572295d5015722b43b1c0042', '40288016572295d50157229bfa80000d', '8', null, '9-10-11'), ('402880165745901e01574595c5340009', '2', '添加角色', '添加角色', '40288016572295d5015722b43b1c0042', '40288016572295d50157229bfa80000d', '9', '8-10-11', '10-11'), ('402880165745901e0157459609a5000a', '3', '删除角色', '删除角色', '40288016572295d5015722b43b1c0042', '40288016572295d50157229bfa80000d', '10', '8-9-11', '9-11'), ('402880165745901e0157459632d0000b', '4', '添加角色权限', '添加角色权限', '40288016572295d5015722b43b1c0042', '40288016572295d50157229bfa80000d', '11', '8-9-10', '9-10'), ('40288016574bc42501574be6c4650005', '11', '菜单列表', '菜单列表', '40288016572295d5015722b4a0110043', '40288016572295d50157229bfa80000d', '12', null, '13-14-15'), ('40288016574bc42501574be721fe0006', '12', '添加菜单', '添加菜单', '40288016572295d5015722b4a0110043', '40288016572295d50157229bfa80000d', '13', '12-14-15', '14-15'), ('40288016574bc42501574be761af0007', '13', '删除菜单', '删除菜单', '40288016572295d5015722b4a0110043', '40288016572295d50157229bfa80000d', '14', '12-13-15', '13-15'), ('40288016574bc42501574be7f2440008', '14', '编辑菜单', '编辑菜单', '40288016572295d5015722b4a0110043', '40288016572295d50157229bfa80000d', '15', '12-13-14', '13-14'), ('40288016574bef7801574bf11c000002', '15', '编辑权限', '编辑权限', '40288016572295d5015722b3d0240041', '40288016572295d50157229bfa80000d', '7', '4-5-6', '5-6'), ('40288016574f817c01574f84605d0002', '16', '模块列表', '模块列表', '40288016572295d5015722b550900044', '40288016572295d50157229bfa80000d', '16', null, '17-18'), ('40288016574f817c01574f87d0560003', '17', '添加模块', '添加模块', '40288016572295d5015722b550900044', '40288016572295d50157229bfa80000d', '17', '16-18', '18'), ('40288016574f817c01574f8829450004', '18', '删除模块', '删除模块', '40288016572295d5015722b550900044', '40288016572295d50157229bfa80000d', '18', '16-17', '17'), ('40288016574f817c01574f88b0e60005', '19', '编辑用户', '编辑用户', '40288016572295d5015722b65a4c0046', '40288016572295d5015722a59b3f0024', '19', null, null), ('40288016574f817c01574f8910270006', '20', '修改密码', '修改密码', '40288016572295d5015722b702300047', '40288016572295d5015722a59b3f0024', '20', null, null), ('402880ae5ad5b9bf015ad5bb2e8b0002', '25', '参数设置修改', '参数设置修改logging', '402880ae5ad5b9bf015ad5bae2b00001', '40288016572295d50157229bfa80000d', '25', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `organization_info`
-- ----------------------------
DROP TABLE IF EXISTS `organization_info`;
CREATE TABLE `organization_info` (
  `id` varchar(32) NOT NULL,
  `oi_user_id` varchar(32) DEFAULT NULL,
  `oi_name` varchar(1024) DEFAULT NULL,
  `oi_email` varchar(1024) DEFAULT NULL,
  `oi_address` varchar(1024) DEFAULT NULL,
  `oi_postcode` varchar(32) DEFAULT NULL,
  `oi_document_type` int(11) DEFAULT NULL,
  `oi_reg_no` varchar(256) DEFAULT NULL,
  `oi_reg_add` varchar(256) DEFAULT NULL,
  `oi_reg_date` datetime DEFAULT NULL,
  `oi_reg_time` varchar(32) DEFAULT NULL,
  `oi_tax_no` varchar(64) DEFAULT NULL,
  `oi_reg_url` varchar(1024) DEFAULT NULL,
  `oi_tax_url` varchar(1024) DEFAULT NULL,
  `oi_maker_name` varchar(64) DEFAULT NULL,
  `oi_maker_id` varchar(32) DEFAULT NULL,
  `oi_maker_url` varchar(1024) DEFAULT NULL,
  `oi_phone` varchar(32) DEFAULT NULL,
  `oi_create_time` datetime DEFAULT NULL,
  `oi_update_time` datetime DEFAULT NULL,
  `oi_job_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rel_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `rel_role_permission`;
CREATE TABLE `rel_role_permission` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `permission_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `rel_role_permission`
-- ----------------------------
BEGIN;
INSERT INTO `rel_role_permission` VALUES ('ff8080815d1b2b65015d1b2cfee90001', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a4a2be0021'), ('ff8080815d1b2b65015d1b2cfeee0002', '402880fb5285d6f0015286216bd8004e', '40288016574bef7801574bf2de2a0004'), ('ff8080815d1b2b65015d1b2cfeee0003', '402880fb5285d6f0015286216bd8004e', '40288016572295d50157229fdb7e0014'), ('ff8080815d1b2b65015d1b2cfeee0004', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a1a6bb0019'), ('ff8080815d1b2b65015d1b2cfeee0005', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a24d38001b'), ('ff8080815d1b2b65015d1b2cfeee0006', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a3128c001d'), ('ff8080815d1b2b65015d1b2cfeee0007', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a4ed3c0022'), ('ff8080815d1b2b65015d1b2cfeee0008', '402880fb5285d6f0015286216bd8004e', '40288016574bef7801574bf218580003'), ('ff8080815d1b2b65015d1b2cfeef0009', '402880fb5285d6f0015286216bd8004e', '402880ae5ad5b9bf015ad5bbd4dd0003'), ('ff8080815d1b2b65015d1b2cfeef000a', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a0e8be0017'), ('ff8080815d1b2b65015d1b2cfeef000b', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a153510018'), ('ff8080815d1b2b65015d1b2cfeef000c', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a73ae60028'), ('ff8080815d1b2b65015d1b2cfeef000d', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a2b7d6001c'), ('ff8080815d1b2b65015d1b2cfeef000e', '402880fb5285d6f0015286216bd8004e', '40288016572295d50157229bfa80000d'), ('ff8080815d1b2b65015d1b2cfeef000f', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a366e9001e'), ('ff8080815d1b2b65015d1b2cfeef0010', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a1f1c9001a'), ('ff8080815d1b2b65015d1b2cfeef0011', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a6453b0026'), ('ff8080815d1b2b65015d1b2cfef00012', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a7891c0029'), ('ff8080815d1b2b65015d1b2cfef00013', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a5fde10025'), ('ff8080815d1b2b65015d1b2cfef00014', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a4550f0020'), ('ff8080815d1b2b65015d1b2cfef00015', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a546500023'), ('ff8080815d1b2b65015d1b2cfef00016', '402880fb5285d6f0015286216bd8004e', '40288016574bc42501574becf4430009'), ('ff8080815d1b2b65015d1b2cfef00017', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a3c45e001f'), ('ff8080815d1b2b65015d1b2cfef00018', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a094330016'), ('ff8080815d1b2b65015d1b2cfef00019', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a040190015'), ('ff8080815d1b2b65015d1b2cfef0001a', '402880fb5285d6f0015286216bd8004e', '40288016572295d5015722a59b3f0024'), ('ff8080815d1b2b65015d1b2cfef1001b', '402880fb5285d6f0015286216bd8004e', '40288016574bc42501574bee0018000a'), ('ff8080815d1b2b65015d1b2d5d7c001c', '402880b551f1f0d80151f1f21a0a0004', '40288016572295d5015722a59b3f0024'), ('ff8080815d1b2b65015d1b2d5d7c001d', '402880b551f1f0d80151f1f21a0a0004', '40288016572295d5015722a6453b0026'), ('ff8080815d1b2b65015d1b2d5d7c001e', '402880b551f1f0d80151f1f21a0a0004', '40288016572295d5015722a73ae60028'), ('ff8080815d1b2b65015d1b2d5d7c001f', '402880b551f1f0d80151f1f21a0a0004', '40288016572295d5015722a7891c0029'), ('ff8080815d1b2b65015d1b2d5d7c0020', '402880b551f1f0d80151f1f21a0a0004', '40288016572295d5015722a5fde10025'), ('ff8080815d1b2b65015d1b2d72490021', '402880b551f1f0d80151f1f102700001', '40288016572295d5015722a59b3f0024'), ('ff8080815d1b2b65015d1b2d72490022', '402880b551f1f0d80151f1f102700001', '40288016572295d5015722a6453b0026'), ('ff8080815d1b2b65015d1b2d72490023', '402880b551f1f0d80151f1f102700001', '40288016572295d5015722a73ae60028'), ('ff8080815d1b2b65015d1b2d72490024', '402880b551f1f0d80151f1f102700001', '40288016572295d5015722a7891c0029'), ('ff8080815d1b2b65015d1b2d72490025', '402880b551f1f0d80151f1f102700001', '40288016572295d5015722a5fde10025'), ('ff8080815d1b2b65015d1b2d72490026', '402880b551f1f0d80151f1f102700001', '40288016572295d50157229cd05a000e'), ('ff8080815d1b2b65015d1b2d72490027', '402880b551f1f0d80151f1f102700001', '40288016572295d50157229d5bc5000f'), ('ff8080815d1b2b65015d1b2d72490028', '402880b551f1f0d80151f1f102700001', '40288016572295d50157229bfa80000d'), ('ff8080815d1b2b65015d1b2d724a0029', '402880b551f1f0d80151f1f102700001', '40288016572295d50157229df5760010');
COMMIT;

-- ----------------------------
--  Table structure for `rel_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `rel_user_role`
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` VALUES ('40288048557bfa4801557bfc86a70002', '402880b55083a97b015083aab8650001', '402880b551f1f0d80151f1f102700001'), ('402880fb5285d6f00152861fb790004c', '402880fb5285d6f00152861fb78f004a', '402880fb5285d6f0015286216bd8004e');
COMMIT;

-- ----------------------------
--  Table structure for `system_config`
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` varchar(32) NOT NULL,
  `sc_name` varchar(32) DEFAULT NULL,
  `sc_value` varchar(1024) DEFAULT NULL,
  `sc_describe` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `system_config`
-- ----------------------------
BEGIN;
INSERT INTO `system_config` VALUES ('100001', 'mail_smtp_server', 'smtp.exmail.qq.com', 'SMTP服务器地址'), ('100002', 'mail_user_name', 'marketing@zsyun.com', '邮件服务器用户名'), ('100003', 'mail_password', 'Suteam2006', '邮件服务器密码'), ('100004', 'mail_life_time', '24', '激活链接失效时间 单位：小时'), ('100005', 'mail_sender', '中数云计算', '邮件发送者名称'), ('100007', 'app_code', 'xf9yqkvjhedhxbbbfrqxo66v3ckgz4nz', 'App Code'), ('100008', 'app_key', '9t1srfvbqlffvfevffy4gsfwdcmuxwab', 'App Key'), ('100009', 'user_number', '00000001', 'User Number'), ('100010', 'auth_server', 'http://192.168.0.59/authServer', '授权服务器地址'), ('100011', 'esgateway_server', 'http://192.168.0.57/esGateway', 'esGateWay服务器地址'), ('100012', 'system_logo', '高风险纳税人定向稽查大数据智能分析引擎', 'logo名称'), ('100013', 'dataworker_server', 'http://192.168.0.206:8992/TaxDataWorker', 'dataworker服务器地址'), ('100014', 'result_server', 'http://192.168.0.215:8100/TaxResultWorker', 'result服务器地址'), ('100015', 'modeler_server', '', 'modeler服务器地址'), ('100016', 'es_file_http_reciever', 'http://192.168.0.61/esFileHttpReciever', '文件上传服务器地址'), ('100017', 'file_server', 'http://192.168.0.184', '文件服务器地址'), ('100018', 'upload_file_path', '\\\\192.168.0.184\\share', '上传文件路径'), ('100019', 'service_life_time', '999999999', '每次接口请求有效时间（毫秒）'), ('100020', 'service_number', 'service14815247618409yl5', 'esGateway开放接口服务号'), ('100021', 'task_manager_server', 'http://192.168.0.56/TaskManager', 'TaskManager服务器地址'), ('100022', 'taxview_server', 'http://192.168.0.37:8080/taxview', 'taxview服务器地址'), ('100023', 'reportWorker_server', 'http://192.168.0.56/taxReportWorker', 'report服务器地址');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(32) NOT NULL,
  `u_user_number` varchar(32) DEFAULT NULL,
  `u_user_name` varchar(32) DEFAULT NULL,
  `u_phone` varchar(32) DEFAULT NULL,
  `u_email` varchar(256) DEFAULT NULL,
  `u_password` varchar(64) DEFAULT NULL,
  `u_status` int(11) DEFAULT NULL,
  `u_create_time` datetime DEFAULT NULL,
  `u_qualification_type` int(11) DEFAULT NULL,
  `u_role_type` int(11) DEFAULT NULL,
  `u_update_time` datetime DEFAULT NULL,
  `u_qualification_status` int(11) DEFAULT NULL,
  `u_auth_passed_time` datetime DEFAULT NULL,
  `u_auth_apply_time` datetime DEFAULT NULL,
  `u_auth_nopass_reason` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('402880b55083a97b015083aab8650001', '88888888', 'admin', '13800000000', 'admin@zsyun.com', '0d88f485a99b411444da84ebc13064ee02438226', '1', null, '0', '0', null, '2', null, null, null), ('402880fb5285d6f00152861fb78f004a', '99999999', 'system', '13900000000', 'system@zsyun.com', '6286dd3b1917e404fd38ab1110a6ee200ae2b9d7', '1', null, '0', '1', null, '2', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` varchar(32) NOT NULL,
  `ui_user_id` varchar(32) DEFAULT NULL,
  `ui_name` varchar(32) DEFAULT NULL,
  `ui_sex` int(11) DEFAULT NULL,
  `ui_province` varchar(32) DEFAULT NULL,
  `ui_city` varchar(32) DEFAULT NULL,
  `ui_area` varchar(32) DEFAULT NULL,
  `ui_address` varchar(1024) DEFAULT NULL,
  `ui_phone` varchar(32) DEFAULT NULL,
  `ui_postcode` varchar(32) DEFAULT NULL,
  `ui_email` varchar(64) DEFAULT NULL,
  `ui_head_url` varchar(1024) DEFAULT NULL,
  `ui_id_card_name` varchar(64) DEFAULT NULL,
  `ui_id_card_url` varchar(1024) DEFAULT NULL,
  `ui_create_time` datetime DEFAULT NULL,
  `ui_update_time` datetime DEFAULT NULL,
  `ui_document_type` int(11) DEFAULT NULL,
  `ui_document_id` varchar(1024) DEFAULT NULL,
  `ui_email_start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_info`
-- ----------------------------
BEGIN;
INSERT INTO `user_info` VALUES ('4028802a5580012601558001b21b0001', '402880fb5285d6f00152861fb78f004a', '系统管理员', '0', '', '', '', '', '13900000000', '', 'system@zsyun.com', '', null, null, null, '2016-07-13 14:00:29', null, null, null), ('402880b55590ffa001559101af5f0018', '402880b55083a97b015083aab8650001', '超级管理员', '0', '', '', '', '', '13800000000', '', 'admin@zsyun.com', '', null, null, null, '2016-07-11 11:25:54', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `user_permission`
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission` (
  `id` varchar(32) NOT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `module_id` varchar(32) DEFAULT NULL,
  `module_type` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_permission`
-- ----------------------------
BEGIN;
INSERT INTO `user_permission` VALUES ('40288016572295d50157229bfa80000d', 'manage:manage', '/manage.do', 'perms', '管理', null, '1'), ('40288016572295d50157229cd05a000e', 'userManage:userList', '/v1/html/manage/userManage/query/userList.do', 'perms', '用户列表页面', '402880165745901e01574593d9c80002', '2'), ('40288016572295d50157229d5bc5000f', 'userManage:enableUser', '/v1/html/manage/userManage/update/enableUser.do', 'perms', '启用用户', '402880165745901e015745942b820003', '2'), ('40288016572295d50157229df5760010', 'usreManage:disableUser', '/v1/html/manage/userManage/update/disableUser.do', 'perms', '禁用用户', '402880165745901e015745942b820003', '2'), ('40288016572295d50157229fdb7e0014', 'permissionManage:permissionList', '/v1/html/manage/permissionManage/query/permissionList.do', 'perms', '权限列表', '402880165745901e0157459484bd0005', '2'), ('40288016572295d5015722a040190015', 'permissionManage:createUserPermission', '/v1/html/manage/permissionManage/create/createUserPermission.do', 'perms', '保存权限信息', '402880165745901e01574594bf860006', '2'), ('40288016572295d5015722a094330016', 'permissionManage:deletePermission', '/v1/html/manage/permissionManage/delete/deletePermission.do', 'perms', '删除权限', '402880165745901e01574594f3c20007', '2'), ('40288016572295d5015722a0e8be0017', 'roleManage:roleList', '/v1/html/manage/roleManage/query/roleList.do', 'perms', '角色列表页面', '402880165745901e015745954bb90008', '2'), ('40288016572295d5015722a153510018', 'roleManage:createRole', '/v1/html/manage/roleManage/create/createRole.do', 'perms', '保存角色信息', '402880165745901e01574595c5340009', '2'), ('40288016572295d5015722a1a6bb0019', 'roleManage:deleteRole', '/v1/html/manage/roleManage/delete/deleteRole.do', 'perms', '删除角色信息', '402880165745901e0157459609a5000a', '2'), ('40288016572295d5015722a1f1c9001a', 'roleManage:toRolePermission', '/v1/html/manage/roleManage/create/toRolePermission.do', 'perms', '添加角色权限页面', '402880165745901e0157459632d0000b', '2'), ('40288016572295d5015722a24d38001b', 'roleManage:createRolePermission', '/v1/html/manage/roleManage/create/createRolePermission.do', 'perms', '保存角色权限信息', '402880165745901e0157459632d0000b', '2'), ('40288016572295d5015722a2b7d6001c', 'menuManage:menuList', '/v1/html/manage/menuManage/query/menuList.do', 'perms', '菜单列表', '40288016574bc42501574be6c4650005', '2'), ('40288016572295d5015722a3128c001d', 'menuManage:toMenu', '/v1/html/manage/menuManage/create/toMenu.do', 'perms', '添加菜单页面', '40288016574bc42501574be721fe0006', '2'), ('40288016572295d5015722a366e9001e', 'menuManage:createMenu', '/v1/html/manage/menuManage/create/createMenu.do', 'perms', '保存菜单信息', '40288016574bc42501574be721fe0006', '2'), ('40288016572295d5015722a3c45e001f', 'menuManage:deleteMenu', '/v1/html/manage/menuManage/delete/deleteMenu.do', 'perms', '删除菜单信息', '40288016574bc42501574be761af0007', '2'), ('40288016572295d5015722a4550f0020', 'moduleManage:moduleList', '/v1/html/manage/moduleManage/query/moduleList.do', 'perms', '模块列表页面', '40288016574f817c01574f84605d0002', '2'), ('40288016572295d5015722a4a2be0021', 'moduleManage:toModule', '/v1/html/manage/moduleManage/create/toModule.do', 'perms', '添加模块页面', '40288016574f817c01574f87d0560003', '2'), ('40288016572295d5015722a4ed3c0022', 'moduleManage:createmodule', '/v1/html/manage/moduleManage/create/createModule.do', 'perms', '保存模块信息', '40288016574f817c01574f87d0560003', '2'), ('40288016572295d5015722a546500023', 'moduleManage:deleteModule', '/v1/html/manage/moduleManage/delete/deleteModule.do', 'perms', '删除模块信息', '40288016574f817c01574f8829450004', '2'), ('40288016572295d5015722a59b3f0024', 'user:user', '/user.do', 'perms', '用户中心菜单', null, '1'), ('40288016572295d5015722a5fde10025', 'basicData:userInfo', '/v1/html/user/basicData/query/userInfo.do', 'perms', '用户信息显示页面', '40288016574f817c01574f88b0e60005', '2'), ('40288016572295d5015722a6453b0026', 'basicData:updateUserInfo', '/v1/html/user/basicData/update/updateUserInfo.do', 'perms', '保存用户信息', '40288016574f817c01574f88b0e60005', '2'), ('40288016572295d5015722a73ae60028', 'passwordSettings:toUpdatePassword', '/v1/html/user/passwordSettings/update/toUpdatePassword.do', 'perms', '修改密码页面', '40288016574f817c01574f8910270006', '2'), ('40288016572295d5015722a7891c0029', 'passwordSettings:updatePassword', '/v1/html/user/passwordSettings/update/updatePassword.do', 'perms', '更新用户密码', '40288016574f817c01574f8910270006', '2'), ('40288016574bc42501574becf4430009', 'menuManage:toUpdateMenu', '/v1/html/manage/menuManage/update/toUpdateMenu.do', 'perms', '编辑菜单页面', '40288016574bc42501574be7f2440008', '2'), ('40288016574bc42501574bee0018000a', 'menuManage:updateMenu', '/v1/html/manage/menuManage/update/updateMenu.do', 'perms', '更新菜单信息', '40288016574bc42501574be7f2440008', '2'), ('40288016574bef7801574bf218580003', 'permissionManage:toUpdatePermission', '/v1/html/manage/permissionManage/update/toUpdatePermission.do', 'perms', '编辑权限页面', '40288016574bef7801574bf11c000002', '2'), ('40288016574bef7801574bf2de2a0004', 'permissionManage:updatePermission', '/v1/html/manage/permissionManage/update/updatePermission.do', 'perms', '更新权限信息', '40288016574bef7801574bf11c000002', '2'), ('4028808b5778d0ad015778d5bad90002', 'port', '/v1/port/**', 'anon', '开放接口', null, '1'), ('402880ae5ad5b9bf015ad5bbd4dd0003', 'systemManage:system', '/v1/html/manage/systemManage/update/system.do', 'perms', '参数设置修改logging页面', '402880ae5ad5b9bf015ad5bb2e8b0002', '2'), ('402880b551f1e09b0151f1e16f200002', 'anon', '/', 'anon', '根目录访问授权', null, '3'), ('402880b551f62c3b0151f69abe4b0002', 'anon', '/v1/anon/**', 'anon', '匿名访问接口功能', null, '3');
COMMIT;

-- ----------------------------
--  Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `default_role` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_role`
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES ('402880b551f1f0d80151f1f102700001', '超级管理员', '拥有业务最高权限', '1'), ('402880b551f1f0d80151f1f21a0a0004', '普通用户', '普通用户权限', '1'), ('402880fb5285d6f0015286216bd8004e', '系统管理员', '拥有系统最高权限', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
