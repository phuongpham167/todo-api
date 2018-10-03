require "rails_helper"

RSpec.describe Todo, type: :model do
  context "association" do
    it {is_expected.to have_many(:items).dependent :destroy}
  end

  context "validation" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_presence_of :created_by}
  end
end
