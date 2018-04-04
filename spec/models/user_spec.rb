require 'rails_helper'

describe User, type: :model do
 fixtures :users
 subject { users(:two) }

 describe 'Validations' do
   describe '#username' do
     it 'is invalid when blank' do
       subject.username = ' ' * 6
       expect(subject).to_not be_valid
     end

     it 'is invalid when shorter than 3 characters' do
       subject.username = 'a' * 2
       expect(subject).to_not be_valid
     end

     it 'is invalid when longer than 50 characters' do
       subject.username = 'a' * 51
       expect(subject).to_not be_valid
     end

     it 'is valid with proper data' do
       expect(users(:one)).to be_valid
     end
   end

   describe '#email' do
    it 'is invalid when blank' do
      subject.email = ' ' * 6
      expect(subject).to_not be_valid
    end

    it 'is invalid when longer than 256 characters' do
      subject.email = 'a' * 244 + '@example.com'
      expect(subject).to_not be_valid
    end

    it 'is valid with proper data' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
      end
    end

    it 'is invalid with improper data' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        subject.email = invalid_address
        expect(subject).to_not be_valid
      end
    end

    it 'is invalid when not unique' do 
      duplicate_user = subject.dup
      duplicate_user.email = subject.email.upcase
      subject.save
      expect(duplicate_user).to_not be_valid
    end
   end
 end
end
