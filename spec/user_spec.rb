require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'requires a name' do
      user = User.new(posts_counter: 5) 
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires posts_counter to be greater than or equal to zero' do
      user = User.new(name: 'Juan', posts_counter: -1)
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include("must be greater than or equal to 0")
    end

    it 'allows valid users' do
      user = User.new(name: 'Alicia', posts_counter: 3)
      expect(user).to be_valid
    end
  end
end
