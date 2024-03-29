# count the number of y and r in the game_state to define whose turn it is
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

# check if the game is valid to be played
def is_state_valid(game_state)
    y = 0
    r = 0
    wrong_char = 0
    # can't have elements different then nil, y or r
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
    if wrong_char != 0
        return false
    end
    # r can't be greater, since y always starts the game
    if r > y
        return false
    end
    # column can't have nil below a disk played
    for col in 0..game_state[0].length - 1 do
        for row in 1..game_state.length - 1 do
            if game_state[row - 1][col] != nil && game_state[row][col] == nil
                return false
            end
        end
    end 
    return true
end

# add the colored disk to the column of choice always from the bottom
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

# check if there is a winner
def winner(game_state)
    row = game_state.length - 1
    if get_current_player(game_state) == "r"
        color = "y"
    else
        color = "r"
    end
    # check horizotal win
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
    # check vertical win
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
    # check diagonal right win
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
    # check diagonal left win
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