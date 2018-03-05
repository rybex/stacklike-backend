require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let(:oauth_hash) {
    {
      provider: "google_oauth2",
      uid: "101757300074534447307",
      info: {
        name: "Tomek Rybczyński",
        email: "tomek.rybka@gmail.com",
        first_name: "Tomek",
        last_name: "Rybczyński",
        image: "https://lh3.googleusercontent.com/-WD6qXCLYqZA/AAAAAAAAAAI/AAAAAAAAAfc/WVamRb4pGdk/photo.jpg",
        urls: {
          google: "https://plus.google.com/101757300074534447307"
        }
      },
      credentials: {
        token: "test-token",
        refresh_token: "12345abcdefg",
        expires_at: 1520241957,
        expires: true
      }
    }
  }

  it 'should handle google callback params and create new user and session' do
    stub_omniauth
    expected_user = {
      'name' => oauth_hash[:info][:name],
      'email' => oauth_hash[:info][:email],
      'image' => oauth_hash[:info][:image]
    }

    get '/auth/google_oauth2/callback'

    expect(response.status).to eq 302

    get '/me'

    expect(response.status).to           eq 200
    expect(response.content_type).to     eq 'application/json'
    expect(JSON.parse(response.body)).to eq expected_user
  end

  private

  def stub_omniauth
    OmniAuth.config.test_mode                     = true
    OmniAuth.config.mock_auth[:google_oauth2]     = OmniAuth::AuthHash.new(oauth_hash)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
end
