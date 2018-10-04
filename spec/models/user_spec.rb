require "rails_helper"

RSpec.describe User, type: :model do
  context "association" do
    it {is_expected.to have_many :todos}
  end

  context "validation" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_presence_of :password_digest}
  end
end
