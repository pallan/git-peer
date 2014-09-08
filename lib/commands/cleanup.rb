require 'commands/base'

module Commands
  class Cleanup < Base

    def run!
      super

      delete_flag = options[:force] ? '-D' : '-d'

      put(" * pruning origin")
      sys("git remote prune origin")

      get('git branch -vv').split("\n").each do |raw|
        parts = parse_line(raw)

        if parts && parts[3].include?(': gone')
          put(" * removing branch #{parts[1]}")
          sys("git branch #{delete_flag} #{parts[1]}") unless options[:dry_run]
        end
      end

      return 0
    end

  protected

    def parse_line(line)
      /\A(.*?)\s+([\w\d]{7})\s\[(.*?)\]\s(.*)\z/.match(line.strip)
    end

  private

    def parse_argv(*args)
      OptionParser.new do |opts|
        opts.banner = "Usage: git cleanup [options]"
        opts.on("-w", "--dry-run", "Show affected branches without removing them") { |w| options[:dry_run] = '[Dry-run] ' }
        opts.on("-f", "--force", "Force removal") { |f| options[:force] = f }
        opts.on("-v", "--[no-]verbose", "Run verbosely") { |v| options[:verbose] = v }
        opts.on_tail("-h", "--help", "This usage guide") { put opts.to_s; exit 0 }
      end.parse!(args)
    end

  end
end

