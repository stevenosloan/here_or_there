# util
require 'open3'
require 'net/ssh'

# gem
require 'here_or_there/version'
require 'here_or_there/response'
require 'here_or_there/local'
require 'here_or_there/remote'

module HereOrThere

  def run_local command
    Local.new.run command
  end

  def run_remote command, options={}
    Remote.session( options ).run( command )
  end

end