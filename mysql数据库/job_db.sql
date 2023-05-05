/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.6
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost:3306
 Source Schema         : job_db

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : 65001

 Date: 15/01/2021 18:51:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery`  (
  `deliveryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '投递id',
  `jobObj` int(11) NOT NULL COMMENT '投递职位',
  `userObj` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '投递人',
  `deliveryTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '投递时间',
  `handleState` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理状态',
  `handleContent` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理内容',
  `evaluate` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对学生评价',
  PRIMARY KEY (`deliveryId`) USING BTREE,
  INDEX `jobObj`(`jobObj`) USING BTREE,
  INDEX `userObj`(`userObj`) USING BTREE,
  CONSTRAINT `t_delivery_ibfk_1` FOREIGN KEY (`jobObj`) REFERENCES `t_job` (`jobId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_delivery_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_delivery
-- ----------------------------
INSERT INTO `t_delivery` VALUES (2, 2, '13612345678', '2021-01-11 15:32:11', '面试通过', '你的简历我看了，感觉不错，周一来面试', '--');
INSERT INTO `t_delivery` VALUES (5, 2, '13512345678', '2021-01-12 17:09:28', '面试通过', '--', '--');

-- ----------------------------
-- Table structure for t_evaluate
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluate`;
CREATE TABLE `t_evaluate`  (
  `evaluateId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `sellerObj` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '被评价商家',
  `evaluateScore` float NOT NULL COMMENT '评分',
  `evaluateContent` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评价内容',
  `userObj` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论用户',
  `evaluateTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评价时间',
  PRIMARY KEY (`evaluateId`) USING BTREE,
  INDEX `sellerObj`(`sellerObj`) USING BTREE,
  INDEX `userObj`(`userObj`) USING BTREE,
  CONSTRAINT `t_evaluate_ibfk_1` FOREIGN KEY (`sellerObj`) REFERENCES `t_seller` (`sellerUserName`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_evaluate_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_evaluate
-- ----------------------------
INSERT INTO `t_evaluate` VALUES (4, '13122221111', 3.5, 'bucuo', '13512345678', '2021-01-13 19:30:16');

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job`  (
  `jobId` int(11) NOT NULL AUTO_INCREMENT COMMENT '职位id',
  `jobName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '职位名称',
  `jobDesc` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '职位描述',
  `workPay` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作薪酬',
  `needNum` int(11) NOT NULL COMMENT '招聘人数',
  `workAddress` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作地址',
  `connectPerson` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `sellerObj` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布商家',
  `addTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`jobId`) USING BTREE,
  INDEX `sellerObj`(`sellerObj`) USING BTREE,
  CONSTRAINT `t_job_ibfk_1` FOREIGN KEY (`sellerObj`) REFERENCES `t_seller` (`sellerUserName`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES (2, '外卖骑手', '负责给周边客户送餐', '4500', 5, '华林一路10号', '王先生', '028-83984232', '13688886666', '2021-01-11 15:15:12');
INSERT INTO `t_job` VALUES (3, 'ccc', '111', '21', 11, '34', '11', '13598129342', '13122221111', '2021-01-14 22:31:57');

-- ----------------------------
-- Table structure for t_leaveword
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword`  (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言时间',
  `replyContent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复内容',
  `replyPerson` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复人',
  `replyTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`) USING BTREE,
  INDEX `userObj`(`userObj`) USING BTREE,
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES (2, '我想当骑手', '加入美团外卖，听说没自由真的假的', '13612345678', '2021-01-11 18:03:22', '时间只有，多劳多得', 'sh001', '2021-01-11 18:03:47');
INSERT INTO `t_leaveword` VALUES (3, 'aaa', 'bb', '13512345678', '2021-01-13 17:41:33', 'gafafa', 'a', '2021-01-15 18:50:59');
INSERT INTO `t_leaveword` VALUES (4, 'aaa', 'bb', '13512345678', '2021-01-13 17:41:33', '--', '--', '--');

-- ----------------------------
-- Table structure for t_seller
-- ----------------------------
DROP TABLE IF EXISTS `t_seller`;
CREATE TABLE `t_seller`  (
  `sellerUserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sellerUserName',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预留密码段',
  `sellerName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商户名称',
  `sellerPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商户照片',
  `workContent` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '经营内容',
  `workTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '经营时间',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `workAddress` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作地址',
  `workLicense` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '营业许可证',
  `scoreValue` float NOT NULL COMMENT '评价分数',
  `shenHeState` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审核状态',
  `addTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '注册时间',
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信openid',
  PRIMARY KEY (`sellerUserName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_seller
-- ----------------------------
INSERT INTO `t_seller` VALUES ('13122221111', '--', '牵着蜗牛去逛街', 'upload/NoImage.jpg', '--', '--', '--', '--', 'upload/NoImage.jpg', 0, '待审核', '2021-01-12 00:29:52', 'oM7Mu5XyeVJSc8roaUCRlcz_IP9k');
INSERT INTO `t_seller` VALUES ('13688886666', '123', '美团外卖华林店', 'upload/NoImage.jpg', '餐饮', '08:00-23:00', '028-83419812', '红星路10号', 'upload/NoImage.jpg', 3.5, '已审核', '2021-01-05 14:11:22', NULL);

-- ----------------------------
-- Table structure for t_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo`  (
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'user_name',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预留密码段',
  `yxbj` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '院系班级',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `birthDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `userPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `address` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `grjl` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '个人简历',
  `regTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册时间',
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('13512345678', '--', '信工院计算机1班', '牵着蜗牛去逛街', '男', '2020-01-01', 'upload/b4dc818c3bba4992952bd261316bc0f5', '13512345678', 'xiaowang@126.com', '四川南充', '我精通java开发', '2021-01-12 15:30:14', 'oM7Mu5XyeVJSc8roaUCRlcz_IP9i');
INSERT INTO `t_userinfo` VALUES ('13612345678', '123', '信工院计算机3班', '李晓明', '男', '2020-12-29', 'upload/NoImage.jpg', '13513145252', 'xiaoming@126.com', '成都市红星路10号 ', '我精通计算机开发', '2021-01-11 17:28:11', NULL);

SET FOREIGN_KEY_CHECKS = 1;
