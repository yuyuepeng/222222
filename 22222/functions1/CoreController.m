//
//  CoreController.m
//  22222
//
//  Created by tangsanduo on 2021/9/28.
//  Copyright © 2021 玉岳鹏. All rights reserved.
//

#import "CoreController.h"

@implementation YYPCoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前绘制上下文
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形的变换矩阵为不做图形变换
    CGContextTranslateCTM(context, 0, self.bounds.size.height);//平移方法，将画布向上平移一个屏幕高
    CGContextScaleCTM(context, 1.0, -1.0);//缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度正如之上的背景说的，coreText使用的是系统坐标，然而我们平时所接触的iOS的都是屏幕坐标，所以要将屏幕坐标系转换系统坐标系，这样才能与我们想想的坐标互相对应。事实上呢，这三句是翻转画布的固定写法，这三句你以后会经常看到的。

    /*
      事实上，图文混排就是在要插入图片的位置插入一个富文本类型的占位符。通过CTRUNDelegate设置图片
    */
    
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本,这里在测试图文混排，我是一个富文本"];
    /*
     设置一个回调结构体，告诉代理该回调那些方法
     */
    CTRunDelegateCallbacks callBacks;//创建一个回调结构体，设置相关参数
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));//memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    callBacks.version = kCTRunDelegateVersion1;//设置回调版本，默认这个
    callBacks.getAscent = ascentCallBacks;//设置图片顶部距离基线的距离
    callBacks.getDescent = descentCallBacks;//设置图片底部距离基线的距离
    callBacks.getWidth = widthCallBacks;//设置图片宽度
    UIImage * image = [UIImage imageNamed:@"bd_logo1"];

    /*
     创建一个代理
    */
    NSDictionary * dicPic = @{@"height":@(image.size.height/4),@"width":@(image.size.width/4)};//创建一个图片尺寸的字典，初始化代理对象需要
    CTRunDelegateRef delegate = CTRunDelegateCreate(& callBacks, (__bridge void *)dicPic);//创建代理
//    上面只是设置了回调结构体，然而我们还没有告诉这个代理我们要的图片尺寸。
//    所以这句话就在设置代理的时候绑定了一个返回图片尺寸的字典。
//    事实上此处你可以绑定任意对象。此处你绑定的对象既是回调方法中的参数ref。
//
//    好吧就然说到这我就直接把那三个回调方法说了吧，放在一起比较好理解一些。（就是下面三个方法）

//    上文说过，ref既是创建代理是绑定的对象。所以我们在这里，从字典中分别取出图片的宽和高。
//
//    值得注意的是，由于是c的方法，所以也没有什么对象的概念。是一个指针类型的数据。不过oc的对象其实也就是c的结构体。我们可以通过类型转换获得oc中的字典。
//    __bridge既是C的结构体转换成OC对象时需要的一个修饰词。
  
    
    unichar placeHolder = 0xFFFC; //创建空白字符
    
    
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1]; //已空白字符生成字符串
    NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];//用字符串初始化占位符的富文本
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);//给字符串中的范围中字符串设置代理
    
//    这里富文本的知识上文中已经介绍过了。不过老司机猜你有三个疑问。
//
//    这个添加属性的方法怎么是这个样子的？
//    因为这里是添加CTRunDelegate这种数据类型，要用CoreText专门的方法，不过其实就是形式不同，作用一样的。
//    为什么这里富文本类型转换的时候不用_bridge呢？老司机你不是说需要修饰词么？你是不是骗我？(markDown语法冲突我少打一个下划线)
//    真没有，事实上不是所有数据转换的时候都需要__bridge。你要问我怎么区分？那好我告诉你，C中就是传递指针的数据就不用。比如说字符串，数组。原因老司机现在解释不通，等我能组织好语言的。
//    为什么还要释放？我是ARC环境啊
//    不好意思，我也是。不过为什么要释放呢？因为你进行了类型转换之后就不属于对象了，也不再归自动引用计数机制管理了，所以你得手动管理咯。

   
    
    CFRelease(delegate);
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:50];//将占位符插入原富文本(图片插入文本的位置)
    
