require 'rails_helper'

describe RadioBuilder do

  describe ".build" do
    it "nothing music playing" do
      allow_any_instance_of(Radio::Itunes).to receive(:playing?).and_return(false)
      allow_any_instance_of(Radio::Spotify).to receive(:playing?).and_return(false)

      expect(RadioBuilder.build).to be_nil
    end

    it "when iTunes is playing" do
      allow_any_instance_of(Radio::Itunes).to receive(:playing?).and_return(true)
      expect(RadioBuilder.build).to be_instance_of(Radio::Itunes)
    end

    it "when spotify is playing" do
      allow_any_instance_of(Radio::Itunes).to receive(:playing?).and_return(false)
      allow_any_instance_of(Radio::Spotify).to receive(:playing?).and_return(true)

      expect(RadioBuilder.build).to be_instance_of(Radio::Spotify)
    end
  end
end
