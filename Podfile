# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'TodoMVC' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TodoMVC
	pod 'Alamofire', '3.4.1'
	pod 'ObjectMapper', '~> 1.3.0'
    pod 'SBTUITestTunnel/Server', :git => 'https://github.com/venkateshcm/SBTUITestTunnel'
end

target 'TodoMVCTests' do
	use_frameworks!
    pod 'Nimble', '~> 4.1.0'
    pod 'Quick', '~> 0.9.3'
	pod 'MockFive'
end

target 'TodoMVCUITests' do
    use_frameworks!
    pod 'SBTUITestTunnel/Client', :git => 'https://github.com/venkateshcm/SBTUITestTunnel'
end
