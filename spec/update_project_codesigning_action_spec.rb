describe Fastlane::Actions::UpdateProjectCodesigningAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The update_project_codesigning plugin is working!")

      Fastlane::Actions::UpdateProjectCodesigningAction.run(nil)
    end
  end
end
