describe Fastlane::Actions::UpdateProjectCodesigningAction do
  describe '#run' do
    it 'Updates a Project to manual signing' do
      expect(Fastlane::UI).to receive(:success).with("Successfully updated project settings to use ProvisioningStyle 'Manual'")

      Fastlane::Actions::UpdateProjectCodesigningAction.run(path: "demo-project/demo/demo.xcodeproj")
    end
  end
end
