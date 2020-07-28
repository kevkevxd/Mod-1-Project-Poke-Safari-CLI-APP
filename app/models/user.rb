class User < ActiveRecord::Base
    has_many :pokemons
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
        if user_decision == "1"

            self.catch_pokemon


        elsif user_decision == "2"

            self.pc_loadup
        

        else

            

        end
    end

    def pc_loadup
         pokemon = self.pokemons 
         pokemon.each do |pokemon|
            puts pokemon.nickname 
            puts pokemon.species.name
            puts "Type(s): #{pokemon.species.type.type_one} #{pokemon.species.type.type_two}"
         end
        puts 'Would you like to release a pokemon or go back to the menu? Enter release or exit:'
        user_response = gets.chomp.downcase 
        if user_response == 'release'
            puts "Which pokemon would you like to release? Enter their nickname:"
            user_nickname = gets.chomp
            self.pokemons.find_by(nickname: user_nickname).destroy
            self.welcome
        elsif user_response == 'exit'
            self.welcome 
        else
            puts "Not a valid input try again."
            self.pc_loadup   
        end 
        
    end

    def catch_pokemon
        puts "Please enter the Pokemon you want to catch:"
        pokemon_name = gets.chomp.downcase
        species = Species.all.find_by(name: pokemon_name)
        if species
            puts "You encounter a wild #{species.name}. Would you like to catch it or run away? Enter 'catch' or 'run': "
            catch_or_run = gets.chomp

            if catch_or_run == 'catch'
                random_number = rand(1..2).to_s
                puts "Please enter a number between 1 and 2:"
                 user_number = gets.chomp

                if random_number == user_number
                    puts "Congratulations! You caught a #{species.name} " #wanted to create a new method but needed to grab species name
                    puts "Please enter a nickname for your pokemon:"
                    nickname = gets.chomp
                    Pokemon.create(nickname: nickname, user_id: self.id, species_id: species.id)
                    self.welcome
                else
                    puts "Darn! The #{species.name} has escaped."
                    self.welcome 
                end                
                
            elsif catch_or_run == 'run'
                puts "You escaped!"
                self.welcome
            else 
                puts "That's not a valid action please try again"
                self.catch_pokemon
            end

        else 
            puts "That's not a Pokemon please try again"
            self.catch_pokemon
        end
    end

    # def catch 
    #     random_number = rand(1..4).to_s
    #     puts "Please enter a number between 1 and 4:"
    #     user_number = gets.chomp
    #     if random_number == user_number
    #         puts "Congratulations! You caught a #{species.name} "
    #         puts "Please enter a nickname for your pokemon:"
    #         nickname = gets.chomp
    #         Pokemon.create(nickname: nickname, user_id: self.id, species_id: species.id)
    #     else

    #     end
    # end
end
