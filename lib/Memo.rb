class Memo < Post
  def read_from_console
    puts 'Я сохраню всё, что ты напишешь до строчки "end" в файл.'

    line = nil

    while line != 'end'
      line = $stdin.gets.chomp
      @text << line
    end
    @text.pop
  end

  def to_db_hash
    super.merge(
      'text' => @text.join('\n\r')
    )
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n"

    @text.unshift(time_string)
  end

  def load_data(data_hash)
    super(data_hash)
    @text = data_hash['text'].split('\n\r')
  end

  def save
    file = File.new(file_path, 'w')
    time_string = @created_at.strftime('%Y.%m.%d, %H:%M')
    file.puts("#{time_string}\n\r")

    @text.each do |item|
      file.puts(item)
    end
    file.close
    puts 'Ваша запись сохранена'
  end
end
