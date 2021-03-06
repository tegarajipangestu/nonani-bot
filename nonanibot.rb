require 'telegram/bot'
require 'csv'

token = '323650569:AAH0miXDpgJJQoFOJ9Mr2HQ8QMLP281Iq1w'

def search_from_file(tag)
  result = []
  tag.each do |t|
    return @jokes if t.downcase == 'random'
    @jokes.each do |row|
      result << row if row['tags'].downcase =~ Regexp.new(t.downcase)
    end
  end
  result
end

def load_from_file
  @jokes ||= begin
    jokes = []
    jokes_file = 'nonanibot-db - jokebapakbapak.csv'
    CSV.foreach(jokes_file, headers: true) do |row|
      jokes << row
    end
    jokes
  end
end

def random_keyword(message)
  result =  message.split(/\W+/)
end

Telegram::Bot::Client.run(token) do |bot|
  puts "Starting bot"
  load_from_file
  bot.listen do |message|
    jokes = search_from_file(random_keyword(message.text))
    unless jokes.empty?
      n = rand(0..jokes.size-1)
      bot.api.send_message(chat_id: message.chat.id, text: jokes[n]['pun'].to_s)
    end
  end
end
