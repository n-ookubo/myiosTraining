//
//  AssetViewController.h
//  AssetsLibrarySample
//
//  Created by 大久保直昭 on 2015/07/14.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) ALAssetsGroup *assetGroup;

@end
