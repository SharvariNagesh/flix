

describe "Navigating movies" do
  it "allows navigation from the detail page to the listing page" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link "All Movies"

    expect(current_path).to eq(movies_path)
  end

   it "allows navigation from the listing page to the detail page " do
    

    movie = Movie.create(movie_attributes)

    visit movies_url(movie)

    click_link "Iron Man"

    expect(current_path).to eq(movie_path(movie))
  end

  it "Has an edit button, when clicked takes to edit page" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link "Edit"

    expect(current_path).to eq(edit_movie_path(movie))
  end
end
