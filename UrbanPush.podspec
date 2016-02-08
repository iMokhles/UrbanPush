Pod::Spec.new do |s|
  s.name             = "UrbanPush"
  s.version          = "1.0"
  s.summary          = "send push through Urban Airship easily for iOS."

  s.description      = <<-DESC
                       objective-c urban airship push implementation for iOS to send urban airship easily
                       DESC

  s.homepage         = "https://github.com/iMokhles/UrbanPush"
  s.license          = 'MIT'
  s.author           = { "iMokhles" => "mokhleshussien@aol.com" }
  s.source           = { :git => "https://github.com/iMokhles/UrbanPush.git", :tag => "v1.0" }
  s.social_media_url = 'https://twitter.com/iMokhles'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'

  s.frameworks = 'UIKit', 'AudioToolbox'
end
