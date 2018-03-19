# This lets cocoa pods know where to find the specifications for the pods
source 'https://github.com/CocoaPods/Specs.git'

# Define each dependency and associated version for your application

use_frameworks!
target ’TelstraAssignment’ do
    pod 'GZIP', '~> 1.2'
end

post_install do |installer|

# To set Use Legacy Swift Version to 'No'
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end

	# change bundle id of each pod to 'com.infosys.TelstraAssignment.*'
	bundle_id = 'com.infosys.TelstraAssignment.framework'

	directory = installer.config.project_pods_root + 'Target Support Files/'
	Dir.foreach(directory) do |path|

		full_path = directory + path
		if File.directory?(full_path)

			info_plist_path = full_path + 'Info.plist'
			if File.exist?(info_plist_path)

				text = File.read(info_plist_path)
				new_contents = text.gsub('org.cocoapods', bundle_id)
				File.open(info_plist_path, "w") {|file| file.puts new_contents }
			end
		end
	end
end
