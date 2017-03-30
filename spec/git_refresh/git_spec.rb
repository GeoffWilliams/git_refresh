require "spec_helper"
require "git_refresh/git"
require "tmpdir"
require "fileutils"

describe GitRefresh::Git do
  SOURCE_REPO           = Dir.mktmpdir
  TESTCASE_REPO_TARBALL = "#{Dir.pwd}/spec/fixtures/git_repo.tar.gz"

  # extract the testcase git repo from fixtures.  Don't store a git inside a git
  # so use a tarball instead
  before(:all) do
    puts "unpack testacsae"
    system("cd #{SOURCE_REPO} && tar zxvf #{TESTCASE_REPO_TARBALL}")
  end

  # cleanup the testcase git repo
  after(:all) do
    FileUtils.rm_rf(SOURCE_REPO)
  end

  it "clones master branch OK" do
    Dir.mktmpdir {|dir|
      Dir.chdir dir do
        status = GitRefresh::Git.refresh(dir, SOURCE_REPO)

        expect(status).to be true
        expect(File.exists?("readme.txt")).to be true
        branch = %x{git rev-parse --abbrev-ref HEAD}.strip
        expect(branch).to eq 'master'
      end
    }
  end


  it "clones specific branch OK" do
    Dir.mktmpdir {|dir|
      Dir.chdir dir do
        status = GitRefresh::Git.refresh(dir, SOURCE_REPO, 'mybranch')

        expect(status).to be true
        expect(File.exists?("readme.txt")).to be true
        branch = %x{git rev-parse --abbrev-ref HEAD}.strip
        expect(branch).to eq 'mybranch'
      end
    }
  end

  it "updates to requested branch OK" do
    Dir.mktmpdir {|dir|
      Dir.chdir(dir) do
        # test setup: manual checkout out of code in master
        system("git clone #{SOURCE_REPO} #{dir}")
        branch = %x{git rev-parse --abbrev-ref HEAD}.strip
        expect(branch).to eq 'master'

        # main test
        status = GitRefresh::Git.refresh(dir, SOURCE_REPO, 'mybranch')

        expect(status).to be true
        expect(File.exists?("readme.txt")).to be true

        # check we were updated
        branch = %x{git rev-parse --abbrev-ref HEAD}.strip
        expect(branch).to eq 'mybranch'
      end
    }
  end

  it "raises on missing git repo" do
    # because the exception propagation deletes our tempdir if we use block
    # syntax we must manually manage it for this test or we catch the wrong failure
    # and error
    dir = Dir.mktmpdir

    Dir.chdir dir do
      expect{GitRefresh::Git.refresh(dir, "http://nothere/no.git", 'mybranch')}.to raise_error /operation failed/
    end

    FileUtils.rm_rf(dir)
  end

end
