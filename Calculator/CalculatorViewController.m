//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chen Lox on 5/2/13.
//  Copyright (c) 2013 me.loxchen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL dotHadBeenEntered;
@property (nonatomic, strong) CalculatorBrain *brain;

- (NSString *)lastChar:(NSString *)string;
- (NSString *)allBeforeLastChar:(NSString *)string;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize dotHadBeenEntered = _dotHadBeenEntered;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSString *)lastChar:(NSString *)string
{
    return [string substringFromIndex:[string length] - 1];
}

- (NSString *)allBeforeLastChar:(NSString *)string
{
    return [string substringToIndex:[string length] - 1];
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if (![@"." isEqualToString:digit] || ([@"." isEqualToString:digit] && !self.dotHadBeenEntered)){
        
        if([@"." isEqualToString:digit]){
            self.dotHadBeenEntered = YES;
        }
    
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }else{
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.display.text = digit;
        }
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
   
    // 1st to delete the '='
    self.history.text = [self.history.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    // 2nd to append the operator + '='
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ =",sender.currentTitle];
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.dotHadBeenEntered = NO;
    
    if ([self.history.text length] > 0 && [@"=" isEqualToString:[self lastChar:self.history.text]]) {
        self.history.text = [self allBeforeLastChar:self.history.text];
    }
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ ",self.display.text];
}

- (IBAction)backspace {
    int length = [self.display.text length];
    if(length >1){
        self.display.text = [self.display.text substringToIndex:length-1];
    }else if(length == 1){
        self.display.text = @"0";
    }
}

- (IBAction)clear {
    self.display.text = @"0";
    self.history.text = @"";
    [self.brain clearOperand];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.dotHadBeenEntered = NO;
}
@end
