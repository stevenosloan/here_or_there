require 'spec_helper'

describe HereOrThere::Shell do
  context "when not given a block" do
    it "returns stdout as return[0]" do
      ret = HereOrThere::Shell.new.run( 'spec/fixtures/hello_stdout' )
      expect( ret[0] ).to eq "Hello Stdout\n"
    end

    it "returns stderr as return[1]" do
      ret = HereOrThere::Shell.new.run( 'spec/fixtures/hello_stderr' )
      expect( ret[1] ).to eq "Hello Stderr\n"
    end

    it "returns status as return[2]" do
      ret_succ = HereOrThere::Shell.new.run( 'spec/fixtures/hello_stdout' )
      ret_err = HereOrThere::Shell.new.run( 'spec/fixtures/hello_stderr' )

      expect( ret_succ[2] ).to be_success
      expect( ret_err[2] ).not_to be_success
    end
  end

  context "when given a block with a single argument" do
    it "yields stdout" do
      ret_stdout = ""
      HereOrThere::Shell.new.run( 'spec/fixtures/hello_stdout' ) do |stdout|
        ret_stdout = stdout
      end

      expect( ret_stdout ).to eq "Hello Stdout\n"
    end
  end

  context "when given a block with two arguments" do
  end

  context "when given a block with three arguments" do
  end
end