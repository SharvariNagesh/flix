
describe "Delete a Movie" do 
	it "has a delete link, when clicked deletes the movie" do
		movie = Movie.create(movie_attributes)
		visit movie_path(movie)

    	click_link 'Delete'
    	expect(current_path).to eq(movies_path)
    	expect(page).not_to have_text(movie.title)
    	expect(page).to have_text('Movie successfully deleted!')
	end
end