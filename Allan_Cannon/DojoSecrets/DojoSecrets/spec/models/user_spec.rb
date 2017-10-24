require 'rails_helper'

RSpec.describe User, type: :model do
  context "With valid attributes" do
    it "should save the user" do
      expect(build(:user)).to be_valid
    end
    it "should change email to lowercase" do
      expect(create(:user).email).to eq('ac@gmail.com')
    end
    it "should automatically encrypt the password into the password_digest attribute" do
      expect(build(:user).password_digest.present?).to eq(true)
    end
  end
  context "With invalid attributes" do
    it "shouldn't save if first name is blank" do
      expect(build(:user, first_name:"")).to be_invalid
    end
    it "shouldn't save if last name is blank" do
      expect(build(:user, last_name:"")).to be_invalid
    end
    it "shouldn't save if email is blank" do
      expect(build(:user, email:"")).to be_invalid
    end
    it "shouldn't save if password is blank" do
      expect(build(:user, first_name:"")).to be_invalid
    end
    it "shouldn't save if email is invalid" do
      emails = %w[@ user@ @example.com ..@example.com]
      emails.each do |email|
        expect(build(:user, email: email)).to be_invalid
      end
    end
    it "shouldn't save if email is not unique" do
      create(:user)
      expect(build(:user)).to be_invalid
    end
    it "shouldn't save if password does not match confirmation" do
      expect(build(:user, password_confirmation:"notthesame")).to be_invalid
    end
  end
  context 'relationships' do
    before do
      @user = create(:user)
      @secret = create(:secret, content: 'secret 1', user: @user)
      @like = create(:like, secret: @secret, user: @user)
    end
    it 'has secrets' do
      expect(@user.secrets).to include(@secret)
    end
    it 'has likes' do
      expect(@user.likes).to include(@like)
    end
    it "has secrets through likes table" do
      expect(@user.liked).to include(@secret)
    end
  end
end
