require "option_parser"

class Crdoc::Command::List
  def initialize(@docs)
  end

  def run(args)
    kind = nil
    show_path = false

    begin
      OptionParser.parse(args) do |parser|
        parser.banner = "crdoc list"
        parser.on("-a", "--api", "Lists all API candidates") do
          kind = :api
        end
        parser.on("-s", "--syntax-and-semantics", "Lists all language spec candiadtes") do
          kind = :syntax_and_semantics
        end
        parser.on("-p", "--path", "Lists full path to the HTML document instead of canidates") do
          show_path = true
        end
      end
    rescue e
      STDERR.puts e
      return false
    end

    if show_path
      @docs.list_paths(kind).each{|c| puts c}
    else
      @docs.list(kind).each{|c| puts c}
    end
    true
  end
end
