# JumpingJacker
Jumping jack detector for ⌚️ (watchOS)

## Requirements
- watchOS 3.0+
- Xcode 8.0+

## Installation

JumpingJacker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JumpingJacker"
```

## Example usage

```swift
import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

var jumpingJacker: JumpingJacker = JumpingJacker(movementSensitivity: .normal)
var jumpingJackCount: Int = 0

@IBOutlet var jumpingJackCountLabel: WKInterfaceLabel!

override func awake(withContext context: Any?) {
super.awake(withContext: context)

jumpingJacker.delegate = self
jumpingJacker.start()
}
}

extension InterfaceController: JumpingJackerDelegate {
func jumpingJackerDidJumpingJack(_ jumpingJacker: JumpingJacker) {
jumpingJackCount += 1
DispatchQueue.main.async {
self.jumpingJackCountLabel.setText(String(describing: self.jumpingJackCount))
}
}

func jumpingJacker(_ jumpingJacker: JumpingJacker, didFailWith error: Error) {
print(error.localizedDescription)
}
}

```

## Author

Nathan Chan, nchan87@gmail.com

## License

JumpingJacker is available under the MIT license. See the LICENSE file for more info.
