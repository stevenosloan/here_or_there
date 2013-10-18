Unified interface for ssh or local commands.

Use
---

For running local commands it is very much like using the Open3 standard lib, only it returns the same response object as ssh commands.

```ruby
require 'here_or_there'
include HereOrThere

command = 'whoami'
resp = run_local( command )
resp.stdout
# => "user\n"
resp.stderr
# => ""
resp.success?
# => true
```

Remote processes are very similar, except that you also pass the information required to establish the remote connection.

```ruby
require 'here_or_there'
include HereOrThere

command = 'whoami'
resp = run_remote( command, hostname: 'your_remote', username: 'user', password: 'password' )
resp.stdout
# => "user\n"
resp.stderr
# => ""
resp.success?
# => true

# if you have .ssh/config setup, hostname is all that is required

resp = run_remote( command, hostname: 'your_remote' )
resp.stdout
# => "ssh_user\n"
resp.stderr
# => ""
resp.success?
# => true
```

### Response Object

Response objects respond as you expect they would to `stdout` and `stderr` giving you those values. It also has a `success?` method that will retun a bolean of whether the command exited 0 or not.


Testing
-------

Tests are run using [rspec](https://github.com/rspec/rspec). Net::SSH sessions are [stubbed](spec/support/stubbed_session.rb) to prevent needing an actual connection for the suite to run.

```bash
$ rspec
```


Contributing
------------

If there is any thing you'd like to contribute or fix, please:

- Fork the repo
- Add tests for any new functionality
- Make your changes
- Verify all new & existing tests pass
- Make a pull request


License
-------
The here_or_there gem is distributed under the MIT License.