require_relative "cookbook"
require_relative "view"
require_relative "recipe"
require "open-uri"
require "nokogiri"

class Controller
  def initialize(cookbook)
    @cookbook  = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    attributes = @view.ask_for_name_and_description
    recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    id = @view.ask_for_id_to_destroy
    @cookbook.remove_recipe(id - 1)
  end

  def search_for_ingredient
      new_ingredient = @view.ask_for_ingredient
      url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{new_ingredient}&type=all"
      doc = Nokogiri::HTML(open(url), nil, 'utf-8')
      recipe_titles = doc.xpath("//div[@class='m_titre_resultat']/a")
      recipe_descriptions = doc.xpath("//div[@class='m_texte_resultat']")
      titles = []
      recipe_titles.each do |object|
        title = object.text
        titles << title
      end
          descriptions = []
    recipe_descriptions.each do |object|
      description = object.text.strip
      descriptions << description
    end
       recipes = []
    for i in (0..titles.length) do
      recipe = Recipe.new(titles[i], descriptions[i])
      recipes << recipe
    end
    @view.list_of_recipes(recipes, new_ingredient)
    number = @view.ask_for_index_to_import
    @cookbook.add_recipe(recipes[number.to_i - 1])
  end

end
