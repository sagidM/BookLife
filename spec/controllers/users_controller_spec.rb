require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

  describe '#find' do
    before do
      @user_hash = {'email' => 'method_find@example.com', 'password' => '123qwe', 'first_name' => 'q', 'surname' => 'w'}
    end
    let!(:user) { User.create! @user_hash }
    it do
      visit users_find_path user: {email: 'method_find@example.com'}
      json = JSON.parse(page.body)
      equal = ->(a, b, key) {a[key] == b[key]}
      expect(equal.call(@user_hash, json, 'email')).to be_truthy
      expect(equal.call(@user_hash, json, 'first_name')).to be_truthy
      expect(equal.call(@user_hash, json, 'surname')).to be_truthy
    end
  end

  describe 'signing in' do
    let(:user) {FactoryGirl.create(:user)}
    subject {user}

    describe 'success user' do
      before do
        visit root_path
        find('#open_auth_form').click
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_button 'signing'
      end
      # TODO: allow js and uncomment this one
      # it {is_expected.to eq current_user}
    end
  end
end
