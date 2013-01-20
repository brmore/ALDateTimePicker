
// ALDateTimePicker.h

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

#import <Foundation/Foundation.h>

@protocol ALDateTimePickerDelegate <NSObject>
@optional

// dateTimeChanged fires when user modifies the date picker value,
// irrepsective of whether or not you select cancel or modify
-(void)dateTimeChanged:(NSDate *)date;

// dateTimeSelected fires when user actually selects (clicks) the
// "Done" button
-(void)dateTimeSelected:(NSDate *)date;

// cancelled fires when the user selects (clicks) the
// "Cancel" button
-(void)cancelled;
@end;

@interface ALDateTimePicker : NSObject

// public properties
@property (nonatomic, weak) id<ALDateTimePickerDelegate> delegate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, assign) NSInteger minuteInterval;

// initializers
-(id)initForDate:(NSDate *)date;
-(id)initForDate:(NSDate *)date andPickerMode:(UIDatePickerMode)mode;

// present methods
-(void)presentFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
-(void)presentFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

@end
