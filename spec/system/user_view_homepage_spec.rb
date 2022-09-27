require 'rails_helper'

describe 'user visits root path' do
  it 'and sees the page title' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).to have_content 'Transporte & Frete'
  end
end
