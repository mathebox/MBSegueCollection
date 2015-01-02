Pod::Spec.new do |s|
  s.name         = "MBSegueCollection"
  s.version      = "0.1.0"
  s.summary      = "Collection of custom iOS segues."
  s.description  = <<-DESC
                   MBSegueCollection is a growing collection of different custom segues for iOS 6 or later.
                   All segues can be used to present or to dismiss view controllers.
                   DESC
  s.homepage     = "https://github.com/mathebox/MBSegueCollection"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Max Bothe"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/mathebox/MBSegueCollection.git", :tag => "v0.1.0" }
  s.source_files  = "MBSegueCollection", "*.{h,m}"
  s.requires_arc = true
end