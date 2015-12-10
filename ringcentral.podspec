Pod::Spec.new do |spec|
spec.name = "ringcentral"
<<<<<<< HEAD
<<<<<<< HEAD
spec.version = "0.0.2"
=======
spec.version = "0.0.3"
>>>>>>> 77e3356... FIX ME, Second round Implementation Complete
=======
spec.version = "0.0.3"
>>>>>>> 710dbfa... Getting rid of untracked changes
spec.summary = "RingCentral Swift SDK"
spec.description = <<-DESC
This RingCentral Swift SDK has been made to make Swift/ios development easier for developers who are using RingCentral Platform's suite of APIs. It handles authentication and the token lifecycle, makes API requests, and parses API responses. This documentation will help you get set up and going with some example API calls.
DESC
spec.homepage = "http://developers.ringcentral.com"
spec.platform = :osx, "10.10"
spec.platform = :ios, "8.0"
spec.ios.deployment_target = "8.0"
spec.osx.deployment_target = "10.10"
spec.license = "MIT"
spec.authors = { "Anil Kumar" => "anil.kumar@ringcentral.com" }
<<<<<<< HEAD
<<<<<<< HEAD
spec.source = { :git => "https://github.com/anilkumarbp/RingCentralSwift.git", :tag => "0.0.2" }
=======
spec.source = { :git => "https://github.com/anilkumarbp/RingCentralSwift.git", :tag => "0.0.3" }
>>>>>>> 77e3356... FIX ME, Second round Implementation Complete
=======
spec.source = { :git => "https://github.com/anilkumarbp/RingCentralSwift.git", :tag => "0.0.3" }
>>>>>>> 710dbfa... Getting rid of untracked changes
spec.source_files = "src/Core","src/Http","src/Platform","src/Subscription","src/Subscription/Crypto", "src/*.{h}"
spec.exclude_files = "Classes/Exclude"
spec.requires_arc = true
spec.dependency 'PubNub', '~>4.0'
end