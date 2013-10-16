require 'spec_helper'

describe HereOrThere::Remote do

  before :each do
    Net::SSH.stub( start: StubbedSession.new )
  end

  describe "::session" do

    before :each do
      if HereOrThere::Remote.send(:instance_variable_defined?, :@_sessions)
        HereOrThere::Remote.send(:remove_instance_variable, :@_sessions)
      end
    end

    it "creates an SSH object" do
      expect(
        HereOrThere::Remote.session( hostname: 'foo', user: 'bar' ).is_a?(HereOrThere::Remote::SSH)
      ).to be_true
    end

    it "doesn't recreate an instance" do
      first_instance = HereOrThere::Remote.session( hostname: 'foo', user: 'bar' )
      expect( HereOrThere::Remote.session( hostname: 'foo', user: 'bar' ) ).to eq first_instance
    end

    it "creates a new instance for uniq options" do
      first_instance = HereOrThere::Remote.session( hostname: 'foo', user: 'bar' )
      expect( HereOrThere::Remote.session( hostname: 'wu', user: 'tang' ) ).not_to eq first_instance
    end

  end

  describe HereOrThere::Remote::SSH do

    before :each do
      @ssh = HereOrThere::Remote::SSH.new( hostname: 'foo', user: 'bar' )
    end

    describe "#run" do
      it "returns a response object" do
        expect( @ssh.run("foo").is_a? HereOrThere::Response ).to be_true
      end

      context "when response is stdout" do

        before :each do
          StubbedSession.any_instance.stub(:exec!).and_yield("foo", :stdout, "hello stdout")
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
          StubbedSession.any_instance.stub(:exec!).and_yield("foo", :stderr, "hello stderr")
        end

        it "assigns response_data to Response.stderr" do
          expect( @ssh.run("foo").stderr ).to eq "hello stderr"
        end

        it "responds with an unsuccessful response object" do
          expect( @ssh.run("foo") ).not_to be_success
        end

      end

      context "when raises Net::SSH::AuthenticationFailed" do

        before :each do
          StubbedSession.any_instance.stub(:exec!).and_raise(Net::SSH::AuthenticationFailed)
        end

        it "returns an unsucessful response with err as stderr" do
          resp = @ssh.run("foo")
          expect( resp ).not_to be_success
          expect( resp.stderr ).to eq "Authentication failed when connecting to remote"
        end

        it "closes the session" do
          this_session = @ssh.session
          @ssh.run("foo")
          expect( @ssh.session ).not_to eq this_session
        end
      end
    end
  end

end