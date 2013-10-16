module HereOrThere
  class Local

    def run command, &block
      stdout, stderr, status = Open3.capture3(command)
      response = Response.new( stdout, stderr, status )

      yield response if block_given?

      return response
    end

  end
end