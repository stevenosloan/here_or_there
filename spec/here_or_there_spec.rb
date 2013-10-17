require 'spec_helper'

describe HereOrThere do
  include HereOrThere

  describe "#run_local" do
    it "passes the command to a Local instance" do
      HereOrThere::Local.any_instance.should_receive(:run).with("foo")

      run_local('foo')
    end
    it "returns a response object" do
      expect( run_local('spec/fixtures/hello_stdout').is_a? HereOrThere::Response ).to be_true
    end
  end

  describe "#run_remote" do
    it "passes the command to a SSH instance" do
      HereOrThere::Remote::SSH.any_instance.should_receive(:run).with('ls')

      run_remote( 'ls', hostname: 'foo', user: 'bar' )
    end
    it "returns a response object" do
      HereOrThere::Remote::SSH.any_instance.stub( session: StubbedSession.new )
      expect( run_remote( 'ls', hostname: 'foo', user: 'bar').is_a? HereOrThere::Response ).to be_true
    end
  end

end