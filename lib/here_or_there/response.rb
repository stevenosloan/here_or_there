module HereOrThere
  class Response
    attr_reader :stdout, :stderr, :status

    def initialize stdout, stderr, status
      @stdout = stdout
      @stderr = stderr
      @status = status
    end

    def [] key
      case key
      when 0 then stdout
      when 1 then stderr
      when 2 then status
      else
        nil
      end
    end
  end
end