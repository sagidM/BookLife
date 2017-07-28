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

    before(:all) { User.where("email = '#{ValidData[:email]}'").destroy_all }

    it('just make self sure that data is valid') { expect(valid_user_with({}).save).to be_truthy }


    context :email do
      it 'invalid' do
        [' ', 'sdagoij.sdf', 'sdago@sdf', 'sd-a@s-df', 'sd-a@s-d s.ru'].each do |invalid_email|
          expect(valid_user_with(email: invalid_email)).to be_invalid
        end
      end

      it 'valid' do
        %w(usupovsky@mail.ru  kofon95@mail.ru
          t.e3-fs_t4@d-sd_2d.hg  12345@6789.0  1.2-3_4.5@6-7_8.9.0).each do |email|

          expect(valid_user_with(email: email).save).to be_truthy
        end
      end

      it 'should make lower case' do
        email = 'SmaLL-or-bIG_values.BookLife@Example.domain.com'
        user = valid_user_with(email: email)
        expect(user.save).to be_truthy
        expect(user.email).to eql email.downcase
      end

      it 'should not allow duplicate considering case sensitive' do
        expect(valid_user_with(email: 'uniq-email@example.com').save).to be_truthy
        expect(valid_user_with(email: 'UniQ-Email@ExamPle.com').save).to be_falsey
      end
    end


    it 'with invalid password' do
      [' ', '123', '123qW'].each do |invalid_password|
        expect(valid_user_with(password: ' ').save).to be_falsey
      end
    end


    context :first_name do
      it 'invalid' do
        expect(valid_user_with(first_name: '').save).to be_falsey
        expect(valid_user_with(first_name: ' '*10).save).to be_falsey
      end
    end


    context :bdate do
      it { expect(valid_user_with(bdate: Date.today+1.second).save).to be_falsey }
    end

  end
end
