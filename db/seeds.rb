# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

puts 'Creating ingredients...'

ingredient_parameters = []
url_ingredients = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredient_json_file = open(url_ingredients).read
result_ingredients = JSON.parse(ingredient_json_file)

result_ingredients['drinks'].each do |element|
  seed_ingredient = {
    name: element['strIngredient1']
  }
  ingredient_parameters << seed_ingredient
end

ingredients = Ingredient.create(ingredient_parameters)

puts 'Finished ingredients.'

puts 'Creating cocktails...'

cocktail_parameters = []
url_cocktails = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

cocktail_json_file = open(url_cocktails).read
result_cocktails = JSON.parse(cocktail_json_file)

result_cocktails['drinks'].each do |element|
  seed_cocktail = {
    name: element['strDrink'],
    img_url: element['strDrinkThumb']
  }
  cocktail_parameters << seed_cocktail
end

cocktails = Cocktail.create(cocktail_parameters)

puts 'Finished cocktails.'

puts 'Creating doses...'

dose_parameters = []
url_doses = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11007'

dose_json_file = open(url_doses).read
result_doses = JSON.parse(dose_json_file)

result_doses['drinks'].each do |element|
  100.times do
    seed_dose = {
      description: element['strInstructions'],
      cocktail: cocktails.sample,
      ingredient: ingredients.sample
    }
    dose_parameters << seed_dose
  end
end

Dose.create(dose_parameters)

puts 'Finished doses.'



