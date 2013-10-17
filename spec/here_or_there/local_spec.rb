require 'spec_helper'

describe HereOrThere::Local do
  context "when not given a block" do

    it "returns a Response instance" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout')
      expect( ret.is_a? HereOrThere::Response ).to be_true
    end
    it "returns stdout as return[0]" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout' )
      expect( ret[0] ).to eq "Hello Stdout\n"
    end

    it "returns stderr as return[1]" do
      ret = HereOrThere::Local.new.run( 'spec/fixtures/hello_stderr' )
      expect( ret[1] ).to eq "Hello Stderr\n"
    end

    it "returns status as return[2]" do
      ret_succ = HereOrThere::Local.new.run( 'spec/fixtures/hello_stdout' )
      ret_err  = HereOrThere::Local.new.run( 'spec/fixtures/hello_stderr' )

      expect( ret_succ[2] ).to be_success
      expect( ret_err[2] ).not_to be_success
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