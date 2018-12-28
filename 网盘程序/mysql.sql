
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '用户名',
  `pass` varchar(32) DEFAULT '' COMMENT '登录密码',
  `nichen` varchar(20) DEFAULT '' COMMENT '昵称',
  `logip` varchar(20) DEFAULT '' COMMENT '最后登录IP',
  `logtime` int(11) DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '111', '698d51a19d8a121ce581499d7b701668', '烟雨江南', '127.0.0.1', '1526637003');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `fid` int(11) DEFAULT '0',
  `xid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '电影', '0', '1');
INSERT INTO `class` VALUES ('2', '电视剧', '0', '2');
INSERT INTO `class` VALUES ('3', '动漫里番', '0', '3');
INSERT INTO `class` VALUES ('5', '岛国大片', '0', '1');
INSERT INTO `class` VALUES ('6', '岛国大片', '0', '1');

-- ----------------------------
-- Table structure for fav
-- ----------------------------
DROP TABLE IF EXISTS `fav`;
CREATE TABLE `fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT '0',
  `did` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fav
-- ----------------------------

-- ----------------------------
-- Table structure for myclass
-- ----------------------------
DROP TABLE IF EXISTS `myclass`;
CREATE TABLE `myclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `name` varchar(64) DEFAULT '',
  `fid` int(11) DEFAULT '0',
  `xid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myclass
-- ----------------------------
INSERT INTO `myclass` VALUES ('1', '1', '电影', '0', '0');
INSERT INTO `myclass` VALUES ('2', '1', '电视剧', '0', '0');
INSERT INTO `myclass` VALUES ('3', '1', '动作片', '1', '0');
INSERT INTO `myclass` VALUES ('4', '1', '爱情片', '1', '0');
INSERT INTO `myclass` VALUES ('5', '1', '动漫', '0', '0');
INSERT INTO `myclass` VALUES ('6', '1', 'Vip专享', '0', '0');
INSERT INTO `myclass` VALUES ('7', '1', '岛国大片', '6', '0');
INSERT INTO `myclass` VALUES ('8', '1', '国产剧', '2', '0');
INSERT INTO `myclass` VALUES ('9', '1', '港台剧', '2', '0');
INSERT INTO `myclass` VALUES ('10', '1', '日韩剧', '2', '0');

-- ----------------------------
-- Table structure for server
-- ----------------------------
DROP TABLE IF EXISTS `server`;
CREATE TABLE `server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `apiurl` varchar(255) DEFAULT '',
  `apikey` varchar(128) DEFAULT '',
  `zmnum` smallint(5) DEFAULT '0',
  `mp4dir` varchar(128) DEFAULT '',
  `m3u8dir` varchar(128) DEFAULT '',
  `cdnurl` varchar(255) DEFAULT '',
  `zsize` bigint(20) DEFAULT '0',
  `size` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of server
-- ----------------------------
INSERT INTO `server` VALUES ('1', '服务器1', 'http://www.ctcms.com/pan/', 'sdhnosadnosaidmsa', '10', './video/data/', './video/m3u8/', 'http://www.ctcms.com/pan/', '500000000000000', '280950784');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT '',
  `pass` varchar(32) DEFAULT '',
  `email` varchar(32) DEFAULT '',
  `qq` varchar(20) DEFAULT '',
  `url` varchar(64) DEFAULT '',
  `zt` tinyint(1) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '65249a60e116db0305efc5ee042f28b4', 'chshcms@qq.com', '', '', '0', '1526367757');

-- ----------------------------
-- Table structure for user_log
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `ip` varchar(20) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_log
-- ----------------------------
INSERT INTO `user_log` VALUES ('1', '2', '127.0.0.1', 'Windows 7&nbsp;/&nbsp;Chrome v55.0.2883.87', '1526367867');

-- ----------------------------
-- Table structure for vod
-- ----------------------------
DROP TABLE IF EXISTS `vod`;
CREATE TABLE `vod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` varchar(20) DEFAULT '',
  `name` varchar(255) DEFAULT '',
  `cid` int(11) DEFAULT '0',
  `mycid` int(11) DEFAULT '0',
  `duration` varchar(32) DEFAULT '',
  `size` bigint(20) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `filepath` varchar(255) DEFAULT '',
  `zt` tinyint(1) DEFAULT '0',
  `fid` tinyint(3) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  `zmtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `time` (`addtime`),
  KEY `vid` (`vid`),
  KEY `zmtime` (`zt`,`zmtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;