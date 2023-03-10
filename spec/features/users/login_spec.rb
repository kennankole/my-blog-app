# require 'rails_helper'

# describe "the signin process", type: :feature do
#   before :each do
#     User.create(email: 'me@example.com', name: "ankole", password: "qwerty")
#   end

#   it "signs me in" do
#     visit "users/sign_in"
#     fill_in "Email", with: "me@example.com"
#     fill_in "Password", with: "qwerty"
#     fill_in "Username", with: "ankole"
#     click_button "Log in"
#     expect(current_path).to eq(root_path)
#     expect(page).to have_text('Signed in successfully.')
#   end
# end
