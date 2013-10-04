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

    def success?
      if status.respond_to? :success?
        status.success?
      else
        status
      end
    end
  end
end