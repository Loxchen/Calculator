//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Chen Lox on 5/2/13.
//  Copyright (c) 2013 me.loxchen. All rights reserved.
//

#import "CalculatorBrain.h"
#include <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *oprerandStack;
@end

@implementation CalculatorBrain

@synthesize oprerandStack = _oprerandStack;

- (NSMutableArray *) oprerandStack
{
    if (_oprerandStack == nil) _oprerandStack = [[NSMutableArray alloc] init];
    return _oprerandStack;
}

- (void)pushOperand:(double)operand
{
    [self.oprerandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.oprerandStack lastObject];
    if (operandObject) [self.oprerandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)clearOperand
{
    [self.oprerandStack removeAllObjects];
}

- (double)performOperation:(NSString*)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        double new = [self popOperand];
        result = [self popOperand] - new;
    } else if ([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]){
        double new = [self popOperand];
        result = [self popOperand] / new;
    } else if ([operation isEqualToString:@"sin"]){
        double radian = [self popOperand];
        result = sin(radian / 180 * M_PI);
    } else if ([operation isEqualToString:@"cos"]){
        double radian = [self popOperand];
        result = cos(radian / 180 * M_PI);
    } else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"π"]){
        result = M_PI;
    }
    
    [self pushOperand:result];
    
    return result;
}


@end
