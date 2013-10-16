module HereOrThere
  module Remote
    class << self

      def session options={}
        sessions.fetch(options) { add_session(options) }
      end

      private

        def sessions
          @_sessions ||= {}
        end

        def add_session options
          sessions[options] = SSH.new( options )
        end

    end

    class SSH
      attr_accessor :hostname, :user, :options
      attr_reader   :session

      def initialize options
        @options   = options.dup
        @hostname  = @options.delete(:hostname)
        @user      = @options.delete(:user)
      end

      def run command
        stdout, stderr, status = [ '', '', false ]

        open_session

        session.exec! command do |channel, response_type, response_data|
          if response_type == :stdout
            stdout = response_data
            status = true
          else
            stderr = response_data
          end

          return Response.new( stdout, stderr, status )
        end
      rescue Net::SSH::AuthenticationFailed
        close_session
        return Response.new( '', 'Authentication failed when connecting to remote', false )
      end

      private

        def open_session
          unless session && !session.closed?
            @session = Net::SSH.start hostname, user, options
          end
        end

        def close_session
          session.close unless !session || session.closed?
        end

    end
  end
end