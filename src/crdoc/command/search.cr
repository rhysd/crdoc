require "option_parser"

class Crdoc::Command::Search
  def initialize(@docs, @kind = nil)
  end

  def kind
    if @kind
      @kind.to_s
    else
      "search"
    end
  end

  def ask(candidates)
    puts "Multiple candidates are found.\n\n"
    candidates.each_with_index do |c, i|
      puts "  [#{i}] #{c}"
    end
    print "\nNumber: "
    STDOUT.flush
    input = gets
    if input
      candidates[input.to_i]? rescue nil
    else
      nil
    end
  end

  def run(args)
    feeling_lucky = false

    begin
      OptionParser.parse(args) do |parser|
        parser.banner = "crdoc #{kind} keywords..."
        parser.on("-f", "--feeling-lucky", "Open firstly found candidate") do
          feeling_lucky = true
        end
      end
    rescue e
      STDERR.puts e
      return false
    end

    if args.empty?
      STDERR.puts "No search keyword is specified"
      return false
    end

    ls = @docs.list(@kind).select do |c|
      args.all? do |a|
        c.includes? a
      end
    end

    if ls.empty?
      puts "No result for #{args}"
      return true
    end

    if feeling_lucky
      puts ls.min_by &.size
      true
    else
      selected = ask(ls)
      if selected
        puts selected
        true
      else
        STDERR.puts "Invalid input."
        false
      end
    end
  end
end
