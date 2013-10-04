require 'spec_helper'

describe HereOrThere::SSH do
  describe "#session" do

    before :each do
      @ssh = HereOrThere::SSH.new
    end

    it "creates a session" do
      expect( @ssh.session.is_a? HereOrThere::SSH::Session ).to be_true
    end

    it "returns the same session" do
      first_session = @ssh.session
      expect( @ssh.session ).to eq first_session
    end

    it "creates a new session if the session has closed" do
      first_session = @ssh.session
      first_session.close
      expect( @ssh.session ).not_to eq first_session
    end

  end
end