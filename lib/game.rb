require 'play.rb'
game_state = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil]
]
# performs the game to happen
def connect_four(game_state)
    col = 3
    color = get_current_player(game_state)
    game_state = play(game_state, col, color)
    # check if the game_state is valid to be played 
    if is_state_valid(game_state) == true
        # until there is a winner/draw columns will be picked to be played
        while winner(game_state) == false do
            col = rand(7)
            if game_state[0][col] != nil
                col = rand(7)
            elsif game_state[0][col] == nil
                color = get_current_player(game_state)
                game_state = play(game_state, col, color)
            else
                puts "It's a draw!"
            end
        end
        if color == "r"
            color = "red"
        else
            color = "yellow"
        end
        puts "The ultimate winner is : #{color}!"
    else
        puts "Uh oh, there is something wrong! Start the game over."
    end
end

connect_four(game_state)