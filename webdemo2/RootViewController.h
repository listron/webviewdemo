//
//  RootViewController.h
//  MiAiApp
//
//  Created by zhangqiang on 2017/5/18.
//  Copyright © 2017年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MJRefresh/MJRefresh.h>
//#import "UIViewController+AlertViewAndActionSheet.h"
/**
 VC 基类
 */
@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色(View controller-based status bar appearance目前是NO，所以设置无效)
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;


@property (nonatomic, strong) UITableView * plainTableView;
@property (nonatomic, strong) UITableView * groupTableView;
@property (nonatomic, strong) UICollectionView * collectionView;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  加载视图
 */
- (void)showLoadingAnimation;

/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLeftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 导航栏添加文本按钮

 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮

 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 跳转控制器(push)
 
 @param controller 控制器名称
 @param title 控制器标题
 */
- (instancetype)pushViewController:(NSString *)controller title:(NSString *)title animated:(BOOL)animated;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

/**
 子类重写
 */
- (void)setupUI;

/**
 子类重写
 */
- (void)loadData;

//取消网络请求
- (void)cancelRequest;



/**
 下拉刷新
 */
-(void)headerRereshing;

/**
 上拉加载
 */
-(void)footerRereshing;

@end
