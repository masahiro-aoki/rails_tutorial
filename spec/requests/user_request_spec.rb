require 'rails_helper'

RSpec.describe 'User edit', type: :request do
  let(:user) { create :user }
  let(:other_user) { create :user, name: 'other user', email: 'other@example.com' }

  context 'ログイン時' do
    describe 'GET /index' do
      it 'ログイン画面が表示されること' do
        login user
        get users_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit' do
      context '認可されているユーザー' do
        it 'edit画面が表示されること' do
          login user
          get edit_user_path(user)
          expect(response).to have_http_status(:success)
        end
      end
      context '認可されていないユーザー' do
        it 'ルート画面にリダイレクトされること' do
          login other_user
          get edit_user_path user
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'PATCH /update' do
      context '認可されているユーザー' do
        it 'データが更新されること' do
          login user
          patch user_path(user), params: { user: { name: user.name, email: user.email } }
          expect(response).to redirect_to(user_path user)
        end
      end

      context '認可されていないユーザー' do
        it 'ルート画面にリダイレクトされること' do
          login other_user
          patch user_path(user), params: { user: { name: user.name, email: user.email } }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  context '未ログイン時' do
    describe 'GET /index' do
      it 'ログイン画面にリダイレクトされること' do
        get users_path
        expect(response).to redirect_to(login_path)
      end
      it 'リダイレクトされた後にログインをしたらindex画面にリダイレクトすること' do
        get users_path
        login user
        expect(response).to redirect_to(users_path)
      end
    end

    describe 'GET /edit' do
      it 'ログイン画面にリダイレクトされること' do
        get edit_user_path(user)
        expect(response).to redirect_to(login_path)
      end
      it 'リダイレクトされた後にログインをしたらedit画面にリダイレクトすること' do
        get edit_user_path(user)
        login user
        expect(response).to redirect_to(edit_user_path(user))
      end
    end

    describe 'PATCH /update' do
      it 'ログイン画面にリダイレクトされること' do
        patch user_path(user), params: { user: { name: user.name, email: user.email } }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end