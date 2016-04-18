Readme


## Main specs:

* Developed in SWIFT 2
* iOS 9.0 compatible
* CocoaPods
* Using MVC design pattern
* Network requests in the background
* Network requests recursively repeated if temporary error (increasing delay till 30 second)
* Network requests applied Apple recommendations (see "Network requests failures" below)
* Log network requests/responses to console with different logs levels
* Image downloading in the background
* Unit tests
* Unit tests for Network requests (stubbed with OHHTTPStubs and not stubbed)
* Pull to refresh weather
* cache by 5 mins internally, cause OpenWeatherMap has no cache system. (not finished)
* waiting indicators in status bar / webview
* showing slow internet connectivity
* units are in metrics (Celsius,...)

- **PR2Studio classes**. I applied some of my own classes I use to develop in Swift.

- **No Storyboards**. I much prefer to use NIBs than storyboards, storyboards are really a problem in team development (because git conflicts) and with NIBs you have more flexibility to enable different behaviors

- **Trying to apply SOLID principles**. Specially the Single Responsability. Classes must be lightewigth and perform only one task inside his abstraction layer. So it's better to have more classes that one big bloated class 

- Using as few external libraries as possible:

* Alamofire - Network layer
* AlamofireImage - Async Image download in the background
* SwiftyJSON - JSON parsing.
* OHHTTPStubs - Stub network requests

## Network requests failures

This is not a trivial issue, some debate ongoing and as per this docs

Networking Overview
https://developer.apple.com/library/ios/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/WhyNetworkingIsHard/WhyNetworkingIsHard.html#//apple_ref/doc/uid/TP40010220-CH13-SW8

WWDC 2012 Session 706, "Networking Best Practices"
https://developer.apple.com/videos/play/wwdc2012-706/

Almofire documentation
https://github.com/Alamofire/Alamofire

So we conclude with this (and it is applied in the exercise):

* Don't use Rechability to determine if a network request should be sent. You should always send the request.
* Analize Reachability if failures. When Reachability is restored, use the event to retry failed network requests. (Even though the network requests may still fail, this is a good moment to retry them.)
* Don't timeout, let the system to do it. There is no good timeout value


## TODO

* HeaderDoc HTML based documentation. Generated using jazzy
* Unit tests. not completed
* creata secondary target for slow connectivity tests using OHHTTPStubs
* cache by 5 mins internally, cause OpenWeatherMap has no cache system.
