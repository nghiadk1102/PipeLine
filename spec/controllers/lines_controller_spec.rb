require 'rails_helper'

RSpec.describe LinesController, type: :controller do
  let! :user {FactoryBot.create :user}
  describe "#index" do
    let :line {FactoryBot.create :line}
    context "as a authenticated user" do
      before do
        sign_in user
        get :index, params: {id: line.id}
      end
      it "Respond successfully" do
        expect(response).to be_success
      end

      it "render template index" do
        expect(response).to render_template :index
      end

      it "assigns @lines" do
        expect(assigns :lines).to eq Line.all
      end

      it "assigns @new_line" do
        expect(assigns :new_line).to be_a_new Line
      end
    end

    context "as a unauthenticated user" do
      before do
        get :index
      end

      it "return 302 status" do
        expect(response).to have_http_status 302
      end

      it "redirect_to root_url" do
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe "#show" do
    let :line {FactoryBot.create :line}
    before do
      FactoryBot.create :mark, line_id: line.id
    end
    context "as a authenticated user" do
      before do
        sign_in user
        get :show, params: {id: line.id}
      end

      it "Respond successfully" do
        expect(response).to be_success
      end

      it "render template index" do
        expect(response).to render_template :show
      end
    end

    context "as a unauthenticated user" do
    end
  end

  describe "#create" do
    let :pipeline {FactoryBot.create :pipe_line}
    context "create successfully" do
      before do
        sign_in user
        post :create, params: {line: {name: "line1", description: "abc", pipe_line_id: pipeline.id, marks_attributes: [{lat: 1, lng: 1, index_mark: 1}]}}
      end

      it "redirect_to lines_url" do
        expect(response).to redirect_to lines_url
      end

      it do
        expect(controller).to set_flash[:success]
          .to("Create Line successfully")
      end

      it do
        expect{post :create, params: {line: {name: "line1", description: "abc", pipe_line_id: pipeline.id, marks_attributes: [{lat: 1, lng: 1, index_mark: 1}]}}}.to change {Line.all.count}.by 1
      end
    end

    context "create error" do
      before do
        sign_in user
        post :create, params: {line: {name: "", description: "abc", pipe_line_id: 1000, marks_attributes: [{lat: 1, lng: 1, index_mark: "string"}]}}
      end

      it "redirect_to lines_url" do
        expect(response).to redirect_to lines_url
      end

      it do
        expect(controller).to set_flash[:error]
          .to("Create line error")
      end
    end
  end

  describe "#destroy" do
    let :pipeline {FactoryBot.create :pipe_line}
    let! :line {FactoryBot.create :line, pipe_line_id: pipeline.id}
    context "destroy successfully" do
      before do
        sign_in user
      end

      it "redirect_to lines_url" do
        delete :destroy, params: {id: line.id}
        expect(response).to redirect_to lines_url
      end

      it do
        expect{delete :destroy, params: {id: line.id}}.to change {Line.all.count}.by -1
      end
    end

    context "destroy error" do
      before do
        sign_in user
        delete :destroy, params: {id: 1000}
      end

      it "redirect_to lines_url" do
        expect(response).to redirect_to lines_url
      end

      it do
        expect(controller).to set_flash[:error]
          .to("Delete line error")
      end
    end
  end
end
