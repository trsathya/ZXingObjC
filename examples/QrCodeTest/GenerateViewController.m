/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "GenerateViewController.h"

@implementation GenerateViewController

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.textView.text = @"http://github.com/TheLevelUp/ZXingObjC";
  [self updatePressed:nil];
}

#pragma mark - Events

- (IBAction)updatePressed:(id)sender {
  [self.textView resignFirstResponder];

  NSString *data = self.textView.text;
  if (data == 0) return;

  ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXPDF417Dimensions *dim = [[ZXPDF417Dimensions alloc] initWithMinCols:3 maxCols:3 minRows:6 maxRows:6];
    ZXEncodeHints *hints = [ZXEncodeHints hints];
    hints.pdf417Dimensions = dim;
    hints.pdf417Compact = YES;
    UIScreen *screen = [UIScreen mainScreen];
  ZXBitMatrix *result = [writer encode:data
                                format:kBarcodeFormatQRCode
                                 width:self.imageView.frame.size.width * screen.scale
                                height:self.imageView.frame.size.height * screen.scale
                                 hints:hints
                                 error:nil];

  if (result) {
    ZXImage *image = [ZXImage imageWithMatrix:result];
    self.imageView.image = [UIImage imageWithCGImage:image.cgimage scale:screen.scale orientation:UIImageOrientationUp];
  } else {
    self.imageView.image = nil;
  }
}

@end
