//
//  Mitama's HyperWitching
//
//  By using this tweak, you agree that Mitama is the
//  best girl.
//
//  Your account can be banned. Use at your own risk.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY
//  OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "MHWDriver.h"

#pragma mark - Headers

@class RootViewController;
@interface RootViewController : UIViewController
{
  RootViewController *_rootViewController;
}

@property(readonly, nonatomic) UIView *eaglView;
- (void)viewDidLoad;

@end

@interface CCEAGLView : UIView
@end

#pragma mark - Injection

static UIView *eaglView;

%hook RootViewController

- (void)viewDidLoad
{
  %orig;
  eaglView = self.eaglView;
  [MHWDriver get].rootView = eaglView;
}

- (void)motionEnded:(UIEventSubtype)motion
          withEvent:(UIEvent *)event
{
  %orig;
  if (motion == UIEventSubtypeMotionShake) {
    [MHWDriver speedup];
    NSLog(@"[hyperwitching][speedup] %@", [MHWDriver state]);
  }
}

%end


#pragma mark - Entry Point

void HandleException(NSException *e)
{
  NSLog(@"[hyperwitching][exception] %@",e);
  NSLog(@"[hyperwitching] %@",[e callStackSymbols]);
}

%ctor {
  // Set exception
  NSSetUncaughtExceptionHandler(HandleException);
}