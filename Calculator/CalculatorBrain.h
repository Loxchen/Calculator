//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Chen Lox on 5/2/13.
//  Copyright (c) 2013 me.loxchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString*)operation;
- (void)clearOperand;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
