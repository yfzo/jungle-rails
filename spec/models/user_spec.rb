require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'validates presence of password and password confirmation' do
      @user = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      expect(@user).to be_valid
    end

    it 'invalidates new user without matching passwords' do
      @user = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'qasdas'})
      @user.valid?
      @user.errors.should have_key(:password_confirmation)
    end

    it 'invalidates new user without password' do
      @user = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password_confirmation: 'asdfgh'})
      @user.valid?
      @user.errors.should have_key(:password)
    end

    it 'invalidates new user without password confirmation' do
      @user = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh'})
      @user.valid?
      @user.errors.should have_key(:password_confirmation)
    end

    it 'invalidates same email' do
      @user1 = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      @user2 = User.create({first_name: 'Julie', last_name: 'Smith', email: 'j@s.com', password: 'qwerty', password_confirmation: 'qwerty'})
      @user2.valid?
      @user2.errors.should have_key(:email)
    end

    it 'invalidates same email case insensitive' do
      @user1 = User.create({first_name: 'Jill', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      @user2 = User.create({first_name: 'Julie', last_name: 'Smith', email: 'J@S.com', password: 'qwerty', password_confirmation: 'qwerty'})
      @user2.valid?
      @user2.errors.should have_key(:email)
    end

    it 'invalidates new user without first name' do
      @user = User.create({first_name: '', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      @user.valid?
      @user.errors.should have_key(:first_name)
    end

    it 'invalidates new user without last name' do
      @user = User.create({first_name: 'Janice', last_name: '', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      @user.valid?
      @user.errors.should have_key(:last_name)
    end

    it 'invalidates new user without email' do
      @user = User.create({first_name: 'Jen', last_name: 'Smith', email: '', password: 'asdfgh', password_confirmation: 'asdfgh'})
      @user.valid?
      @user.errors.should have_key(:email)
    end

    it 'invalidates password shorter than 6 characters' do
      @user = User.create({first_name: 'Jen', last_name: 'Smith', email: 'j@s.com', password: 'asd', password_confirmation: 'asd'})
      @user.valid?
      @user.errors.should have_key(:password)
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should require correct password and existing email' do
      @user = User.create({first_name: 'Jen', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      expect(User.authenticate_with_credentials('j@s.com', 'asdfgh')).to eq(@user)
    end

    it 'should require correct password' do
      @user = User.create({first_name: 'Jen', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      expect(User.authenticate_with_credentials('j@s.com', '123456')).to be_nil
    end

    it 'should require existing email' do
      @user = User.create({first_name: 'Jen', last_name: 'Smith', email: 'j@s.com', password: 'asdfgh', password_confirmation: 'asdfgh'})
      expect(User.authenticate_with_credentials('jen@smith.com', 'asdfgh')).to be_nil
    end
  end

end
