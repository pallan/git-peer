# Git Peer

This is a small gem that adds some custom git commands that are not so
easy to add as aliases.

## Installation

This gem is not published to rubygems.org so you have to build it
yourself to install it. 
    $ git clone https://github.com/pallan/git-peer.git
    $ cd git-peer
    $ bundle
    $ rake install

## Commands

**git cleanup [options]**

Prunes the remote branches from origin and then deletes and local
branches whose remote tracking branch no longer exists. By default,
the branch removal is not forced (`-d`), use the `-f` flag to override
this.


    -v, --verbose   # verbose
    -f, --force     # force delete the branches (-D)
    -w, --dry-run   # show results without deleting

## Contributing

1. Fork it ( https://github.com/[my-github-username]/git-peer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
