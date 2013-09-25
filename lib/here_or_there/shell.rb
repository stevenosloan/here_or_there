module HereOrThere
  class Shell

    def run command
      stdout, stderr, status = Open3.capture3(command)

      [stdout, stderr, status]
    end

  end
end