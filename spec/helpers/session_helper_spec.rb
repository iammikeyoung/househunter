require "rails_helper"

RSpec.describe SessionsHelper do

  describe "#log_in" do
    it "takes a user as an argument"
    it "sets the sesssion[:user_id] equal to the user's id"
  end

  describe "#current_user" do
    it "keeps .current_user value the same if not nil"
    it "sets .current_user to user matching session[:user_id] if nil"
  end

  describe "#logged_in?" do
    it "gives a boolean return based on .current_user nil or not nil"
  end

  describe "#log_out" do
    it "destroys the user's session"
    it "sets .current_user to nil"
  end

end
