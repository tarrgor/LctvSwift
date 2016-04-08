## ChangeLog

### 0.8.0

- Updated to new multiplatform project structure

### 0.7.3

- Fixed an issue with some api calls

### 0.7.2

- Added Cancel button to LctvAuthViewController
- Updated for Swift 2.2

### 0.7.1

- Bugfix: Wrong url for onair-Livestreams
- Added getAccessToken() method
- Added Carthage section to README

### 0.7.0

- Scope can now be specified with help of an enum (LctvScope)
- Carthage compatibility
- Keychain identifier is now configurable
- Internal server port is now configurable
- Improved error messages of internal server

### 0.6.5

- Improved testability of the code
- Added event handlers for authorization (success/failure)
- Improved documentation

### 0.6.4

- Added ChangeLog
- Added OHHTTPStubs dependency for testing
- Refactored `LctvApi` for unit testing
- First unit tests
- `LctvApi` now has a standard initializer `init(config: LctvConfig)` instead
of the old static `initializeWithConfig` method

### 0.6.3

- New initializer for `LctvConfig` to specify `clientId` and `clientSecret`
- Made `LctvAuthViewController` final
- Improved code documentation
