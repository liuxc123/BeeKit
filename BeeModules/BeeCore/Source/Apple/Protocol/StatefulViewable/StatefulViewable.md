#  StatefulViewable

页面的状态机制

![StatefulViewable](https://github.com/aschuch/StatefulViewController/raw/master/Resources/decision_tree.png)

一般页面网络请求有四种状态

- loading
- content
- empty
- error

### 使用方法

1. 遵守协议 `StatefulViewable`

```
class ViewController: UIViewController, StatefulViewable {}
```

2. 设置各种状态的页面

```
override func viewDidLoad() {
    super.viewDidLoad()

    // Setup placeholder views
    loadingView = // UIView
    emptyView = // UIView
    errorView = // UIView
}
```

3. 设置页面初始状态

```
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    setupInitialViewState()
}
```

4. 之后，只要在内容加载时告诉视图控制器，StatefulViewable将负责显示和隐藏正确的加载、错误和空视图。

```
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    loadDeliciousWines()
}

func loadDeliciousWines() {
    startLoading()

    let url = NSURL(string: "http://example.com/api")
    let session = NSURLSession.sharedSession()
    session.dataTaskWithURL(url) { (let data, let response, let error) in
        endLoading(error: error)
    }.resume()
}
```

### 生命周期

StatefulViewable调用`hasContent`方法来检查是否有要显示的内容。如果您没有在自己的类中重写此方法，StatefulViewable将默认是true。

```
func hasContent() -> Bool {
    return datasourceArray.count > 0
}
```

另外，即使内容已经显示，您也可能对响应错误感兴趣。在这种情况下，StatefulViewable不会显示它的errorView，因为已经有可以显示的内容。

例如，要显示自定义警告或其他不显眼的错误消息，请使用`handleErrorWhenContentAvailable:`手动向用户显示错误。

```
func handleErrorWhenContentAvailable(error: ErrorType) {
    let alertController = UIAlertController(title: "Ooops", message: "Something went wrong.", preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    presentViewController(alertController, animated: true, completion: nil)
}
```

#### 自定义内边距

```
class MyPlaceholderView: UIView, StatefulPlaceholderView {
    func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
```

#### 页面状态机

您还可以使用底层视图状态机为显示/隐藏视图的自定义流创建类似的实现。

```
let stateMachine = ViewStateMachine(view: view)

// Add states
stateMachine["loading"] = loadingView
stateMachine["other"] = otherView

// Transition to state
stateMachine.transitionToState(.View("loading"), animated: true) {
    println("finished switching to loading view")
}

// Hide all views
stateMachine.transitionToState(.None, animated: true) {
    println("all views hidden now")
}
```
