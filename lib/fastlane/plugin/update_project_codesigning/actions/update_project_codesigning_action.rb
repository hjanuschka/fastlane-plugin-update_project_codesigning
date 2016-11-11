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

        unless project.root_object.attributes["TargetAttributes"]
          UI.error("Seems to be a very old project file format")
          UI.error("PLEASE BACKUP ALL FILES before doing this.")
          if UI.confirm("Proceed with upgrade to xcode8 format?") || ENV["FL_PROJECT_SIGNING_FORCE_UPGRADE"]
            UI.important("Upgrading project to use xcode8 signing stuff")
            unless params[:team_id]
              UI.important("TEAM id is not set")
              UI.error!("Provide :team_id")
            end

            # set upgrade market to xcdoe8
            project.root_object.attributes["LastUpgradeCheck"] = "0800"
            target_attr_hash = {}

            # for each target add the TargetAttributes Entry
            # setting team id, and signing mode
            project.root_object.targets.each do |target|
              new_hash = {}
              new_hash["CreatedOnToolsVersion"] = "8.0"
              new_hash["DevelopmentTeam"] = params[:team_id]
              new_hash["ProvisioningStyle"] = params[:use_automatic_signing] ? 'Automatic' : 'Manual'
              target_attr_hash[target.uuid] = new_hash
            end

            # for each configuration set a signing identity

            project.build_configurations.each do |config|
              config.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = config.name == "Release" ? 'iPhone Distribution' : "iPhone Development"
            end
            project.root_object.attributes["TargetAttributes"] = target_attr_hash
          else
            UI.user_error!("canceled upgrade")
          end
        end

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
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :team_id,
                                        env_name: "FASTLANE_TEAM_ID",
                                        description: "Team ID, is used when upgrading project",
                                        is_string: true)
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
