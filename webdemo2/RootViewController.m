//
//  RootViewController.m
//  MiAiApp
//
//  Created by zhangqiang on 2017/5/18.
//  Copyright © 2017年 zhangqiang. All rights reserved.
//

#import "RootViewController.h"
//#import "LoginViewController.h"
//#import <UShareUI/UShareUI.h>
#import "UtilsMacros.h"


@interface RootViewController ()

@property (nonatomic,strong) UIImageView* noDataView;

@end

@implementation RootViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}

//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //是否显示返回按钮
    self.isShowLeftBack = YES;
    //默认导航栏样式：黑字
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setStatusBarBackgroundColor:[UIColor blueColor]];
    [self setupUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)pushTo:(RootViewController *)controller title:(NSString *)title {
    
}

- (void)setupUI {
    
}

- (void)loadData {
    
}

- (void)showLoadingAnimation
{
   
}

- (void)stopLoadingAnimation
{
   
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)showNoDataImage
{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:_noDataView];
        }
    }];
}

-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)plainTableView {
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight -kBottomHeight) style:UITableViewStylePlain];
        [self configTableView:_plainTableView];
    }
    return _plainTableView;
}

- (UITableView *)groupTableView {
    if (!_groupTableView) {
        _groupTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight -kBottomHeight) style:UITableViewStyleGrouped];
        [self configTableView:_groupTableView];
    }
    return _groupTableView;
}

- (void)configTableView:(UITableView *)tableView {
    if (@available(iOS 11.0, *)) {
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.00001)];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

//    //头部刷新
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    tableView.mj_header = header;
//
//    //底部刷新
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    //        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    //        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
//
//    tableView.backgroundColor=CViewBgColor;
//    tableView.scrollsToTop = YES;
//    tableView.tableFooterView = [[UIView alloc] init];
}

/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight - kTopHeight - kBottomHeight) collectionViewLayout:flow];
//
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//        header.automaticallyChangeAlpha = YES;
//        header.lastUpdatedTimeLabel.hidden = YES;
//        header.stateLabel.hidden = YES;
//        _collectionView.mj_header = header;
//
//        //底部刷新
//        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

//#ifdef kiOS11Before
//        
//#else
//        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
//        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
//#endif
        
        _collectionView.backgroundColor=[UIColor redColor];
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}
-(void)headerRereshing{
    
}

-(void)footerRereshing{
    
}

/**
 *  是否显示返回按钮
 */
- (void) setIsShowLeftBack:(BOOL)isShowLeftBack
{
    _isShowLeftBack = isShowLeftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLeftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        [self addNavigationItemWithImageNames:@[@"back_icon_left"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark ————— 导航栏 添加图片按钮 —————
/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (isLeft) {
//            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
//            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark ————— 导航栏 添加文字按钮 —————
- (NSMutableArray<UIButton *> *)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        
        //设置偏移
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
    return buttonArray;
}

//跳转(push)
- (instancetype)pushViewController:(NSString *)controller title:(NSString *)title animated:(BOOL)animated;
{
    Class second = NSClassFromString(controller);
    id secondVC = [[second alloc]init];
    ((UIViewController*)secondVC).title = title;
    [self.navigationController pushViewController:secondVC animated:animated];
    return secondVC;
}

//取消请求
- (void)cancelRequest
{
    
}

- (void)dealloc
{
    [self cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -  屏幕旋转
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
