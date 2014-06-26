# utils
# nice to have for debugging -- uncomment in gemfile to use
# require 'pry'
# require 'byebug'

# rspec support
require 'support/capture'
require 'support/stubbed_session'

# library
require 'here_or_there'

describe "support" do

  describe Capture do
    describe "#stdout" do
      it "returns a string representation fo what is sent to stdout inside the given block" do
        out = Capture.stdout { $stdout.puts "hello"; $stdout.puts "world" }
        expect( out ).to eq "hello\nworld\n"
      end
    end

    describe "#stderr" do
      it "returns a string representation fo what is sent to stderr inside the given block" do
        out = Capture.stderr { $stderr.puts "hello"; $stderr.puts "world" }
        expect( out ).to eq "hello\nworld\n"
      end
    end
  end

end


describe "fixtures" do

  describe "hello_stdout" do
    it "puts hello stdout to stdout" do
      stdout, stderr, status = Open3.capture3('spec/fixtures/hello_stdout')
      expect( stdout ).to eq "Hello Stdout\n"
    end

    it "returns success code" do
      stdout, stderr, status = Open3.capture3('spec/fixtures/hello_stdout')
      expect( status.success? ).to be_truthy
    end
  end

  describe "hello_stderr" do
    it "puts hello stderr to stderr" do
      stdout, stderr, status = Open3.capture3('spec/fixtures/hello_stderr')
      expect( stderr ).to eq "Hello Stderr\n"
    end

    it "returns error code" do
      stdout, stderr, status = Open3.capture3('spec/fixtures/hello_stderr')
      expect( status.success? ).to be_falsy
    end
  end

end