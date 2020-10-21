source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
# ignore all warnings from all pods
inhibit_all_warnings!

def persistencePods
    pod 'RealmSwift'
end

target 'Logging' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Logging

end

target 'Model' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Model
  persistencePods
  target 'ModelTests' do
    # Pods for testing
  end

end

target 'Persistence' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Persistence
  persistencePods
  target 'PersistenceTests' do
    # Pods for testing
  end

end

target 'ProDash' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ProDash
  pod 'Kingfisher'
  target 'ProDashTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ProDashUITests' do
    # Pods for testing
  end

end

target 'Utilities' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Utilities

end
