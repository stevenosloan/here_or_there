module HereOrThere
  class Shell

    def run command, &block
      stdout, stderr, status = Open3.capture3(command)
      response = Response.new( stdout, stderr, status )

      yield response.stdout if block_given?

      return response
    end


    def archive command, &block
      stdout, stderr, status = Open3.capture3(command)

      if status.success?
        yield stdout if block_given?
        return [ stdout, stderr, status ]
      else
        $stderr.puts "Problem running #{command}"
        $stderr.puts stderr
        return [ stdout, stderr, status ]
      end
    rescue StandardError => e
      $stderr.puts "Problem running '#{command}'"
      $stderr.puts "Error: #{e}"
    end

  end
end