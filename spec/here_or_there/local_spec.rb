require 'spec_helper'

describe HereOrThere::Local do
  context "when not given a block" do

    it "returns a Response instance" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout')
      expect( ret.is_a? HereOrThere::Response ).to be_truthy
    end
    it "returns stdout as return.stdout" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout' )
      expect( ret.stdout ).to eq "Hello Stdout\n"
    end

    it "returns stderr as return.stderr" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stderr' )
      expect( ret.stderr ).to eq "Hello Stderr\n"
    end

    it "returns a successful status for a successful command" do
      ret_succ = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout' )
      expect( ret_succ.success? ).to be_truthy
    end

    it "returns an unsuccessful status for an unsuccessful command" do
      ret_err  = HereOrThere::Local.new.run( 'spec/fixtures/hello_stderr' )
      expect( ret_err.success? ).to be_falsy
    end
  end

  context "when given a block" do
    it "yields Response" do
      ret = ""
      HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout' ) do |response|
        ret = response
      end

      expect( ret.class ).to eq HereOrThere::Response
    end
  end
end