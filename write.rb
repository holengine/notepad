require_relative 'lib/Post'
require_relative 'lib/Link'
require_relative 'lib/Memo'
require_relative 'lib/Task'

puts 'Привет, я блокнот версия 2, записываю новые записи в базу SQLite :)'
puts 'Что хотите записать сегодня?'

choices = Post.post_types.keys
choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = $stdin.gets.to_i
end

entry = Post.create(choices[choice])
entry.read_from_console
rowid = entry.save_to_db
puts "Запись сохранена в базе, id = #{rowid}"


