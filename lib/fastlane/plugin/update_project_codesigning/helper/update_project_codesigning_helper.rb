module Fastlane
  module Helper
    class UpdateProjectCodesigningHelper
      # class methods that you define here become available in your action
      # as `Helper::UpdateProjectCodesigningHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the update_project_codesigning plugin helper!")
      end
    end
  end
end
