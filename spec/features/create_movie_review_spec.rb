require 'spec_helper'

describe "Moview review new" do
   it "Allows one to add a new review when Write Review link is clicked" do
    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    review1 = movie1.reviews.new(review_attributes(name: "Sha"))
    review2 = movie1.reviews.new(review_attributes(name:"Stavya"))
    
    if (review1.errors.any?)
      review1.errors.full_messages.each do |message|
          puts message 
        end
      else
        puts "No errors while creating review 1: #{review1.name}"
    end
    visit movie_reviews_path(movie1)
    click_link ('Write Review')
    expect(current_path).to eq(new_movie_review_path(movie1))
    fill_in 'Name', :with=>"Hemanth"
    #fill_in 'Stars', :with=>"2"
    fill_in('Comment', :with=>"This is not a good movie")
    select "2", :from => "Stars"
    
    click_button('Post Review')
    expect(current_path).to eq(movie_reviews_path(movie1))
    expect(page).to have_text("Hemanth")
    expect(page).to have_text("This is not a good movie")
    expect(page).to have_text("Thank you for the Review!")
   end 

  it "does not save the review if it's invalid" do
    movie = Movie.create(movie_attributes)

    visit new_movie_review_path(movie)

    expect {
      click_button 'Post Review'
    }.not_to change(Review, :count)

    expect(page).to have_text('error')
  end

end