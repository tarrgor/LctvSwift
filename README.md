# LctvSwift

[![CI Status](http://img.shields.io/travis/tarrgor/LctvSwift.svg?style=flat)](https://travis-ci.org/tarrgor/LctvSwift)
[![CocoaPods](https://img.shields.io/cocoapods/v/LctvSwift.svg)](http://cocoapods.org/pods/LctvSwift)
[![CocoaPods](https://img.shields.io/cocoapods/l/LctvSwift.svg)](http://cocoapods.org/pods/LctvSwift)
[![CocoaPods](https://img.shields.io/cocoapods/p/LctvSwift.svg)](http://cocoapods.org/pods/LctvSwift)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/LctvSwift.svg)](http://cocoapods.org/pods/LctvSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Still under development

Please note: This library is still under development. There will be bugs or missing
features and also thigs may change in future versions. Be aware of that before
using it.

## Requirements

### Registration of your app

To use LctvSwift you need to register an app on Livecoding. Visit the Livecoding
homepage to get information on how to do so.

When registering choose the following configuration for your app:

`Client Type:` public

`Authorization Grant Type:` authorization-code

`Redirect Uris:` http://localhost:8080/oauth-callback

### Settings in your XCode project

Within your Info.plist file add the following setting:

`AppTransportSecuritySettings`

 This is a Dictionary-Type entry. Add the following sub-entry to it:

 `Allow Arbitrary Loads = YES`

This disables forced https-only connectivity. Within the authorization process
the library starts an internal http-server, that's what this setting is necessary
for. May not be necessary in future versions, if the local server supports https.

### Other requirements

- Make sure that port 8080 is not used by another application/server. LctvSwift is
using this port for its internal server during authorization.

## Installation

LctvSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LctvSwift'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example
directory first. Then edit the Secret.swift file and insert your Livecoding API
clientId and secret.

**Make sure you don't store your clientId and secret in a real world app, as it is done in this Example application!**

## Usage

### Initialize the API

Initialization of LctvSwift is recommended within your apps `AppDelegate` class.
So within that class declare a new variable:

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var api: LctvApi?
  var initialViewController: UIViewController!
```

For initialization of the api you can write a function similar to this one:

```swift
  func initApi() {
    do {
      var config = LctvConfig(clientId: clientId, clientSecret: clientSecret)
      try api = LctvApi(config: config)
    } catch {
      print("Could not initialize. Aborting.")
      abort()
    }
  }
```

The `init(config: LctvConfig)` function is the way to get an instance of `LctvApi`,
which is necessary to communicate with Livecoding. The function takes a `LctvConfig`
instance as its parameter, which contains some basic information on how you want
to setup the api.

In a real world app, you should do some more appropriate error handling as in this
example.

When the API is initialized for the first time, you currently have to specify your
clientId and secret within the `LctvConfig` instance. It is in your responsibility
to do that in a secure way to prevent abuse of this information. After the first
initialization, LctvSwift will store it securely into the device's keychain and
therefore it does not have to be provided anymore.

The `LctvConfig` class has two more properties:

`overwrite`:

If set to `true`, this initialization will overwrite any existing client information in
the device's keychain. In this case you have to provide clientId and secret
again in the config. Defaults to `false` and should only be set to `true` for
debugging purposes.

`grantType`:

The grant type can be either `AuthorizationCode` or `Implicit`. Livecoding
recommends using `Implicit` for mobile devices, but currently LctvSwift only
supports `AuthorizationCode` due to some dependencies. `Implicit` grant type
may be supported in a future version of LctvSwift.

Call the `initApi` function from within `application:didFinishLaunchingWithOptions:`:

```swift
  func application(application: UIApplication,
       didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    initApi()
  }
```

Depending on your needs it might make sense to build in a switch within the
`AppDelegate` to decide to present a LoginViewController if the user has not
authorized your app yet or to directly present your main app view controller.

The LoginViewController is different from other Login Screens in that it does not
provide Username and Password fields. Instead it should only provide a Button
e.g. "Login to Livecoding" which then starts the LctvSwift authorization process.

This process will then present a WebViewController with the login and authorization
form provided by Livecoding.TV.

To achieve this switch, you can do that within the `AppDelegate` within the
`application:didFinishLaunchingWithOptions:` method directly below the
`initApi` call:

```swift
// Setup the application window
self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

let storyboard = UIStoryboard(name: "Main", bundle: nil)
self.initialViewController = storyboard.instantiateInitialViewController()

if !self.api!.hasAccessToken() {
  let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
  self.window?.rootViewController = loginViewController
} else {
  self.window?.rootViewController = self.initialViewController
}

self.window?.makeKeyAndVisible()
```

You'll have to add the LoginViewController to the storyboard and assign it a
storyboardId of `LoginViewController`.

You can use the api's `hasAccessToken` method to check, if an access token is
already in place.

Now when starting the app, it will automatically present the "Login" screen when
the user did not authorize yet. Otherwise it will directly switch to the app's
main view controller (which is the initial view controller defined within the
storyboard).

### Extending UIViewController

In the previous section you instantiated LctvSwift by creating a `LctvApi` instance
within the `AppDelegate`. To make this instance available to all of your view
controllers it makes sense to create a small extension of `UIViewController`:

```swift
import UIKit
import LctvSwift

extension UIViewController {

  var lctvApi: LctvApi? {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).api
  }

}
```

### Authorization

After the first api initialization, your app needs to receive an access token from
the server to be able to access Livecoding resources. This token will be stored
together with your secret information in the device's keychain.

When using a grant type of `AuthorizationCode`, usually this authorization process
only has to be processed once. After the initial authorization you can get a new
access token when the old one expires via the refresh token, which is also provided.
The grant type `Implicit` does not support refresh tokens so there may be the need
of re-authorization at some point. However, with `Implicit` you don't need to store
your client secret on the device, so it may be more secure.

Within your `LoginViewController` provide the following function to process the
authorization with LctvSwift:

```swift
func authorizeClient() {
  let viewController = LctvAuthViewController()
  viewController.view.frame = self.view.bounds

  api.oAuthUrlHandler = viewController

  do {
    try api.authorize(scope: "read chat")
  } catch {
    print("Could not authorize: \(error)")
  }
}
```

As you can see, a new ViewController gets initialized within this function. It is
provided by LctvSwift and it contains a UIWebView to provide a possibility for the
user to login to Livecoding and grant your app the needed permissions.

This viewController is passed to the api via the `oAuthUrlHandler` property.

With the `authorize` function you can specify a `scope` which defines the permissions
your app will need. The default is "read", which is a limited read permission. Please
read Livecoding API documentation for other permissions. The permissions within
`scope` are separated by spaces.

Now create a Login-Button in your storyboard within the `LoginViewController`. Add
an action method for this button to the view controller class which calls the
`authorizeClient` method:

```swift
@IBAction func loginButtonPressed(sender: UIButton) {
  authorizeClient()
}
```

When you start your app now, as soon as you press the Login-Button in your  
`LoginViewController`, a browser window should appear and you will be asked to login
to Livecoding. After successfully logging in, Livecoding will ask you if you want
to grant the listed permissions to your app. Press "authorize" and the browser
window disappears.

If everything went well, your `LctvApi` instance is configured and authorized to
call Livecoding API functions.

Now it would be nice if the `LoginViewController` disappears when the user did
successfully authorize your app. Unfortunately you can't to this directly after
the call to `authorize` because it is an asynchronous processing.

To handle this, `LctvApi` offers two properties:

```swift
/// Handler which is called after successfully processing the authorization screen
public var onAuthorizationSuccess: AuthSuccessHandler? = nil

/// Handler for errors during the authorization process
public var onAuthorizationFailure: AuthFailureHandler? = nil
```

You can specify two functions here which get called when either the authorization
has been successful or failed e.g. in `viewDidLoad`:

```swift
override func viewDidLoad() {
  self.lctvApi!.onAuthorizationSuccess = authorizationSuccessful
  self.lctvApi!.onAuthorizationFailure = authorizationFailure
}
```

Now create those two functions:

```swift
func authorizationSuccessful() {
  // Present the initial view controller
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  let viewController = appDelegate.initialViewController
  self.presentViewController(viewController, animated: true, completion: nil)
}

func authorizationFailure(message: String) {
  // Do some appropriate error handling here
  print(message)
}
```

### Calling API functions

Here are some examples how to use the `LctvApi` instance to access Livecoding API.
Every API call has the following structure:

```swift
api.getCurrentUser(success: { user in
    // Do something with the user
    print(user.userName)
    print(user.yearsProgramming)
}, failure: { message, json in
    // Error handling
})
```

As you can see, each function gets a closure for `success` and `failure`. This
is necessary to deal with the asynchronous nature of HTTP-calls.

From the example `getCurrentUser` function you'll receive a `LctvUser` instance
within the `success` closure.

There are some api functions which return big collections of data in form of a
"pageable" structure. LctvSwift handles those results with the `LctvResultContainer`
class:

```swift
api.getCodingCategories(success: {
    result in
    self.codingCategories = result
    print(result.results)
}, failure: { message, json in
    self.showAlertWithTitle("ERROR", message: message)
})
```

The `result` parameter which gets passed into `success` is of type
`LctvResultContainer<LctvCodingCategory>`. It's `results` property contains an
array with a number of `LctvCodingCategory` instances. The number of results for
a page can be configured by setting the api's `pageSize` property:

```swift
api.pageSize = 20
```

There are also two properties `next` and `previous` available in a result container
which contain the url's to call the next or previous page. LctvSwift has convenience
functions to achieve this:

```swift
api.nextPage(self.codingCategories!, success: { result in
    self.codingCategories = result
}, failure: { message, json in
    self.showAlertWithTitle("ERROR", message: "Could not retrieve next page: \(message)")
})

api.previousPage(self.codingCategories!, success: { result in
    self.codingCategories = result
}, failure: { message, json in
    self.showAlertWithTitle("ERROR", message: "Could not retrieve previous page: \(message)")
})
```

Some API functions just return simple arrays with results. This is handled by
LctvSwift's `LctvArrayContainer` class:

```swift
api.getCurrentUserFollowers(success: {
    result in
    print(result.array)
}, failure: { message, json in
    self.showAlertWithTitle("ERROR", message: message)
})
```

In the example above, the `result` passed into the `success` closure is of type
`LctvArrayContainer<LctvUser>`. It has a property `array` which contains all
received `LctvUser`-instances.


## Author

Thorsten Klusemann, tklusemann.dev(AT)gmail.com

## License

LctvSwift is available under the MIT license. See the LICENSE file for more info.
