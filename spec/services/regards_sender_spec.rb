require 'rails_helper'

RSpec.describe RegardsSender do
  let(:service) { RegardsSender.new(sender_user, target_id) }

  context 'sender user exist' do
    let(:sender_user) { User.create(email: 'user@rspec.com', password: 'rspec12', gender: 'female', age: 11) }

    context 'target user exist' do
      let(:target) { User.create(email: 'user@rails.com', password: 'rspec12', gender: 'female', age: 11) }
      let(:target_id) { target.id }

      it 'is successful' do
        expect(service.execute).to be true
      end

      it 'sends an email to target' do
        expect { service.execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'target user does not exist' do
      before(:each) { ensure_user_42_does_not_exist }
      let(:target_id) { 42 }

      it 'is not successful' do
        expect(service.execute).to be false
      end

      it 'does not send email to target' do
        expect { service.execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end

  context 'sender and target does not exist' do
    before(:each) { ensure_user_42_does_not_exist }
    let(:sender_user) { nil }
    let(:target_id) { 42 }

    it 'is not successful' do
      expect(service.execute).to be false
    end

    it 'does not send email to target' do
      expect { service.execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end
end

def ensure_user_42_does_not_exist
  user = User.find_by(id: 42)
  user.destroy if user.present?
end
