class Cli
    def self.start
        puts "Welcome to PokeCLI! Would you like to sign up or sign in?"
        user_login_input = gets.chomp 
        
        if user_login_input == "sign up"
            User.sign_up
            start
        elsif user_login_input == "sign in"
            user = User.sign_in
            if user
                puts "Welcome back #{user.username}!"
                user.welcome

            else 
                puts "Sorry we could not find you. Try signing up first:"
                start
            end    
        else
            puts "Sorry that's not a valid option try again:"
            start
        end
    end
end