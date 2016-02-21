require 'commands/base'

module Commands
  class BranchStatus < Base

    def run!
      super

      stats = {}

      put("* loading all remote branches")
      output = get("git for-each-ref --format='%(refname)|%(committerdate:relative)|%(authoremail)' \
                                     --sort -committerdate")

      output.split("\n").each do |line|
        branch, date, author = line.split("|")
        if branch.include?('refs/remotes/origin')
          put(" * [VERBOSE] processing branch #{branch}") if options[:verbose]
          diffs = `git log --oneline remotes/origin/master..#{branch.gsub('refs/','')}`.split("\n").size
          stats[author] ||= []
          stats[author] << "  #{File.basename(branch)} [#{date}]; #{diffs}"
          stats[author].uniq!
        end
      end

      put("= Git Branch status\n")
      stats.each do |author, branches|
        put("\n== #{author}; Count: #{branches.count}")
        put(branches.join("\n"))
      end

      return 0
    end

  private

    def parse_argv(*args)
      OptionParser.new do |opts|
        opts.banner = "Usage: git branch-status [options]"
        opts.on("-v", "--[no-]verbose", "Run verbosely") { |v| options[:verbose] = v }
        opts.on_tail("-h", "--help", "This usage guide") { put opts.to_s; exit 0 }
      end.parse!(args)
    end

  end
end

