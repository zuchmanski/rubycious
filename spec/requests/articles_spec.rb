require 'spec_helper'

describe "Article" do
  describe "posting" do
    it "should allow user to post articles" do
      sign_in_user

      ['/', '/new'].each do |path|
        visit path
        page.should_not have_content("Marshmallow")
        page.should_not have_content("Jelly")
      end

      visit new_article_path
      fill_in "Title", :with => "Marshmallow jujubes gummies dessert croissant halvah."
      fill_in "Url", :with => "http://rubycious.com"
      fill_in "Body", :with => "Jelly fruitcake sweet roll croissant bear claw cotton candy danish icing. Sweet roll icing brownie oat cake."
      click_button "Submit"

      page.current_url.should == "http://www.example.com/new"
      page.should have_content("Article was successfully submited")
      page.should have_content("Marshmallow")
      page.should have_content("Jelly")
    end
  end

  describe "verifing" do
    before(:each) do
      3.times do
        FactoryGirl.create(:article)
      end
    end

    it "should allow admin to verify articles" do
      sign_in_admin

      visit '/'
      page.should_not have_css("li.article")

      visit '/new'
      all("li.article").size.should == 3

      click_link('verify')
      click_link('verify')

      visit '/'
      all("li.article").size.should == 2

      visit '/new'
      all("li.article").size.should == 1
    end

    it "should not allow user to verify post" do
      sign_in_user

      visit '/new'
      page.should_not have_css('a.verify')
      put verify_article_path(Article.first)

      visit '/new'
      all("li.article").size.should == 3

      visit '/'
      all("li.article").size.should == 0
    end
  end

  describe "deleting" do
    before(:each) do
      2.times do
        FactoryGirl.create(:article)
        FactoryGirl.create(:article, :verified => true)
      end
    end

    it "should allow admin to delete articles" do
      sign_in_admin

      visit '/new'
      click_link('delete')
      click_link('delete')
      all("li.article").size.should == 0

      visit '/'
      click_link('delete')
      all("li.article").size.should == 1
    end

    it "should not allow user to delete articles" do
      sign_in_user

      visit '/new'
      page.should_not have_css('a.delete')
      delete article_path(Article.first)
      all("li.article").size.should == 2

      visit '/'
      page.should_not have_css('a.delete')
      delete article_path(Article.last)
      all("li.article").size.should == 2
    end
  end
end
