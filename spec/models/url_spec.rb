require 'rails_helper'

RSpec.describe Url, type: :model do
  before :each do
    @user = FactoryBot.create(:user)
    @url = FactoryBot.create(:url)
  end

  context "associations" do
    
    describe "url" do
      it "should belongs_to user" do
        url = FactoryBot.create(:url, user: @user)
        expect(url.user).to eq @user
      end
    end
    
    describe "urls" do
      it "should have_many urls" do
        @user.urls << @url 
        expect(@user.urls.include? @url).to eq true
      end
    end
  end
  
  context "validations" do
    it "is valid with valid attibutes" do
      expect(@url).to be_a Url
      expect(@url).to be_valid
    end
    
    describe "link" do
      it "should not be blank" do
        invalid_url = FactoryBot.build(:url, :without_link)
        expect(invalid_url).not_to be_valid
        expect(invalid_url.errors.include? :link).to eq true
        expect(invalid_url.errors.messages[:link].join.include? 'blank').to eq true
      end

      it "should not be already exist" do
        url = FactoryBot.create(:url, link: 'my_link')
        invalid_url = FactoryBot.build(:url, link: 'my_link')
        expect(invalid_url).not_to be_valid
        expect(invalid_url.errors.include? :link).to eq true
        expect(invalid_url.errors.messages[:link].join.include? 'exist').to eq true
      end
    end

    describe "alias" do
      it "should not be already exist" do
        url = FactoryBot.create(:url, _alias: ' my alias ')
        invalid_url = FactoryBot.build(:url, _alias: 'my-alias')
        expect(invalid_url).not_to be_valid
        expect(invalid_url.errors.include? :_alias).to eq true
        expect(invalid_url.errors.messages[:_alias].join.include? 'exist').to eq true
      end
    end

    context "callbacks" do
      describe "handle_alias" do
        it "should set alias if it doesn't defined" do
          url = FactoryBot.create(:url, :without_alias)
          expect(url._alias.empty?).to eq false
          expect(url._alias.match? /\s+/).to eq false
        end

        it "should normalize alias" do
          url = FactoryBot.create(:url, _alias: '  my  alias ')
          expect(url._alias).to eq 'my-alias'
        end

        it "should run before validation" do
          url = FactoryBot.create(:url, _alias: 'my-alias')
          invalid_url = FactoryBot.build(:url, _alias: 'my alias ')
          expect(invalid_url).not_to be_valid
        end
      end
    end
  end
end
