module HereOrThere
  class Shell

    def run command, &block
      stdout, stderr, status = Open3.capture3(command)

      yield stdout if block_given?

      [stdout, stderr, status]
    end

  end
end