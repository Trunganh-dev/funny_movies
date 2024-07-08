# frozen_string_literal: true

# spec/channels/notification_channel_spec.rb
require 'rails_helper'

RSpec.describe NotificationChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
  end

  it "successfully subscribes" do
    subscribe
    expect(subscription).to be_confirmed
  end

  it "streams from 'notification_channel'" do
    subscribe
    expect(subscription).to have_stream_from('notification_channel')
  end

  it "broadcasts a message to 'notification_channel'" do
    subscribe

    expect {
      ActionCable.server.broadcast('notification_channel', { message: 'Test message' })
    }.to have_broadcasted_to('notification_channel').with(message: 'Test message')
  end
end
