//
//  PDFView.h
//  PDF
//
//  Created by 李伟超 on 14-11-4.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView {
    CGPDFDocumentRef pdf;
}

-(void)drawInContext:(CGContextRef)context;

@end
