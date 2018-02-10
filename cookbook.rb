require_relative "recipe"
require "csv"

class Cookbook#this is our fake DB, our repository
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id.to_i)
    save_to_csv
  end

    private

  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |recipe|
        csv.puts([recipe.name, recipe.description])
      end
    end
  end

  def load_csv
    return unless File.exist?(@csv_file)

    CSV.foreach(@csv_file) do |row|
      attributes = {
        name: row[0],
        description: row[1]
      }
      @recipes << Recipe.new(attributes)
    end
  end
end

