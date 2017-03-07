#
#  Be sure to run `pod spec lint ESPTouch.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WWZESPTouch"
  s.version      = "1.1.0"
  s.summary      = "A short description of WWZESPTouch."

  
  s.homepage     = "https://github.com/ccwuzhou/WWZESPTouch"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "wwz" => "wwz@zgkjd.com" }

  s.platform     = :ios

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/ccwuzhou/WWZESPTouch.git", :tag => "#{s.version}" }

  s.source_files  = "WWZESPTouch/WWZESPTouch/*.{h,m}"

  # s.public_header_files = "WWZSocket/WWZSocket.h"

  s.requires_arc = true

  s.framework  = "UIKit"
  # s.libraries = 'z.1','iconv.2','bz2.1.0','stdc++.6.0.9','c++','sqlite3'
end