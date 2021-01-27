require './player.rb'
require './board.rb'
require './game.rb'

p1 = ""
until p1.length == 1
  puts "Player 1, please choose your mark. Make sure it's only one letter or symbol"
  p1 = gets.chomp
end
p2 = ""
until p2.length == 1
  puts "Player 2, please choose your mark. Make sure it's only one letter or symbol"
  p2 = gets.chomp
  if p2 == p1
    puts "You cannot have the same symbol as Player 1"
    p2 = "Wrong"
  end
end

game = Game.new(p1.upcase.to_sym, p2.upcase.to_sym)
game.play
