Pod::Spec.new do |spec|
spec.name = "RingCentralSwift"
spec.version = "0.0.1"
spec.summary = "NEW RCSDK POD"
spec.description = <<-DESC
Sample rcsdk swift pod
DESC
spec.homepage = "https://github.com/anilkumarbp/swift-sdk-new"
spec.platform = :osx, "10.10"
spec.platform = :ios, "8.0"
spec.license = "MIT"
spec.authors = { "Anil Kumar" => "anil.akbp@gmail.com" }
spec.source = { :git => "https://github.com/anilkumarbp/RingCentralSwift.git", :tag => "0.0.1" }
spec.source_files = "src/Core","src/Http","src/Platform","src/Subscription","src/Subscription/Crypto"
spec.exclude_files = "Classes/Exclude"
spec.requires_arc = true
spec.dependency 'PubNub', '~>4.0'
end