# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { FactoryBot.build(:group) }

  it 'is valid with all attributes' do
    expect(group).to be_valid
  end

  it 'is invalid without a hashtag' do
    group.hashtag = nil
    group.valid?
    expect(group.errors[:hashtag]).to include("can't be blank")
  end

  it 'is invalid without a name' do
    group.name = nil
    group.valid?
    expect(group.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a details' do
    group.details = nil
    group.valid?
    expect(group.errors[:details]).to include("can't be blank")
  end

  it 'is invalid without a capacity' do
    group.capacity = nil
    group.valid?
    expect(group.errors[:capacity]).to include("can't be blank")
  end

  it 'is invalid without a location' do
    group.location = nil
    group.valid?
    expect(group.errors[:location]).to include("can't be blank")
  end

  it 'is invalid without a payment_method' do
    group.payment_method = nil
    group.valid?
    expect(group.errors[:payment_method]).to include("can't be blank")
  end

  it 'is invalid with capacity as string' do
    group.capacity = 'invalid'
    group.valid?
    expect(group.errors[:capacity]).to include('is not a number')
  end

  it 'is invalid with float capacity' do
    group.capacity = 3.5
    group.valid?
    expect(group.errors[:capacity]).to include('must be an integer')
  end

  it 'is invalid with zero capacity' do
    group.capacity = 0
    group.valid?
    expect(group.errors[:capacity]).to include('must be greater than 0')
  end

  it 'is invalid with negative capacity' do
    group.capacity = -5
    group.valid?
    expect(group.errors[:capacity]).to include('must be greater than 0')
  end
end
