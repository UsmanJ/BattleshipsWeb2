require 'spec_helper'

feature 'Starting new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link "New Game"
    expect(page).to have_content "What's your name?"
  end

  scenario 'I am asked if I am ready to play battleships' do
    visit '/new_game'
    fill_in('name', with: "Philip")
    click_button 'Submit'
    expect(page).to have_content "Hello Philip! Welcome to your game of Battleships!"
  end
end
