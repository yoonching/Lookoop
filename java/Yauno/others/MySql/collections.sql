-- 2019-4-5

-- DROP TABLE IF EXISTS `user`;
-- SET @saved_cs_client = @@character_set_client;
-- SET character_set_client = utf8;

-- 创建用户信息
CREATE TABLE IF NOT EXISTS user(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(100) NOT NULL COMMENT '登录名',
	password VARCHAR(100) NOT NULL,
	email VARCHAR(255) NOT NULL,
	profile VARCHAR(255) NOT NULL,
	is_active VARCHAR(1) DEFAULT '1',
	is_admin VARCHAR(1) DEFAULT '0'
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 用户信息
CREATE TABLE IF NOT EXISTS user_info(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	nickname VARCHAR(100) NOT NULL,
	gender ENUM('male', 'female', 'secret') DEFAULT 'secret',
	hobbies VARCHAR(100) DEFAULT '没有留下',
	FOREIGN KEY(user_id) REFERENCES user(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 登录信息
CREATE TABLE IF NOT EXISTS login_log(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL, 
	login_ip INT NOT NULL, 	-- inet_aton()：把IP地址转化为数字
							-- inet_ntoa()：把数字转化成IP地址
	create_time DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	FOREIGN KEY(user_id) REFERENCES user(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 角色
-- 角色管理
CREATE TABLE IF NOT EXISTS role(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
	role_name VARCHAR(100) NOT NULL,
	role_val INT NOT NULL,
	url VARCHAR(255) NOT NULL,
	is_active VARCHAR(1) DEFAULT '1',
	info VARCHAR(255) DEFAULT '什么也没有留下'
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 用户角色
CREATE TABLE IF NOT EXISTS role_user(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
	user_id INT UNSIGNED NOT NULL,  
	role_id INT UNSIGNED NOT NULL, 
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(role_id) REFERENCES role(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 资源
CREATE TABLE IF NOT EXISTS resource(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	resource_name VARCHAR(100) NOT NULL,
	url VARCHAR(255) NOT NULL,
	is_active VARCHAR(1) DEFAULT '1',
	info VARCHAR(255) DEFAULT '什么也没有留下'
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 角色资源
CREATE TABLE IF NOT EXISTS role_resource(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL, 
	resource_id INT UNSIGNED NOT NULL, 
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(resource_id) REFERENCES resource(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- 文章分类
CREATE TABLE IF NOT EXISTS category(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	category_name VARCHAR(100) NOT NULL,
	description VARCHAR(255) NOT NULL,
	paper_count INT UNSIGNED DEFAULT 0,
	status VARCHAR(1) DEFAULT '1',
	secrete VARCHAR(1) DEFAULT '1',
	sorts INT UNSIGNED DEFAULT 0
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 文章
CREATE TABLE IF NOT EXISTS article(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
	user_id INT UNSIGNED NOT NULL,  
	-- user_profile 使用关联，因为头像可能会变
	-- user_nickname 使用关联
	category_id INT UNSIGNED NOT NULL, 
	title VARCHAR(255) NOT NULL,
	content TEXT NOT NULL,
	status VARCHAR(1) DEFAULT '1',
	is_secrete VARCHAR(1) DEFAULT '0' COMMENT '是否公开,默认公开',
	upvote INT UNSIGNED DEFAULT 0,
	downvote INT UNSIGNED DEFAULT 0,
	comment_count INT UNSIGNED DEFAULT 0,
	create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(category_id) REFERENCES category(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 评论
CREATE TABLE IF NOT EXISTS comment(
	id INT  PRIMARY KEY AUTO_INCREMENT, 
	user_id INT UNSIGNED NOT NULL, 
	pcomment_id INT DEFAULT -1 COMMENT '-1表示无父评论', 
	article_id INT UNSIGNED NOT NULL, 
	content TEXT NOT NULL,
	upvote INT UNSIGNED DEFAULT 0,
	downvote INT UNSIGNED DEFAULT 0,
	status VARCHAR(1) DEFAULT '1',
	create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(pcomment_id) REFERENCES comment(id),
	FOREIGN KEY(article_id) REFERENCES article(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 点赞数
CREATE TABLE IF NOT EXISTS upvote(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
	user_id INT UNSIGNED NOT NULL, 
	article_id INT UNSIGNED NOT NULL, 
	ip INT NOT NULL, 
	type VARCHAR(1) DEFAULT '1' COMMENT '点赞类型，默认为点赞，`0`为踩',
	create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(article_id) REFERENCES article(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;