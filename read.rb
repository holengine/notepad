require_relative 'lib/Post'
require_relative 'lib/Link'
require_relative 'lib/Memo'
require_relative 'lib/Task'

require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'

  # Вывод в случае, если запросили help
  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  # Опция --type будет передавать тип поста, который мы хотим считать
  opt.on('--type POST_TYPE', 'какой тип постов показывать ' \
         '(по умолчанию любой)') { |o| options[:type] = o }

  # Опция --id передает номер записи в базе данных (идентификатор)
  opt.on('--id POST_ID', 'если задан id — показываем подробно ' \
         ' только этот пост') { |o| options[:id] = o }

  # Опция --limit передает, сколько записей мы хотим прочитать из базы
  opt.on('--limit NUMBER', 'сколько последних постов показать ' \
         '(по умолчанию все)') { |o| options[:limit] = o }

  # В конце у только что созданного объекта класс OptionParser вызываем
  # метод parse, чтобы он заполнил наш хэш options в соответствии с правилами.
end.parse!

result = if options[:id].nil?
           Post.find(options[:limit], options[:type])
         else
           Post.find_by_id(options[:id])
         end

if result.is_a? Post
  puts "Запись #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each { |line| puts line }
else
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  # Используем safe навигацию, учитывая возможное значение nil для result
  result&.each do |row|
    puts

    row.each do |element|
      element_text = "| #{element.to_s.delete("\n")[0..17]}"
      element_text << ' ' * (21 - element_text.size)
      print element_text
    end

    print '|'
  end

  puts
end

