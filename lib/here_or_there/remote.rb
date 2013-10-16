module HereOrThere
  module Remote
    class << self

      def session options={}
        store.fetch(ssh_options) { add_session(ssh_options) }
      end

      private

        def sessions
          @_sessions ||= {}
        end

        def add_session ssh_options
          sessions[ssh_options] = Session.new( ssh_options )
        end

    end

    class SSH
      attr_accessor :hostname, :user, :options
      attr_reader   :session

      def initialize options
        @hostname  = options.delete(:hostname)
        @user      = options.delete(:user)
        @options   = options
      end

      def run command
        stdout, stderr, status = [ '', '', Status.new(false) ]

        session.exec! command do |channel, response_type, response_data|
          if response_type == :stdout
            stdout = response_data
            status = Status.new(true)
          else
            stderr = response_data
          end

          return Response.new( stdout, stderr, status )
        end
      rescue Net::SSH::AuthenticationFailed
        close_session
        return Response.new( '', 'Authentication failed when connecting to remote', Status.new(false) )
      end

      def open
        unless @session && !@session.closed?
          @session = Net::SSH.start hostname, user, options
        end
      end

      def close
        @session.close unless !@session || @session.closed?
      end
    end


    class Response
      attr_reader :success

      def initialize success
        @success = success
      end

      def success?
        success
      end
    end
  end

  class SSH

    attr_accessor :hostname, :user, :password, :keys, :forward_agent

    def run command
      stdout, stderr, status = [ '', '', Status.new(false) ]

      session.exec! command do |channel, response_type, response_data|
        if response_type == :stdout
          stdout = response_data
          status = Status.new(true)
        else
          stderr = response_data
        end

        return Response.new( stdout, stderr, status )
      end
    rescue Net::SSH::AuthenticationFailed
      close_session
      return Response.new( '', 'Authentication failed when connecting to remote', Status.new(false) )
    end

    def session
      if @_session.nil? || @_session.closed?
        @_session = Session.new()
      end

      return @_session
    end

    def set_ssh_options options={}

    end

    private

      def close_session
        @_session.close unless @_session.nil?
      end

    class Status
      attr_reader :success

      def initialize success
        @success = success
      end

      def success?
        success
      end
    end

    class Session
      def initialize
        @closed = false
      end

      def close
        @closed = true
      end

      def closed?
        @closed
      end

      def exec! command, &block
        yield ['foo', :stdout, "woop woop"]
      end
    end

  end
end