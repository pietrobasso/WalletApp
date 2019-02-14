def shared_pods
# Async
  pod 'RxSwift'
  pod 'RxCocoa'
  # pod 'RxOptional'
# Graphics
  # pod 'Kingfisher'
# Others
  
end

platform :ios, '10.0'

target 'wallet' do
  use_frameworks!

  # Pods
  shared_pods

#  target 'walletTests' do
#    inherit! :search_paths
#  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
        end
    end
end
