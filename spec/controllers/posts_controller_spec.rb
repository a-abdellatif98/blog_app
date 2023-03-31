require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let!(:posts) { create_list(:post, 3) }
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let!(:post) { create(:post) }

    it 'returns a successful response' do
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:post) }
    let(:invalid_attributes) { attributes_for(:post, title: '') }

    
    context 'with valid attributes' do
      it 'creates a new post' do
        expect do
          post :create, params: { post: valid_attributes }
        end.to change(Post, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        expect do
          post :create, params: { post: invalid_attributes }
        end.to_not change(Post, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:post) { create(:post) }
    let(:valid_attributes) { attributes_for(:post, title: 'New Title') }
    let(:invalid_attributes) { attributes_for(:post, title: '') }

    context 'with valid attributes' do
      it 'updates the post' do
        put :update, params: { id: post.id, post: valid_attributes }
        expect(post.reload.title).to eq('New Title')
        expect(response).to be_successful
      end
    end

    context 'with invalid attributes' do
      it 'does not update the post' do
        put :update, params: { id: post.id, post: invalid_attributes }
        expect(post.reload.title).to_not eq('')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }

    it 'destroys the post' do
      expect do
        delete :destroy, params: { id: post.id }
      end.to change(Post, :count).by(-1)
    end

    it 'returns a 204 no content http status code' do
      delete :destroy, params: { id: post.id }
      expect(response).to have_http_status(204)
    end
  end
end
