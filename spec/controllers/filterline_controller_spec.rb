require 'rails_helper'

RSpec.describe FilterlineController, type: :controller do
  describe "#filter" do
    it "Responds successfully" do
      expect(response).to be_success
    end
  end
end