//    此处我就不赘述了，富文本的知识你只要类比字典就好了。
//    至此，我们已经生成好了我们要的带有图片信息的富文本了，接下来我们只要在画布上绘制出来这个富文本就好了。
    
//
//    绘制
//
//    绘制呢，又分成两部分，绘制文本和绘制图片。你问我为什么还分成两个？
//
//    因为富文本中你添加的图片只是一个带有图片尺寸的空白占位符啊，你绘制的时候他只会绘制出相应尺寸的空白占位符，所以什么也显示不了啊。
//    那怎么显示图片啊？拿到占位符的坐标，在占位符的地方绘制相应大小的图片就好了。恩，说到这，图文混排的原理已经说完了。
//
//    先来绘制文本吧。

// 文本
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);//一个frame的工厂，负责生成frame
    CGMutablePathRef path = CGPathCreateMutable();//创建绘制区域
    CGPathAddRect(path, NULL, self.bounds);//添加绘制尺寸
    NSInteger length = attributeStr.length;
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);//工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
    CTFrameDraw(frame, context);//根据frame绘制文字
    
//    frameSetter是根据富文本生成的一个frame生成的工厂，你可以通过framesetter以及你想要绘制的富文本的范围获取该CTRun的frame。
//    但是你需要注意的是，获取的frame是仅绘制你所需要的那部分富文本的frame。即当前情况下，你绘制范围定为（10，1），那么你得到的尺寸是只绘制（10，1）的尺寸，他应该从屏幕左上角开始（因为你改变了坐标系），而不是当你绘制全部富文本时他该在的位置。
//
//    然后建立一会绘制的尺寸，实际上就是在指定你的绘制范围。
//    接着生成整个富文本绘制所需要的frame。因为范围是全部文本，所以获取的frame即为全部文本的frame(此处老司机希望你一定要搞清楚全部与指定范围获取的frame他们都是从左上角开始的，否则你会进入一个奇怪的误区，稍后会提到的)。
//    最后，根据你获得的frame，绘制全部富文本。

//    转自：https://www.jianshu.com/p/6db3289fb05d
    
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    
    CGContextDrawImage(context,imgFrm, image.CGImage);//绘制图片
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}
static CGFloat ascentCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}
static CGFloat descentCallBacks(void * ref)
{
    return 0;
}
static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}




-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);//根据frame获取需要绘制的线的数组
    NSInteger count = [arrLines count];//获取线的数量
    CGPoint points[count];//建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);//获取起点
    for (int i = 0; i < count; i ++) {//遍历线的数组
            CTLineRef line = (__bridge CTLineRef)arrLines[i];
            NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);//获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
            for (int j = 0; j < arrGlyphRun.count; j ++) {//遍历CTRun数组
                CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];//获取CTRun
                NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);//获取CTRun的属性
                CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];//获取代理
                if (delegate == nil) {//非空
                    continue;//终止本次循环，直接走下一次循环
                }
                NSDictionary * dic = CTRunDelegateGetRefCon(delegate);//判断代理字典
                if (![dic isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                CGPoint point = points[i];//获取一个起点
                CGFloat ascent;//获取上距
                CGFloat descent;//获取下距
                CGRect boundsRun;//创建一个frame
                boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                boundsRun.size.height = ascent + descent;//取得高
                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);//获取x偏移量
                boundsRun.origin.x = point.x + xOffset;//point是行起点位置，加上每个字的偏移量得到每个字的x
                boundsRun.origin.y = point.y - descent;//计算原点
                CGPathRef path = CTFrameGetPath(frame);//获取绘制区域
                CGRect colRect = CGPathGetBoundingBox(path);//获取剪裁区域边框
                CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
                return imageBounds;
        }
    }
    return CGRectZero;
}

@end



@interface CoreController ()

@property(nonatomic, strong) YYPCoreView *coreView;

@end

@implementation CoreController

- (YYPCoreView *)coreView {
    if (_coreView == nil) {
        _coreView = [[YYPCoreView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar)];
        _coreView.backgroundColor = [UIColor whiteColor];
    }
    return _coreView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coreView];
    [self.coreView.layer setNeedsDisplay];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
