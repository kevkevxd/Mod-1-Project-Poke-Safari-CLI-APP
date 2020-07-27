class CLI
    def start
        puts "Welcome to PokeCLI! Would you like to sign up or sign in?"
        user_login_input = gets.chomp 
        
        if user_login_input == "sign up"
            User.sign_up
        else
        
        end
    end
end