require 'xcodeproj'
module Fastlane
  module Actions
    class UpdateProjectCodesigningAction < Action
      def self.run(params)
        path = params[:path]
        path = File.join(File.expand_path(path), "project.pbxproj")

        project = Xcodeproj::Project.open(params[:path])
        UI.user_error!("Could not find path to project config '#{path}'. Pass the path to your project (not workspace)!") unless File.exist?(path)
        UI.message("Updating the Automatic Codesigning flag to #{params[:use_automatic_signing] ? 'enabled' : 'disabled'} for the given project '#{path}'")
        project.root_object.attributes["TargetAttributes"].each do |target, sett|
          sett["ProvisioningStyle"] = params[:use_automatic_signing] ? 'Automatic' : 'Manual'
        end
        project.save
        UI.success("Successfully updated project settings to use ProvisioningStyle '#{params[:use_automatic_signing] ? 'Automatic' : 'Manual'}'")
      end

      def self.description
        "Updates the Xcode 8 Automatic Codesigning Flag"
      end

      def self.details
        "Updates the Xcode 8 Automatic Codesigning Flag of all targets in the project"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_PROJECT_SIGNING_PROJECT_PATH",
                                       description: "Path to your Xcode project",
                                       verify_block: proc do |value|
                                         UI.user_error!("Path is invalid") unless File.exist?(File.expand_path(value))
                                       end),
          FastlaneCore::ConfigItem.new(key: :use_automatic_signing,
                                       env_name: "FL_PROJECT_USE_AUTOMATIC_SIGNING",
                                       description: "Defines if project should use automatic signing",
                                       is_string: false,
                                       default_value: false)
        ]
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        ["mathiasAichinger"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
