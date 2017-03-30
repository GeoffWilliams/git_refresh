require 'fileutils'
module GitRefresh
  module Git

    # Clone or update a git repo
    def self.refresh(target_dir, source_url, ref='master')
      status = false
      FileUtils.mkdir_p target_dir
      if Dir.exists?("#{target_dir}/.git")
        # update
        Dir.chdir(target_dir) do
          status = system("git fetch && git checkout #{ref}")
        end
      else
        # clone
        status = system("git clone -b #{ref} #{source_url} #{target_dir}")
      end


      if ! status
        raise "Git operation failed, see previous error"
      end

      status
    end
  end
end
