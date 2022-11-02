require_relative 'lib/Post'
require_relative 'lib/Link'
require_relative 'lib/Memo'
require_relative 'lib/Task'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокнот?'

choices = Post.post_types
choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = gets.chomp.to_i
end

entry = Post.create(choice)
entry.read_from_console
entry.save
puts 'Ваша запись сохранена!'
