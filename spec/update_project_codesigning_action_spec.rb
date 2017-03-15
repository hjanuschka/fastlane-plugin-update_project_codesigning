describe Fastlane::Actions::UpdateProjectCodesigningAction do
  describe '#run' do
    it 'Updates a Project to manual signing' do
      allow(Fastlane::UI).to receive(:success)
      expect(Fastlane::UI).to receive(:success).with("Modified Targets:")

      Fastlane::Actions::UpdateProjectCodesigningAction.run(path: "demo-project/demo/demo.xcodeproj")
    end
  end
end
