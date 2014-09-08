require 'commands/base'

module Commands
  class Cleanup < Base

    def run!
      super

      get('git branch -vv').split("\n").each do |raw|
        parts = parse_line(raw)

        sys("git branch -d #{parts[1]}") if parts && parts[3].include?(': gone')
      end

      return 0
    end

    protected

    def parse_line(line)
      /\A(.*?)\s+([\w\d]{7})\s\[(.*?)\]\s(.*)\z/.match(line.strip)
    end

  end
end

