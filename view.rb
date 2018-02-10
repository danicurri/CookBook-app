class View


def display_recipes(recipes)
  recipes.each_with_index do |recipe, index|
    puts "#{index + 1}- #{recipe.name}: #{recipe.description}"
  end
end

def ask_for_name_and_description
  attributes = {}
  puts "What is the recipe name?"
  print ">"
  attributes[:name] = gets.chomp
  puts "What is the recipe description"
  print ">"
  attributes[:description] = gets.chomp
  return attributes
end


def ask_for_id_to_destroy
  puts "What recipe id do you want to remove?"
  index = gets.chomp.to_i
  return index
end

def ask_for_ingredient
  puts "What ingredient would you like a recipe for?"
  print ">"
  ingredient = gets.chomp
end

def list_of_recipes(recipes, new_ingredient)
  puts "Looking for #{new_ingredient} on LetsCookFrench...
        10 results found!"
  recipes.each_with_index do |recipe, index|
  puts "#{index + 1} - #{recipe.name}: #{recipe.description}"
  end
end

def ask_for_index_to_import
  puts "Please type a number to choose which recipe to import"
  print ">"
  number = gets.chomp.to_i
  puts "Importing #{number}..."
end


end
