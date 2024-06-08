require 'discordrb'
require 'dotenv/load'
require 'colorize'

bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], prefix: "/"

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.command :pinga do |event|
  event.respond "Pong..."
end

bot.run