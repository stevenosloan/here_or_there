- loosen net-ssh requirement to allow running on ruby 2.3+ w/o deprecatino warnings

# 0.2.0
- stderr & stdout now get appended to for each stream for remote commands, so you'll get the full response.

# 0.1.2
- fix occasional LocalJumpError in Remote::SSH#run

# 0.1.1
- make the close_session method public on Remote::SSH

# 0.1.0
- initial release

# 0.0.0
- bootstrap