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
    
    BOOL isToday = [self.gregorian isDateInToday:date];
    BOOL isYesterday = [self.gregorian isDateInYesterday:date];
    BOOL isTomorrow = [self.gregorian isDateInTomorrow:date];
    BOOL isWeekend = [self.gregorian isDateInWeekend:date];
    
}

@end
