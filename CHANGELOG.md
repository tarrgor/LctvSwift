## ChangeLog

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
