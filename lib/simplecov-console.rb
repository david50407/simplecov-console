require 'hirb'
require 'ansi/code'

class SimpleCov::Formatter::Console
  @@configures = {
    order_method: ->(files) { files.sort{ |a,b| a.covered_percent <=> b.covered_percent } },
    limit: 15
  }

  def self.config(options = {})
    @@configures.merge! options
  end

  def format(result)
    puts
    puts "COVERAGE: #{ colorize_percentage(result.covered_percent) } -- #{ covered_loc(result) } in #{ result.source_files.size } files"
    puts

    files = order_files(result.source_files)

    full_covered_files = []
    files.select! do |file|
      if file.covered_percent == 100
        full_covered_files << file
        break false
      end
      true
    end

    return if files.nil? || files.empty?

    table = files.map do |f|
      { :coverage => format_percentage(f.covered_percent),
        :lines => f.lines_of_code,
        :file => f.filename.gsub(SimpleCov.root, '.').gsub('./', ''),
        :missed => f.missed_lines.count,
        :missing => group_missed_lines(f.missed_lines).join(", ") }
    end

    if @@configures[:limit] && table.size > @@configures[:limit]
      puts "showing top #{ @@configures[:limit] } of #{ table.size } files"
      table = table.take(@@configures[:limit])
    end

    puts Hirb::Helpers::Table.render(table, description: false).gsub(/([ \d.]{6})%/) { |_| colorize_percentage($1.to_f) }
    puts "#{ full_covered_files.count } file(s) with 100% coverage not shown" if full_covered_files.count > 0
  end

  def group_missed_lines(missed_lines)
    groups = []
    missed_lines.each do |line|
      line_number = line.line_number
      if groups.last && groups.last[1] + 1 == line_number
        groups.last[1] = line_number
      else
        groups << [line_number, line_number]
      end
    end

    groups.map do |from, to|
      from == to ? "#{from}" :  "#{from}-#{to}"
    end
  end

  private

  def order_files(files)
    @@configures[:order_method].call files
  end

  def covered_loc(result)
    "#{ result.covered_lines } / #{ result.total_lines } LOC covered"
  end

  def colorize_percentage(val)
    case
    when val >= 90
      ANSI.green { format_percentage(val) }
    when val >= 80
      ANSI.yellow { format_percentage(val) }
    else
      ANSI.red { format_percentage(val) }
    end
  end

  def format_percentage(val)
    "%6.2f%%" % [val]
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'simplecov-console/version'
