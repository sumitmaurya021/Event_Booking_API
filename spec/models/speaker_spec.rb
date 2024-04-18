require 'rails_helper'

RSpec.describe Speaker, type: :model do

  subject { Speaker.new(name: 'Sam', bio: 'bio', phone: '7649876578', email: 'mauryasumit222@gmail.com') }

  describe 'validations' do

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is valid with name' do
      subject.name = 'Sam'
      expect(subject).to be_valid
    end

    it 'is valid with bio' do
      subject.bio = 'bio'
      expect(subject).to be_valid
    end

    it 'is valid with phone' do
      subject.phone = '7649876578'
      expect(subject).to be_valid
    end

    it 'is valid with email' do
      subject.email = 'mauryasumit222@gmail.com'
      expect(subject).to be_valid
    end
  end

  describe '#index' do
    it 'get all speakers in index' do
      Speaker.create(name: 'Sam')
      Speaker.create(name: 'Samira')
      Speaker.create(name: 'Samantha')
      expect(Speaker.all).to eq(Speaker.all)
    end
  end

  describe '#create' do
    it 'speaker can be created' do
      speaker = Speaker.new
      speaker.name = 'Sam'
      speaker.save
      expect(speaker.name).to eq('Sam')
    end
  end

  describe '#update' do
    it 'speaker can be updated' do
      speaker = Speaker.new
      speaker.name = 'Sam'
      speaker.save

      speaker.update(name: 'Samira')
      speaker.save
      expect(speaker.name).to eq('Samira')
    end
  end

  describe '#destroy' do
    it 'speaker can be destroyed' do
      speaker = Speaker.new
      speaker.name = 'Sam'
      speaker.save
      speaker.destroy
      expect(Speaker.exists?(speaker.id)).to eq(false)
    end
  end
end
