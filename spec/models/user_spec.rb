require 'rails_helper'

RSpec.describe User, type: :model do
  context 'following objects should respond' do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :password_digest }
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :surname }
    it { is_expected.to respond_to :bdate }
    it { is_expected.to respond_to :avatar }
  end

  describe '#save' do

    it('with empty data') { expect(User.new.invalid?).to be_truthy }

    ValidData = {email: 'test@example.com', password: '123qwe', first_name: 'ivan'}
    
    def valid_user_with(options)
      User.new ValidData.merge options
    end

    before :all { User.where("email = '#{ValidData[:email]}'").destroy_all }

    it('make sure that data is valid') { expect(valid_user_with({}).save).to be_truthy }


    it { expect(valid_user_with(email: ' ').save).to be_falsey }
    it { expect(valid_user_with(email: 'sdagoij.sdf').save).to be_falsey }
    it { expect(valid_user_with(email: 'sdago@sdf').save).to be_falsey }
    it { expect(valid_user_with(email: 'sd-a@s-df').save).to be_falsey }
    it { expect(valid_user_with(email: 'sd-a@s-d s.ru').save).to be_falsey }

    it { expect(valid_user_with(password: ' ').save).to be_falsey }
    it { expect(valid_user_with(password: '123').save).to be_falsey }
    it { expect(valid_user_with(password: '123qW').save).to be_falsey }

    it { expect(valid_user_with(first_name: '').save).to be_falsey }
    it { expect(valid_user_with(first_name: ' '*10).save).to be_falsey }

    it { expect(valid_user_with(bdate: Date.today+1.second).save).to be_falsey }

    it { expect(valid_user_with(email: 'te3-fs_t4@d-sd_2d.hg').save).to be_truthy }


    it 'should make lower case' do
      email = 'SmaLL@Example.com'
      user = valid_user_with(email: email)
      expect(user.save).to be_truthy
      expect(user.email).to eql email.downcase
    end

    it 'should not allow dublicate considering case sensitive' do
      expect(valid_user_with(email: 'uniq-email@example.com').save).to be_truthy
      expect(valid_user_with(email: 'UniQ-Email@ExamPle.com').save).to be_falsey
    end
  end
end
