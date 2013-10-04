module HereOrThere
  class SSH

    def run command
      stdout, stderr, status = [ '', '', false ]

      session.exec! command do |channel, response_type, response_data|
        if response_type == :stdout
          stdout = response_data
          status = Status.new(true)
        else
          stderr = response_data
          status = Status.new(false)
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