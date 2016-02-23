class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
    

	validates :title, :description, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	# validates :image_url, allow_blank: true, format: {
	# with: 	%r{\.(gif|jpg|png)\Z}i,
	# 	message: 'must be a URL for GIF, JPG or PNG image.'
	# }

	has_attached_file :upload_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :upload_image, content_type: /\Aimage\/.*\Z/
	def self.latest
		Product.order(:updated_at).last
	end

	private
	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			
		else
			errors.add(:base, 'Line Items present')
			return false
		end
		
	end

	 attr_accessor :upload
	  def self.save(upload)
	    name = upload['datafile'].original_filename
	    directory = 'public/data'
	    # create the file path
	    path = File.join(directory,name)
	    # write the file
	    File.open(path, "wp") { |f| f.write(upload['datafile'].read)}
	  end



end
