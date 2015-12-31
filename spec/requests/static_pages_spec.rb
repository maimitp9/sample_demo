require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample Demo'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample Demo')
    end
  end
end
