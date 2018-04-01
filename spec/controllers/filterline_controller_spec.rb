require 'rails_helper'

RSpec.describe FilterlineController, type: :controller do
  describe "#filter" do
    let!(:user) {FactoryBot.create :user}
    let!(:first_pipeline) {FactoryBot.create :pipe_line}
    let!(:second_pipeline) {FactoryBot.create :pipe_line}
    before do
      line = FactoryBot.create :line, pipe_line_id: first_pipeline.id
      FactoryBot.create :mark, line_id: line.id
    end
    context "as a authenticated user" do
      before {sign_in user}
      context "have params" do
        before do
          post :filter, params: {"#{first_pipeline.name}": true,
            "#{second_pipeline.name}": true}
        end
        it "Responds successfully" do
          expect(response).to be_success
        end

        it "render json response" do
          expect(response.content_type).to eq "application/json"
        end

        it "assign @data" do
          expect(assigns :data).not_to be nil
        end
      end

      context "params is blank" do
        before do
          post :filter, params: {}
        end

        it "Responds successfully" do
          expect(response).to be_success
        end

        it "assign @data" do
          expect(assigns :data).to be {}
        end
      end
    end

    context "as a unauthenticated user" do
      before do
        post :filter
      end
      it "return 302 status" do
        expect(response).to have_http_status 302
      end

      it "redirect_to root_url" do
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
