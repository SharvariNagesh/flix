
require 'spec_helper'

describe "Viewing a list of reviews" do
	
  it "displays reviews for the movie when review link is clicked" do

    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    review1 = movie1.reviews.new(review_attributes(name: "Sha"))
    review2 = movie1.reviews.new(review_attributes(name:"Stavya"))
    review1.save
    review2.save
    if (review1.errors.any?)
      review1.errors.full_messages.each do |message|
          puts message 
        end
      else
        puts "No errors while creating review 1: #{review1.name}"
    end
    visit movie_reviews_path(movie1)
  	expect(page).to have_text(review1.name)
  #	expect(page).not_to have_text(review4.title)

  #	visit movie_reviews_path(movie2)
  #	expect(page).to have_text(review4.name)
  #	expect(page).not_to have_text(review2.name)
  end

end