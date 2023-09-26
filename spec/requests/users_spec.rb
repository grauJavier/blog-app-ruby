require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'displays the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('<h1>All users</h1>')
      expect(response.body).to include('<h2>User name</h2>')
      expect(response.body).to include('<span>Number of posts:</span>')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { instance_double(User, name: 'Javier Grau') }

    before do
      allow(User).to receive(:find).and_return(user)
    end

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'displays the correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('<h2>User name</h2>')
    end
  end
end
