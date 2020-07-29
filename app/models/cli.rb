
class Cli
    def self.start
        prompt = TTY::Prompt.new
        user_login_input = prompt.select("Welcome to Poké Safari!", %w(sign-up sign-in))
        #user_login_input = gets.chomp.strip 
        
        if user_login_input == "sign-up"
            User.sign_up
            start
        elsif user_login_input == "sign-in"
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