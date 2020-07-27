class User < ActiveRecord::Base
    has_many :pokemon
    def self.sign_up
        puts "Please enter a username:"
        username = gets.chomp 
        puts "Please enter a password:"
        password = gets.chomp
        puts "Please enter any gender:"
        gender = gets.chomp
        puts "Please enter your trainer name:"
        trainer_name = gets.chomp
        user = User.create(username: username, password: password, gender: gender, trainer_name: trainer_name)
        user.save
    end
    
    def self.sign_in
        puts "Please enter your username:"
        username = gets.chomp
        puts "Please enter your password:"
        password = gets.chomp
        User.all.find_by(username: username, password: password)
    end

    def welcome
        puts "Do you want to go catch pokemon? Type 1. If you want to look at your PC, type 2"
        user_decision = gets.chomp
        if user_decision == 1

            self.catch_pokemon


        elsif user_decision == 2

            self.pc_loadup
        

        else

            

        end
    end


    def pc_loadup

        puts self.pokemons 

    end
end
