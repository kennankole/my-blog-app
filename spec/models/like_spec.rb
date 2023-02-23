require "rails_helper"

RSpec.describe Like, type: :model do
  describe 'validataion' do
    it { should belong_to(:post).class_name('Post') }
    it { should belong_to(:user).class_name('User') }
  end
end