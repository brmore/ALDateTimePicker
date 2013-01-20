
// ALDateTimePicker.m

// Copyright (c) 2013 Brad More

// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ALDateTimePicker.h"

@interface ALDateTimePicker()
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) BOOL isAnimated;
@end

@implementation ALDateTimePicker 

@synthesize delegate;
@synthesize datePickerMode;
@synthesize minuteInterval;

#pragma mark Initializers

-(id)initForDate:(NSDate *)date {
    self =  [self initForDate:date andPickerMode:UIDatePickerModeDateAndTime];
    return self;
}

-(id)initForDate:(NSDate *)date andPickerMode:(UIDatePickerMode)mode {
    self  = [super init];
    if (self) {
        
        // setup the date picker
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
        [self.datePicker setDatePickerMode:mode];
        [self.datePicker setDate:(date) ? date : [NSDate new]];
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        // create and setup the toolbar
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        NSArray *toolBarItems = [[NSArray alloc]initWithObjects:cancelButton, space, doneButton, nil];
        [toolBar setItems:toolBarItems];
        
        // create the UIView
        UIView *view = [[UIView alloc]init];
        [view setBackgroundColor:[UIColor clearColor]];
        
        // add the date picker
        [view addSubview:self.datePicker];
        [view addSubview:toolBar];
        
        // create the popover content controller
        UIViewController *popoverContent = [[UIViewController alloc] init];
        popoverContent.view = view;
        
        // create the popover controller
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        [self.popoverController setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    }
    
    return self;
}

#pragma mark Getters and setters

-(NSInteger)minuteInterval {
    return self.datePicker.minuteInterval;
}

-(void)setMinuteInterval:(NSInteger)interval {
    [self.datePicker setMinuteInterval:interval];
}

-(UIDatePickerMode) datePickerMode {
    return self.datePicker.datePickerMode;
}

-(void) setDatePickerMode:(UIDatePickerMode)mode {
    [self.datePicker setDatePickerMode:mode];
}

#pragma mark Toolbar button actions 

-(void)cancel:(id)sender{
    [self.popoverController dismissPopoverAnimated:self.isAnimated];
    if ((delegate) && [delegate respondsToSelector:@selector(cancelled)]) {
        [delegate cancelled];
    }
}

-(void)done:(id)sender{
    [self.popoverController dismissPopoverAnimated:self.isAnimated];
    if ((delegate) && [delegate respondsToSelector:@selector(dateTimeSelected:  )]){
        [delegate dateTimeSelected:self.datePicker.date];
    }
}

#pragma mark UIDatePicker action

-(void)dateChanged:(id)sender {
    if ((delegate) && [delegate respondsToSelector:@selector(dateTimeChanged:)]){
        [delegate dateTimeChanged:self.datePicker.date];
    }
}

#pragma mark Present methods

-(void)presentFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    self.isAnimated = animated;
    [self.popoverController presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

-(void)presentFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    self.isAnimated = animated;
    [self.popoverController presentPopoverFromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
}

@end
