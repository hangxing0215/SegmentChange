//
//  ViewController.m
//  张艳林公司机试题
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "News.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSMutableArray *array1;
@property (nonatomic,strong)NSMutableArray *array2;

@property (nonatomic,strong)NSMutableArray *mutableArray;

@end

@implementation ViewController

- (NSMutableArray *)array1
{
    if (_array1 == nil) {
        News *new1 = [[News alloc]init];
        new1.imageName = @"aaaa";
        new1.title = @"第一个界面的标题";
        new1.content = @"第一个界面的内容";
        new1.time = @"一发布的时间";
        _array1 = [NSMutableArray array];
        for (int i = 0; i < 10; i++)
        {
            [_array1 addObject:new1];
        }
       
        
    }
    return _array1;
}
- (NSMutableArray *)array2
{
    if (_array2 == nil) {
        News *new2 = [[News alloc]init];
        new2.imageName = @"aaaa";
        new2.title = @"第二个界面的标题";
        new2.content = @"第二个界面的内容";
        new2.time = @"二发布的时间";
        _array2 = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            [_array2 addObject:new2];
        }
    }
    return _array2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSegment];
    [self segmentValueChanged:self.segment];
    
}

- (void)setupSegment
{
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)segmentValueChanged:(UISegmentedControl *)segment
{
        [self setupScrollViewWithSelectedIndex:segment.selectedSegmentIndex];
    [self setupTableViewWithSelectedIndex:segment.selectedSegmentIndex];
        [self setupPageControl];
    
}
- (void)setupScrollViewWithSelectedIndex:(NSInteger)segmentIndex
{
    
    self.scrollView.delegate = self;
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, 150)];
        
        //提前把翻页的点点归零
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        if (segmentIndex == 0)
        {
            imageView.image = [UIImage imageNamed:@"aaaa"];

        }
        else
        {
            imageView.image = [UIImage imageNamed:@"bbbb"];

        }
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 150);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.pagingEnabled = YES;
    
}
- (void)setupPageControl
{
    //添加点点
    UIPageControl *pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, self.scrollView.frame.origin.y + self.scrollView.frame.size.height - 20, 50, 20)];
    pageController.numberOfPages = 3;
    pageController.pageIndicatorTintColor = [UIColor redColor];
    pageController.currentPageIndicatorTintColor = [UIColor greenColor];
    [self.view addSubview:pageController];
    self.pageControl = pageController;
}
- (void)setupTableViewWithSelectedIndex:(NSInteger)selectedIndex
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.mutableArray = [NSMutableArray array];
    if (selectedIndex == 0)
    {
        [self.mutableArray removeAllObjects];
        [self.mutableArray addObjectsFromArray:self.array1];
        
    }
    else
    {
        [self.mutableArray removeAllObjects];
        [self.mutableArray addObjectsFromArray:self.array2];
    }
    [self.tableView reloadData];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"...........");
    MyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    News *news = self.mutableArray[indexPath.row];
    cell.headerImageView.image = [UIImage imageNamed:news.imageName];
    cell.titleLabel.text = news.title;
    cell.contentLabel.text = news.content;
    cell.timeLabel.text = news.time;
    return cell ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
}

@end
