# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    described_class.new(
      email: "test@example.com",
      password: "password123"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      described_class.create!(
        email: "test@example.com",
        password: "password123"
      )
      expect(user).not_to be_valid
    end

    it "is not valid with an invalid email format" do
      user.email = "invalid_email"
      expect(user).not_to be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "is not valid with a short password" do
      user.password = "short"
      expect(user).not_to be_valid
    end

    it "is not valid with a long password" do
      user.password = "a" * 21
      expect(user).not_to be_valid
    end

    it "is valid with a password of valid length" do
      user.password = "validLength1"
      expect(user).to be_valid
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:movies).dependent(:destroy) }
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe "Devise modules" do
    it { is_expected.to respond_to(:valid_password?) }
    it { is_expected.to respond_to(:send_reset_password_instructions) }
  end
end
