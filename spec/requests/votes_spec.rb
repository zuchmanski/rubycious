require 'spec_helper'

describe "Vote" do
  before(:each) do
    2.times do
      FactoryGirl.create(:article)
      FactoryGirl.create(:article, :verified => true)
    end
  end

  it "should allow user to vote" do
    sign_in_user

    ['/new', '/'].each do |path|
      visit path
      all("li.article .points").first.text.should == '0'
      all("li.article .points").last.text.should == '0'
      all("li.article .points").first.click

      visit path
      all("li.article .points").first.text.should == '1'
      all("li.article .points").last.text.should == '0'
    end
  end

  it "should not allow guest to vote" do
    ['/new', '/'].each do |path|
      visit path
      all("li.article .points").first.text.should == '0'
      all("li.article .points").last.text.should == '0'
      all("li.article .points").first.click

      visit path
      all("li.article .points").first.text.should == '0'
      all("li.article .points").last.text.should == '0'
    end
  end

  it "should not allow user to multiply vote" do
    sign_in_user

    {'/' => Article.verified, '/new' => Article.unverified}.each do |path, model|
      visit path
      all("li.article .points").first.text.should == '0'
      all("li.article .points").last.text.should == '0'

      page.driver.post points_path(:article_id => model.first.id)
      page.driver.post points_path(:article_id => model.first.id)

      visit path
      all("li.article .points").first.text.should == '1'
      all("li.article .points").last.text.should == '0'
    end
  end
end