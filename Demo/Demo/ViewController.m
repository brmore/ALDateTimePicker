//
//  ViewController.m
//  Demo
//
//  Created by Brad More on 1/20/13.
//  Copyright (c) 2013 Brad More. All rights reserved.
//

#import "ViewController.h"
#import "ALDateTimePicker.h"

@interface ViewController () <ALDateTimePickerDelegate>
@property (nonatomic, strong) ALDateTimePicker *picker;
@end

@implementation ViewController {
    NSDateFormatter *formatter;
}

@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    formatter = [[NSDateFormatter alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    picker = [[ALDateTimePicker alloc]initForDate:[NSDate new]];
    picker.datePickerMode = UIDatePickerModeDate;
    [picker setMinuteInterval:10];
    [picker setDelegate:self];
    [picker presentFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
}

- (void)log:(NSString *)prefix andDate:(NSDate *)date {

    switch (picker.datePickerMode) {
        case UIDatePickerModeDate : {
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            break;
        };
        case UIDatePickerModeTime : {
            [formatter setDateStyle:NSDateFormatterNoStyle];
            [formatter setTimeStyle:NSDateFormatterLongStyle];
            break;
        };
        case UIDatePickerModeDateAndTime :
        case UIDatePickerModeCountDownTimer : {
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterLongStyle];
            break;
        }
    }
    
    NSLog(@"%@: %@", prefix, [formatter stringFromDate:date]);
}

#pragma mark ALDateTimePickerDelegate

-(void)dateTimeChanged:(NSDate *)date {
    [self log:@"changed" andDate:date];
}

-(void)dateTimeSelected:(NSDate *)date {
    [self log:@"selected" andDate:date];
}

-(void)cancelled {
    NSLog(@"cancelled");
}

@end
