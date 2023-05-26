#
# Be sure to run `pod lib lint AdFooter.podspec' to ensure this is a
# valid spec before submitting.
# # Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AdFooter"
  s.version          = "9.14.0"
  s.summary          = "AdMob on footer."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       The swift library to add AdMob to your view controller.
                       DESC

  s.homepage         = "https://gitlab.com/tnantoka/adfooter"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "tnantoka" => "tnantoka@bornneet.com" }
  s.source           = { :git => "https://gitlab.com/tnantoka/adfooter.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tnantoka'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.swift_version = '4.2'

  s.vendored_frameworks = 'Pod/Frameworks/GoogleMobileAds.xcframework'

  # https://github.com/CocoaPods/Specs/blob/dba355a5020f4acb6d61c33d1543e18023e12b68/Specs/5/9/a/Google-Mobile-Ads-SDK/7.69.0/Google-Mobile-Ads-SDK.podspec.json
  s.frameworks =
    "AudioToolbox",
    "AVFoundation",
    "CFNetwork",
    "CoreGraphics",
    "CoreMedia",
    "CoreTelephony",
    "CoreVideo",
    "MediaPlayer",
    "MessageUI",
    "MobileCoreServices",
    "QuartzCore",
    "Security",
    "StoreKit",
    "SystemConfiguration"
  s.weak_frameworks =
    "AdSupport",
    "JavaScriptCore",
    "SafariServices",
    "WebKit"
end
