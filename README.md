[![Build Status](https://travis-ci.org/GeoffWilliams/git_refresh.svg?branch=master)](https://travis-ci.org/GeoffWilliams/git_refresh)
# GitRefresh

Checkout a particular ref from git inside a particular directory

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_refresh'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_refresh

## Usage
* see git_refresh --help for most current instructions

### Checking out a master branch of a git repo to a directory

```shell
git_refresh refresh --source-url https://github.com/foo/bar.git --target-dir /tmp/bar
```

### Checking out a specific git ref to a directory

```shell
git_refresh refresh --source-url https://github.com/foo/bar.git --target-dir /tmp/bar --ref mybranch
```

## Troubleshooting
* If you can't find the `git_refresh` command and your using `rbenv` be sure to run `rbenv rehash` after installing the gem to create the necessary symlinks

## Support
This software is not supported by Puppet, Inc.  Use at your own risk.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/GeoffWilliams/git_refresh.

### Running tests
* git_refresh includes a comprehensive tests.  Please ensure tests pass before and after any PRs
* Run all tests `bundle exec rake spec`
* Run specific test file `bundle exec rspec ./spec/SPEC/FILE/TO/RUN.rb`
* Run specific test case `bundle exec rspec ./spec/SPEC/FILE/TO/RUN.rb:99` (where 99 is the line number of the test)
