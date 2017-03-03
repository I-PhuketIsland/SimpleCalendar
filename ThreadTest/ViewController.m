//
//  ViewController.m
//  ThreadTest
//
//  Created by Lee on 2017/2/25.
//  Copyright © 2017年 李家乐. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "CollectionViewCell.h"
#import "UIView+Frame.h"
#import "Data.h"
static NSString * const cellId = @"cell";



@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) NSMutableArray* totalDay;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, assign) NSInteger currentDay;

@property (weak, nonatomic) IBOutlet UILabel *labelShow;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UICollectionView *uicollectionView;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) NSDate* selectDate;
/*
 <#name#>: <#description#>
 */
@property (nonatomic, strong) NSDateFormatter* dateFormatter;
@end

@implementation ViewController
- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    return _dateFormatter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _totalDay = [NSMutableArray new];
    NSDate *currentDate = [NSDate date];
    _selectDate = currentDate;
    self.labelShow.text = [self.dateFormatter stringFromDate:_selectDate];
    
    [self getData];
    
    
    [self.uicollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    self.uicollectionView.backgroundColor = [UIColor clearColor];
}
- (void)getData {
    _totalDay = [NSMutableArray new];
    NSInteger  countDay = [Data totaldaysInMonth:_selectDate];
    NSInteger  weakDay = [Data firstWeekdayInThisMonth:_selectDate];
    for (int i = 0; i < countDay + weakDay; i ++) {
        if (i< weakDay) {
            [_totalDay addObject:@""];
        }else {
            [_totalDay addObject:[NSString stringWithFormat:@"%ld",i - weakDay + 1 ]];
        }
    }
    self.labelMonth.text = [NSString stringWithFormat:@"%ld月",[Data month:_selectDate]];
    [self backToCurrentDate:_selectDate];
    [self.uicollectionView reloadData];
}
- (IBAction)nextMonth:(id)sender {
    NSMutableArray * arr = [Data yearMonthDay:self.selectDate];
    if ([arr[1] integerValue] + 1 <= 12) {
        arr[1] = [NSString stringWithFormat:@"%ld",[arr[1] integerValue] + 1];
    }
    arr[2] = [NSString stringWithFormat:@"%d",1];
    NSDate *date =  [self.dateFormatter dateFromString:[NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]]];
    self.selectDate = date;
    self.labelShow.text = [self.dateFormatter stringFromDate:self.selectDate];
    [self getData];
}
- (IBAction)lastMonth:(id)sender {
    NSMutableArray * arr = [Data yearMonthDay:self.selectDate];
    if ([arr[1] integerValue] - 1 >= 1) {
        arr[1] = [NSString stringWithFormat:@"%ld",[arr[1] integerValue] - 1];
    }
    arr[2] = [NSString stringWithFormat:@"%d",1];
    NSDate *date =  [self.dateFormatter dateFromString:[NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]]];
    self.selectDate = date;
    self.labelShow.text = [self.dateFormatter stringFromDate:self.selectDate];
    [self getData];
}
- (void)backToCurrentDate:(NSDate*)date {
    NSArray *arrSelect = [Data yearMonthDay:date];
    NSArray *arrCurrent = [Data yearMonthDay:[NSDate date]];
    if ([arrSelect[0] isEqual:arrCurrent[0]] && [arrSelect[1] isEqual:arrCurrent[1]]) {
        _currentDay = [arrCurrent[2] integerValue];
    }else {
        _currentDay = [Data day:_selectDate];
    }
}
- (IBAction)tapSelectDate:(id)sender {
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    }
    return view;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    
    cell.labelDay.text = _totalDay[indexPath.item];
    if ([cell.labelDay.text isEqualToString:@""]) {
        cell.userInteractionEnabled = NO;
    }else {
        cell.userInteractionEnabled = YES;
        if ([cell.labelDay.text isEqualToString:[NSString stringWithFormat:@"%ld",_currentDay]]) {
            cell.selected = YES;
        }else {
            cell.selected = NO;
        }
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalDay.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kWidth/7, kWidth/7);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    NSArray * arr = [collectionView visibleCells];
    for (CollectionViewCell *cell in arr) {
        cell.selected = NO;
    }
   
    
    
    NSDate *date = [self.dateFormatter dateFromString:self.labelShow.text];
    NSMutableArray *marr = [Data yearMonthDay:date];
    NSString* sele = [NSString stringWithFormat:@"%@年%@月%@日",marr[0],marr[1],_totalDay[indexPath.item]];
    NSDate *sel = [self.dateFormatter dateFromString:sele];
    self.labelShow.text  =[self.dateFormatter stringFromDate:sel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
