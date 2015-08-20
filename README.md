## MenuScrollView



## Usage

1. drop MenuScrollView folder into your project, and copy if need.
2. improt MenuScrollView.h

### delegate
#### `.h`
```objective-c
@interface ViewController : UIViewController <MenuScrollViewDelegate>

```

#### `.m`
```objective-c
menuScrollView.delegate=self;
```

and add delegate method

```objective-c
- (void) reloadDataByCurrentIndex:(NSInteger)index {
// index will return current page index
}
```

### Indicator
```objective-c
// show indicator, default is YES.
menuScrollView.showIndicator=YES;

// setup indicator bar color, default is darkGary.
menuScrollView.indicatorColor=[UIColor darkGrayColor];

// setup indicator bar background color, default is clear.
menuScrollView.indicatorTinColor=[UIColor clearColor];
```

### Type
Has three Type to use:
- Single    : single item in frame.
- Two       : two items in frame.
- Three     : three items in frame.

### Style
- Horizontal
- Vertical

### Seleted Type
Has three Type to use:
- First     : current index will return left page index. //default is First.
- Middle    : current index will return middle page index only in scroll type is "Three". If scroll type is "Two", current index will return right page index.
- Last      : current index will return right page index. If scroll type is "Single", current index will return left page index.

### init
#### `use StoryBorad with size classes`

```objective-c
- (void) viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];

// if storyboard is using size classes, should setup in viewDidAppear.

// setup with titles
[menuScrollView setStyle:MSVStyleHorizontal type:MSVTypeTwo selectedType:MSVSelectedType_Middle titles:@[@"page index 1",@"page index 2",@"page index 3", @"page index 4"]];

// setup with images
//    [menuScrollView setStyle:MSVStyleHorizontal type:MSVTypeTwo selectedType:MSVSelectedType_Middle images:@[[UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"]]];
}
```

#### `alloc`
```objective-c
menuScrollView=[[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 100) style:MSVStyleHorizontal type:MSVTypeTwo selectedType:MSVSelectedType_Middle titles:@[@"page index 1",@"page index 2",@"page index 3", @"page index 4"]];
or

menuScrollView=[[MenuScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 100) style:MSVStyleHorizontal type:MSVTypeTwo selectedType:MSVSelectedType_Middle images:@[[UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"], [UIImage imageNamed:@"image.png"]]];

```

## License
MIT. Please read [LICENSE](http://opensource.org/licenses/MIT) for more info.
