require 'spec_helper'

describe "New Movie Create" do

  it "A new movie entry can be created by clicking on the 'create Movie' link " do 
     movie = Movie.create(movie_attributes)

    visit movies_url(movie)

    click_link 'Add New Movie'

    expect(current_path).to eq(new_movie_path)

    fill_in 'Title', with: "Rangi Taranga"
    fill_in 'Description', with: "Rangi Taranga is a kannada movie which was a box office hit. It is made by amateure directors"
    select "PG-13", :from => "movie_rating" # 'Rating', with: "G"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"

    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
    #fill_in 'released_on', with: 
    fill_in 'Total gross', with: "99999999999"
    click_button 'Create Movie'
    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text('Rangi Taranga')
    expect(page).to have_text('Movie successfully created!')
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url
  
    expect { 
      click_button 'Create Movie' 
      }.not_to change(Movie, :count)
  
     expect(current_path).to eq(movies_path)   
     expect(page).to have_text('error')
    end

end