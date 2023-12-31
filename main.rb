require "./lib/connect_four"
connect_four = ConnectFour.new
player_input = nil

until !connect_four.game_state do
  connect_four.show_board
  puts "Enter column to insert ball: "
  player_input = gets.chomp.to_i
  connect_four.place_ball(player_input)
  connect_four.check_win

end

puts connect_four.message
