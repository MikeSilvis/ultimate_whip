require 'spec_helper'

describe UsersController do

  describe "GET 'account'" do
    it "returns http success" do
      get 'account'
      response.should be_success
    end
  end

end
