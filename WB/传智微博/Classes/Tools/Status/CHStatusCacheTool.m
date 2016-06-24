//
//  CHStatusCacheTool.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusCacheTool.h"
#import "FMDB.h"
#import "CHStatus.h"
#import "CHAccountTool.h"
#import "CHAccount.h"
#import "CHStatusParam.h"
@implementation CHStatusCacheTool

static FMDatabase *_db;

+ (void)initialize {
    // 1、创建沙盒位置
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 2、拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"status.sqlite"];
    // 3、创建了一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    // 4、打开数据库
    if ([_db open]) {
//        NSLog(@"打开成功");
    }else{
//        NSLog(@"打开失败");
    }
    // 5、创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (flag) {
//        NSLog(@"创建成功");
    }else{
//        NSLog(@"创建失败");
    }
}

// 保存数据(插入数据)
+ (void)saveWithStatuses:(NSArray *)statuses {
    // 遍历模型数组
    DDLog();
    for (NSDictionary *statusDict in statuses) {
        // idstr,accessToken,data
        NSString *idstr = statusDict[@"idstr"];
        NSString *accessToken = [CHAccountTool account].access_token;
        // 归档(将数据转换为二进制)
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        // 将数据插入到数据库
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?)",idstr,accessToken,data];
        if (flag) {
            CHLog(@"插入成功");
        }else{
            CHLog(@"插入失败");
        }
    }
}

// 加载数据(查询)
+ (NSArray *)statusesWithParam:(CHStatusParam *)param {
    // 进入程序第一次获取的查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
    DDLog();
    // 获取最新微博的查询语句
    if (param.since_id) {
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;",param.access_token,param.since_id];
    // 获取更多微博的查询语句
    }else if (param.max_id) {
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    // set集合
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        // 给集合起个dict名字，将集合转成二进制数据
        NSData *data = [set dataForColumn:@"dict"];
        // 接档(将二进制数据转换为字典)
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        // 将字典转换为模型数据
        CHStatus *s = [CHStatus mj_objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    return arrM;
}

@end
