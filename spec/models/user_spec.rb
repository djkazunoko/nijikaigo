require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with all attributes' do
    expect(user).to be_valid
  end

  it 'is invalid without a provider' do
    user.provider = nil
    user.valid?
    expect(user.errors[:provider]).to include('を入力してください')
  end

  it 'is invalid without a uid' do
    user.uid = nil
    user.valid?
    expect(user.errors[:uid]).to include('を入力してください')
  end

  it 'is invalid without a name' do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without an image_url' do
    user.image_url = nil
    user.valid?
    expect(user.errors[:image_url]).to include('を入力してください')
  end

  it 'is invalid with a duplicate name' do
    FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, image_url: 'example.com/2', provider: 'twitter', uid: '0002')
    user2.valid?
    expect(user2.errors[:name]).to include('はすでに存在します')
  end

  it 'is invalid with a duplicate image_url' do
    FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, name: 'tester2', provider: 'twitter', uid: '0002')
    user2.valid?
    expect(user2.errors[:image_url]).to include('はすでに存在します')
  end

  it 'is invalid with a duplicate uid and provider pair' do
    FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, name: 'tester2', image_url: 'example.com/2')
    user2.valid?
    expect(user2.errors[:uid]).to include('はすでに存在します')
  end

  it 'allows duplicate uid with different provider' do
    FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, name: 'tester2', image_url: 'example.com/2', provider: 'twitter')
    expect(user2).to be_valid
  end
end
