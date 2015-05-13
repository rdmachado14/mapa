//
//  SecondViewController.h
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/11/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filme.h"

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

- (IBAction)filme1:(id)sender;
- (IBAction)filme2:(id)sender;
- (IBAction)filme3:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

