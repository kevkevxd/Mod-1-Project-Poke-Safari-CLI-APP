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
         end
    end

    def catch_pokemon
        puts "Please enter the Pokemon you want:"
        pokemon_name = gets.chomp
        species = Species.all.find_by(name: pokemon_name)
        if species
            puts "Please enter a nickname for your pokemon"
            nickname = gets.chomp
            Pokemon.create(nickname: nickname, user_id: self.id, species_id: species.id)
            self.welcome
        else 
            puts "DUdE that's NOT a pokemon"
            self.catch_pokemon
        end
    end
end
