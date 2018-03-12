//
//  CustomAnnotationView.m
//  customAnnotation
//
//  Created by Z on 2017/11/22.
//  Copyright © 2017年 Z. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomAnnotation.h"

static CGFloat kMaxViewWidth = 150.0;

static CGFloat kViewWidth = 90;
static CGFloat kViewLength = 100;

static CGFloat kLeftMargin = 15.0;
static CGFloat kRightMargin = 5.0;
static CGFloat kTopMargin = -10.0;

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
                    icon:(NSString *)icon
                   label:(NSString *)label{
    __weak typeof(self) weakSelf = self;
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        CustomAnnotation *mapItem = (CustomAnnotation *)self.annotation;
        weakSelf.backgroundColor = [UIColor clearColor];
        UILabel *annotationLabel = [self makeiOSLabel:mapItem.annotModel.title];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *annotationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tupian"]];
            annotationImage.userInteractionEnabled = YES;
            annotationImage.contentMode = UIViewContentModeScaleAspectFit;
            annotationImage.frame = CGRectMake(0,0,weakSelf.frame.size.width,weakSelf.frame.size.height);
            [self addSubview:annotationImage];

            UIImageView * tupianImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, weakSelf.frame.size.width-10, 50)];
            tupianImage.contentMode = UIViewContentModeScaleAspectFit;
            tupianImage.layer.masksToBounds = YES;
            tupianImage.userInteractionEnabled = YES;
            [tupianImage sd_setImageWithURL:[NSURL URLWithString:mapItem.annotModel.thumbimg]];
            [self insertSubview:tupianImage aboveSubview:annotationImage];
            [self addSubview:annotationLabel];
        });
    }
    return self;
}


- (UILabel *)makeiOSLabel:(NSString *)placeLabel
{
    __weak typeof(self) weakSelf = self;
    UILabel *annotationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    annotationLabel.font = [UIFont systemFontOfSize:10];
    annotationLabel.textColor = [UIColor darkTextColor];
    annotationLabel.text = [placeLabel capitalizedString];
    annotationLabel.layer.cornerRadius = 3;
    annotationLabel.layer.masksToBounds = YES;
    [annotationLabel sizeToFit];
    CGFloat optimumWidth = annotationLabel.frame.size.width + kRightMargin + kLeftMargin;
    CGRect frame = self.frame;
    if (optimumWidth < kViewWidth)
        frame.size = CGSizeMake(kViewWidth, kViewLength);
    else if (optimumWidth > kMaxViewWidth)
        frame.size = CGSizeMake(kMaxViewWidth, kViewLength);
    else
        frame.size = CGSizeMake(optimumWidth, kViewLength);
    self.frame = frame;
    
    annotationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    annotationLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    annotationLabel.textAlignment = NSTextAlignmentCenter;
    CGRect newFrame = annotationLabel.frame;
    newFrame.origin.x = kLeftMargin;
    newFrame.origin.y = kTopMargin;
    newFrame.size.width = weakSelf.frame.size.width - kRightMargin - kLeftMargin;
    annotationLabel.frame = newFrame;
    
    return annotationLabel;
}

@end
