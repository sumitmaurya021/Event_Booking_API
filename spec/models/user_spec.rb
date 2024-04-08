require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Sumit', email: 'mauryasumit222@gmail.com', password: 'maurya!154321', phone: '7649876578', account_status: 'active', username: 'sumitmaurya021') }

  describe 'validations' do

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if the phone number is not 10 digits' do
      expect(subject.phone.length).to eq(10)
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'validates presence of password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'validates minumum length of password' do
      subject.password = '12345678'
      expect(subject).to be_valid
    end

    it 'validates maximum length of password' do
      subject.password = '12345678901234567890123456789012'
      expect(subject).to be_valid
    end

    it 'validates within length of password' do
      subject.password = '12345678'
      expect(subject).to be_valid
    end

end

  it 'get all users in index' do
    User.create(name: 'Sam')
    User.create(name: 'Samira')
    User.create(name: 'Samantha')
    expect(User.all).to eq(User.all)
  end

  it 'user can be updated' do
    user = User.new
    user.update(name: 'Sam')
    expect(user.name).to eq('Sam')
  end

  it 'can be created' do
    user = User.new
    user.name = 'Sam'
    user.save
    expect(user.name).to eq('Sam')
  end

  it 'can be edit user' do
    user = User.new
    user.name = 'Sam'
    user.save
    expect(user.name).to eq('Sam')

    user.update(name: 'Samira')
    expect(user.name).to eq('Samira')
  end

  it 'can be delete user' do
    user = User.new
    user.name = 'sam'
    user.save
    expect(user.destroy).to eq(user)
  end
end
