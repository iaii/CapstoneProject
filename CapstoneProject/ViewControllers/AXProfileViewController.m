//
//  ProfileViewController.m
//  CapstoneProject
//
//  Created by Apoorva Chilukuri on 8/3/22.
//

#import "AXProfileViewController.h"
#import "FSCalendar.h"
#import "FSCalendarCalculator.h"
#import <Parse/Parse.h>

@interface AXProfileViewController () <UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (weak , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) FSCalendarCalculator *calculator;
@property (weak  , nonatomic) FSCalendarCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *displaySelectedAcitivity;
@property (weak, nonatomic) NSString *userDate;

@end

@implementation AXProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(35, 200, 320, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    [self.view layoutIfNeeded];
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [self.formatter dateFromString:@"2016-09-10"];

    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy/MM/dd";
    NSString *string = [self.formatter stringFromDate:date];
    NSLog(@"Date is %@", string);
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger era = [self.gregorian component:NSCalendarUnitEra fromDate:date];
    NSInteger year = [self.gregorian component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [self.gregorian component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [self.gregorian component:NSCalendarUnitDay fromDate:date];
    NSInteger hour = [self.gregorian component:NSCalendarUnitHour fromDate:date];
    NSInteger minute = [self.gregorian component:NSCalendarUnitMinute fromDate:date];
    
//    NSDate *nextMonth = [self.gregorain dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:date options:0];
//    NSDate *nextDay = [self.gregorain dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];

    BOOL isToday = [self.gregorian isDateInToday:date];
    BOOL isYesterday = [self.gregorian isDateInYesterday:date];
    BOOL isTomorrow = [self.gregorian isDateInTomorrow:date];
    BOOL isWeekend = [self.gregorian isDateInWeekend:date];
    
    
//    BOOL sameDay = [self.gregorian isDate:date1 inSameDayAsDate:date2];
//    // Yes if the date1 and date2 are in same day
//
//
//    [self.gregorian compareDate:date1 toDate:date2 toUnitGranularity:unit];
//    // compare the era/year/month/day/hour/minute .etc ...
//    // return NSOrderAscending/NSOrderSame/NSOrderDecending
//
//    BOOL inSameUnit = [self.gregorian isDate:date1 equalToDate:date2 toUnitGranularity:unit];
//    // if the given unit (era/year/month/day/hour/minute .etc) are the same
}

//- (void)reloadData
//{
//    _needsRequestingBoundingDates = YES;
//    if ([self requestBoundingDatesIfNecessary] || !self.collectionView.indexPathsForVisibleItems.count) {
//        [self invalidateHeaders];
//    }
//    [self.collectionView reloadData];
//}
//
//- (void)setScope:(FSCalendarScope)scope animated:(BOOL)animated
//{
//    if (self.floatingMode) return;
//    if (self.transitionCoordinator.state != FSCalendarTransitionStateIdle) return;
//    
//    [self performEnsuringValidLayout:^{
//        [self.transitionCoordinator performScopeTransitionFromScope:self.scope toScope:scope animated:animated];
//    }];
//}
//
//- (void)setPlaceholderType:(FSCalendarPlaceholderType)placeholderType
//{
//    _placeholderType = placeholderType;
//    if (self.hasValidateVisibleLayout) {
//        _preferredRowHeight = FSCalendarAutomaticDimension;
//        [_collectionView reloadData];
//    }
//    [self adjustBoundingRectIfNecessary];
//}
//
//- (void)setAdjustsBoundingRectWhenChangingMonths:(BOOL)adjustsBoundingRectWhenChangingMonths
//{
//    _adjustsBoundingRectWhenChangingMonths = adjustsBoundingRectWhenChangingMonths;
//    [self adjustBoundingRectIfNecessary];
//}
//
//- (void)selectDate:(NSDate *)date
//{
//    [self selectDate:date scrollToDate:YES];
//}
//
//- (void)selectDate:(NSDate *)date scrollToDate:(BOOL)scrollToDate
//{
//    [self selectDate:date scrollToDate:scrollToDate atMonthPosition:FSCalendarMonthPositionCurrent];
//}
//
//- (void)deselectDate:(NSDate *)date
//{
//    date = [self.gregorian startOfDayForDate:date];
//    if (![_selectedDates containsObject:date]) {
//        return;
//    }
//    [_selectedDates removeObject:date];
//    [self deselectCounterpartDate:date];
//    NSIndexPath *indexPath = [self.calculator indexPathForDate:date];
//    if ([_collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
//        [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
//        FSCalendarCell *cell = (FSCalendarCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//        cell.selected = NO;
//        [cell configureAppearance];
//    }
//}
//
//- (void)selectDate:(NSDate *)date scrollToDate:(BOOL)scrollToDate atMonthPosition:(FSCalendarMonthPosition)monthPosition
//{
//    if (!self.allowsSelection || !date) return;
//        
//    [self requestBoundingDatesIfNecessary];
//    
//    FSCalendarAssertDateInBounds(date,self.gregorian,self.minimumDate,self.maximumDate);
//    
//    NSDate *targetDate = [self.gregorian startOfDayForDate:date];
//    NSIndexPath *targetIndexPath = [self.calculator indexPathForDate:targetDate];
//    
//    BOOL shouldSelect = YES;
//    // 跨月份点击
//    if (monthPosition==FSCalendarMonthPositionPrevious||monthPosition==FSCalendarMonthPositionNext) {
//        if (self.allowsMultipleSelection) {
//            if ([self isDateSelected:targetDate]) {
//                BOOL shouldDeselect = ![self.delegateProxy respondsToSelector:@selector(calendar:shouldDeselectDate:atMonthPosition:)] || [self.delegateProxy calendar:self shouldDeselectDate:targetDate atMonthPosition:monthPosition];
//                if (!shouldDeselect) {
//                    return;
//                }
//            } else {
//                shouldSelect &= (![self.delegateProxy respondsToSelector:@selector(calendar:shouldSelectDate:atMonthPosition:)] || [self.delegateProxy calendar:self shouldSelectDate:targetDate atMonthPosition:monthPosition]);
//                if (!shouldSelect) {
//                    return;
//                }
//                [_collectionView selectItemAtIndexPath:targetIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//                [self collectionView:_collectionView didSelectItemAtIndexPath:targetIndexPath];
//            }
//        } else {
//            shouldSelect &= (![self.delegateProxy respondsToSelector:@selector(calendar:shouldSelectDate:atMonthPosition:)] || [self.delegateProxy calendar:self shouldSelectDate:targetDate atMonthPosition:monthPosition]);
//            if (shouldSelect) {
//                if ([self isDateSelected:targetDate]) {
//                    [self.delegateProxy calendar:self didSelectDate:targetDate atMonthPosition:monthPosition];
//                } else {
//                    NSDate *selectedDate = self.selectedDate;
//                    if (selectedDate) {
//                        [self deselectDate:selectedDate];
//                    }
//                    [_collectionView selectItemAtIndexPath:targetIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//                    [self collectionView:_collectionView didSelectItemAtIndexPath:targetIndexPath];
//                }
//            } else {
//                return;
//            }
//        }
//        
//    } else if (![self isDateSelected:targetDate]){
//        if (self.selectedDate && !self.allowsMultipleSelection) {
//            [self deselectDate:self.selectedDate];
//        }
//        [_collectionView selectItemAtIndexPath:targetIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//        FSCalendarCell *cell = (FSCalendarCell *)[_collectionView cellForItemAtIndexPath:targetIndexPath];
//        [cell performSelecting];
//        [self enqueueSelectedDate:targetDate];
//        [self selectCounterpartDate:targetDate];
//        
//    } else if (![_collectionView.indexPathsForSelectedItems containsObject:targetIndexPath]) {
//        [_collectionView selectItemAtIndexPath:targetIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//    }
//    
//    if (scrollToDate) {
//        if (!shouldSelect) {
//            return;
//        }
//        [self scrollToPageForDate:targetDate animated:YES];
//    }
//}
//
////- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
////    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
////    // Do other updates here
////    [self.view layoutIfNeeded];
////}
//
//- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
//    calendar.frame = (CGRect){200,200};
//    // Do other updates here
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDate *selectedDate = [self.calculator dateForIndexPath:indexPath];
//    FSCalendarMonthPosition monthPosition = [self.calculator monthPositionForIndexPath:indexPath];
//    FSCalendarCell *cell;
//    if (monthPosition == FSCalendarMonthPositionCurrent) {
//        cell = (FSCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    } else {
////        cell = [self cellForDate:selectedDate atMonthPosition:FSCalendarMonthPositionCurrent];
////        NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
//        if (indexPath) {
//            [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//        }
//    }
//    
////    self.displaySelectedAcitivity = [[UILabel alloc]init];
//    self.displaySelectedAcitivity.text = @"hello";
//
//}
//
//
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
////- (void)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
////
////    //BOOL sameDay = [self.gregorian isDate:selectedDate inSameDayAsDate:date2];
////
//////    if (![_selectedDates containsObject:selectedDate]) {
//////        cell.selected = YES;
//////        [cell performSelecting];
//////    }
//////    [self enqueueSelectedDate:selectedDate];
//////    [self.delegateProxy calendar:self didSelectDate:selectedDate atMonthPosition:monthPosition];
//////    [self selectCounterpartDate:selectedDate];
////
////}
//
//-(void)checkDate {
////    PFQuery *query = [PFQuery queryWithClassName:@"User_Preferences"];
////    [query whereKey:columnName equalTo: "previousActivities"];
////
////    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects,
////                                              NSError * _Nullable error) {
////        if (objects) {
////
////        } else {
////            NSLog(@"%@", error); // will change to an alert later
////        }
////    }];
////}
//
////- (nullable FSCalendarCell *)cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
////    NSIndexPath *indexPath = [self.calculator indexPathForDate:date atMonthPosition:position];
////    return (FSCalendarCell *)[self.collectionView cellForItemAtIndexPath:indexPath];}
////
//}

@end
