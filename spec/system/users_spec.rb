# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    Rails.application.env_config['omniauth.auth'] = github_mock
  end

  describe 'user authentication' do
    context 'when authentication is successful' do
      it 'allows users to login' do
        visit root_path
        expect(page).to have_content 'GitHubアカウントが必要です'

        expect do
          click_button 'サインアップ / ログインをして2次会グループを作成'

          expect(page).to have_content 'ログインしました'
        end.to change(User, :count).by(1)

        expect(page).to have_current_path(new_group_path)
      end
    end

    context 'when authentication is failed' do
      before do
        Rails.application.env_config['omniauth.auth'] = github_invalid_mock
      end

      it 'redirects to root_path' do
        visit root_path
        expect(page).to have_content 'GitHubアカウントが必要です'

        expect do
          click_button 'サインアップ / ログインをして2次会グループを作成'

          expect(page).to have_content 'ログインをキャンセルしました'
        end.not_to change(User, :count)

        expect(page).to have_current_path(root_path)
      end
    end

    context 'when user logs out' do
      it 'allows users to logout' do
        visit root_path
        expect(page).to have_content 'GitHubアカウントが必要です'
        expect(page).not_to have_content 'ログアウト'

        click_button 'サインアップ / ログインをして2次会グループを作成'
        expect(page).to have_current_path(new_group_path)

        click_link 'キャンセル'
        expect(page).to have_current_path(groups_path)
        expect(page).not_to have_content 'GitHubアカウントが必要です'

        click_button 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'GitHubアカウントが必要です'
      end
    end
  end
end
