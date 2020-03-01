require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    # 正常にレスポンスを返すこと
    it "responds successfully" do
      get :new
      expect(response).to be_success
    end
  end

end
