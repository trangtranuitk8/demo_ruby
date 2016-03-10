class Category < ActiveRecord::Base
	has_and_belongs_to_many :products
	

	def self.search_category(var_categories)  	
    	Product.joins(:categories).where("categories.id = ?", "#{var_categories}")
  	end
end
