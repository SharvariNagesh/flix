class Movie < ActiveRecord::Base
    has_many :reviews, dependent: :destroy

	validates :title, :released_on, :duration, presence:true

	validates :description, length: {minimum:25}

	validates :total_gross,  numericality: { greater_than_or_equal_to: 0 }

	validates :image_file_name, allow_blank:true, format: {
		with: /\w+\.(gif|jpg||png)\z/i,
		message: "Must enter a proper gif, jpg or png files"
	}

	RATINGS = %w(G PG PG-13 R NC-17)
	validates :rating, allow_blank:true, inclusion:{ in: RATINGS}
			
	def flop?
		#total_gross < 5000 || total_gross.blank || reviews.count > 50 || average_stars >= 3 ?
		#total_gross < 50000 ?
		false
	end

	def self.released
		where('released_on < ?', 15.days.from_now).order('released_on desc')
	end

	def self.hitMovies
		where('total_gross >= ?', 50000)
	end

	def self.recentlyCreated
		order('created_at desc').limit(3)
	end

	def average_stars
	  reviews.average(:stars)
	end

	def has_reviews?
	  !reviews.count.zero?
	end
end