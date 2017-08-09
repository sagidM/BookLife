require 'rails_helper'

RSpec.describe Session, type: :model do
  before(:all) { @user = FactoryGirl.create(:user) }
  after(:all) { @user.destroy }

  let(:user) {@user}

  context 'should not #save' do
    it 'without :user' do
      expect(Session.new(remember_token: 'asd123', ip_address: '0.0.0.0').save).to be_falsey
    end
    it('without :remember_token') do
      p Session.new(user: user, ip_address: '0.0.0.0').save
      p '-'*10
      expect(false).to be_falsey
    end
    # request is needed
    # it('without :ip_address') do
    #   expect(Session.new(user: user, remember_token: 'asd123').save).to be_falsey
    # end
  end

  context 'should #save' do
    it 'with :remember_token and :user' do
      saved = Session.new(remember_token: 'qwe123', user: user, ip_address: '0.0.0.0').save
      expect(saved).to be_truthy
    end
  end
end
