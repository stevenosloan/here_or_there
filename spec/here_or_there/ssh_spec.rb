require 'spec_helper'

describe HereOrThere::SSH do

  describe "#run" do

    before :each do
      @ssh = HereOrThere::SSH.new
    end

    it "returns a response object" do
      expect( @ssh.run("foo").is_a? HereOrThere::Response ).to be_true
    end

    context "when response is stdout" do

      before :each do
        allow( @ssh.session ).to receive(:exec!).and_yield("foo", :stdout, "hello stdout")
      end

      it "assigns response_data to Response.stdout" do
        expect( @ssh.run("foo").stdout ).to eq "hello stdout"
      end

      it "responds with a successful response object" do
        expect( @ssh.run("foo") ).to be_success
      end

    end

    context "when response is stderr" do

      before :each do
        allow( @ssh.session ).to receive(:exec!).and_yield("foo", :stderr, "hello stderr")
      end

      it "assigns response_data to Response.stderr" do
        expect( @ssh.run("foo").stderr ).to eq "hello stderr"
      end

      it "responds with an unsuccessful response object" do
        expect( @ssh.run("foo") ).not_to be_success
      end

    end

  end

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