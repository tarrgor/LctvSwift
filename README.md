# LctvSwift

[![CI Status](http://img.shields.io/travis/tarrgor/LctvSwift.svg?style=flat)](https://travis-ci.org/tarrgor/LctvSwift)
[![Version](https://img.shields.io/badge/pod-0.6.2-blue.svg)](http://cocoapods.org/pods/LctvSwift)
[![License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://cocoapods.org/pods/LctvSwift)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](http://cocoapods.org/pods/LctvSwift)


## Still under development

Please note: This library is still under development. There will be bugs or missing
features and also thigs may change in future versions. Be aware of that before
using it.

## Requirements

To use LctvSwift you need to register an app on Livecoding. Visit the Livecoding
homepage to get information on how to do so.

When registering choose the following configuration for your app:

`Client Type:` public

`Authorization Grant Type:` authorization-code

`Redirect Uris:` http://localhost:8080/oauth-callback
 

## Installation

LctvSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LctvSwift"
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example 
directory first. Then edit the Secret.swift file and insert your Livecoding API
clientId and secret.

**Make sure you don't store your clientId and secret in a real world app, as it is done in this Example application!**

## Usage

### Initialize the API

Let's assume you have a UIViewController and you want to initialize Livecoding API.
To do this, create a new variable within the ViewController:

```swift
import LctvSwift

var api: LctvApi!
```

For initialization of the api you can write a function similar to this one:

```swift
  func initApi() {
    do {
      var config = LctvConfig()
      config.clientId = "clientId"
      config.clientSecret = "secret"
      try api = LctvApi.initializeWithConfig(config)
    } catch {
      print("Could not initialize. Aborting.")
      abort()
    }
  }
```

The static `initializeWithConfig` function is the way to get an instance of `LctvApi`,
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
will be supported in a future version of LctvSwift. 

Call the `initApi` function from within `viewDidLoad`:

```swift
  override func viewDidLoad() {
    super.viewDidLoad()

    initApi()
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

Provide the following function to process the authorization with LctvSwift:

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

Within `viewDidAppear` you now have to check if LctvSwift already has received an
access token or not. If not, call our `authorizeClient` function:

```swift
  override func viewDidAppear(animated: Bool) {
    if !api.hasAccessToken() {
      authorizeClient()
    }
  }
```

You can use the api's `hasAccessToken` method to check, if an access token is
already in place.

When you start your app now, as soon as your ViewController is appearing, a browser
window should appear and you will be asked to login to Livecoding. After successfully
logging in, Livecoding will ask you if you want to grant the listed permissions to 
your app. Press "authorize" and the browser window disappears.

Now if everything went well, your `LctvApi` instance is configured and authorized to 
call Livecoding API functions.

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
