game_state = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil]
]

def get_current_player(game_state)
    y = 0
    r = 0
    game_state.each do |row|
        row.each do |element|
            if element == "y"
                y += 1
            elsif element == "r"
                r += 1
            end
        end
    end
    if y == r
        return "y"
    else
        return "r"
    end
end

def is_state_valid(game_state)
    y = 0
    r = 0
    wrong_char = 0
    game_state.each do |row|
        row.each do |element|
            if element == "y"
                y += 1
            elsif element == "r"
                r += 1
            elsif element != nil
                wrong_char += 1
            end
        end
    end

    # elements in the game_state can't be different then nil, r or y
    if wrong_char != 0
        return false
    end

    # since y always starts the game, r can't be greater    
    if r > y
        return false
    end

    # can't be nil below a color
    for col in 0..game_state[0].length - 1 do
        for row in 1..game_state.length - 1 do
            if game_state[row - 1][col] != nil && game_state[row][col] == nil
                return false
            end
        end
    end 
    
    return true
end

def play(game_state, column, color)
    row = game_state.length - 1
    if column <= game_state[0].length - 1 && column > 0
        while row >= 0 do
            if game_state[row][column] == nil
                game_state[row][column] = color
                break
            end
            row  -= 1
        end
    end
    return game_state
end

def winner(game_state)
    row = game_state.length - 1
    if get_current_player(game_state) == "r"
        color = "y"
    else
        color = "r"
    end

    # cheking horizotal win
    while row >= 0 do
        if game_state[row].include?(color)
            game_state[row].each_with_index do |element, index|
                if element == color
                    if game_state[row][index + 1] == color && 
                       game_state[row][index + 2] == color && 
                       game_state[row][index + 3] == color 
                        return true
                    end
                end
            end
        end
        row -= 1
    end
    row = game_state.length - 1

    # checking vertical win
    while row >= 3 do
        game_state[row].each_with_index do |element, index|
            if element == color
                if game_state[row - 1][index] == color && 
                   game_state[row - 2][index] == color && 
                   game_state[row - 3][index] == color 
                    return true
                end
            end
        end
        row -= 1
    end
    row = game_state.length - 1

    # checking diagonal right win
    while row >= 3 do
        if game_state[row].include?(color)
            game_state[row].each_with_index do |element, index|
                if element == color
                    if game_state[row - 1][index + 1] == color && 
                       game_state[row - 2][index + 2] == color && 
                       game_state[row - 3][index + 3] == color 
                        return true
                    end
                end
            end
        end
        row -= 1
    end
    row = game_state.length - 1
    
    # checking diagonal left win
    while row >= 3 do
        if game_state[row].include?(color)
            game_state[row].each_with_index do |element, index|
                if element == color
                    if game_state[row - 1][index - 1] == color && 
                       game_state[row - 2][index - 2] == color && 
                       game_state[row - 3][index - 3] == color 
                        return true
                    end
                end
            end
        end
        row -= 1
    end

    return false
end

def connect_four(game_state)
    col = 3
    color = get_current_player(game_state)
    game_state = play(game_state, col, color)

    if is_state_valid(game_state) == true
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