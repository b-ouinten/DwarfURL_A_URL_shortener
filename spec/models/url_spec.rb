require 'rails_helper'

RSpec.describe Url, type: :model do
  before :each do
    @url = FactoryBot.create(:url)
  end

  context "validations" do
    it "is valid with valid attibutes" do
      expect(@url).to be_a(Url)
      expect(@url).to be_valid
    end

    describe "" do

    end
  end

end