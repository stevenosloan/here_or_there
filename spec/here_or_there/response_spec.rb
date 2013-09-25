require 'spec_helper'

describe HereOrThere::Response do
  let(:response) { HereOrThere::Response.new( 'stdout', 'stderr', 'status' ) }

  describe "#stdout" do
    it "returns the stdout value" do
      expect( response.stdout ).to eq 'stdout'
    end
  end

  describe "#stderr" do
    it "returns the stderr value" do
      expect( response.stderr ).to eq 'stderr'
    end
  end

  describe "#status" do
    it "returns the status value" do
      expect( response.status ).to eq 'status'
    end
  end

  describe "#[]" do
    it "returns stdout for [0]" do
      expect( response[0] ).to eq 'stdout'
    end
    it "returns stderr for [1]" do
      expect( response[1] ).to eq 'stderr'
    end
    it "returns status for [2]" do
      expect( response[2] ).to eq 'status'
    end
  end

end