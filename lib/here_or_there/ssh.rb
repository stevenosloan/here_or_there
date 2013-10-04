module HereOrThere
  class SSH

    def session
      if @_session.nil? || @_session.closed?
        @_session = Session.new()
      end

      return @_session
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
    end

  end
end