require 'spec_helper'

describe HereOrThere do
  include HereOrThere

  describe "#run_local" do
    it "passes the command to a Local instance" do
      expect_any_instance_of( HereOrThere::Local ).to receive(:run).with("foo")

      run_local('foo')
    end
    it "returns a response object" do
      expect( run_local('spec/fixtures/hello_stdout').is_a? HereOrThere::Response ).to be_truthy
    end
  end

  describe "#run_remote" do
    it "passes the command to a SSH instance" do
      expect_any_instance_of( HereOrThere::Remote::SSH ).to receive(:run).with('ls')

      run_remote( 'ls', hostname: 'foo', user: 'bar' )
    end
    it "returns a response object" do
      allow_any_instance_of( HereOrThere::Remote::SSH ).to receive(:session)
                                                       .and_return(StubbedSession.new)

      expect( run_remote( 'ls', hostname: 'foo', user: 'bar').is_a? HereOrThere::Response ).to be_truthy
    end
  end

end