require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  describe 'creating a new group' do
    context 'with valid input' do
      it 'creates the group' do
        visit root_path
        click_link 'New group'
        expect(page).to have_current_path(new_group_path)

        expect do
          fill_in 'イベントのハッシュタグ', with: 'rubykaigi'
          fill_in '2次会グループ名', with: 'みんなで飲みましょう!!'
          fill_in '募集内容', with: '誰でも参加OK!!'
          fill_in '定員', with: 10
          fill_in '会場', with: '未定'
          fill_in '会計方法', with: '割り勘'
          click_button '登録する'

          expect(page).to have_content 'Group was successfully created.'
          expect(page).to have_content 'rubykaigi'
          expect(page).to have_current_path(group_path(Group.last))
        end.to change(Group, :count).by(1)
      end
    end

    context 'with invalid input' do
      it 'displays an error message' do
        visit root_path
        click_link 'New group'
        expect(page).to have_current_path(new_group_path)

        fill_in 'イベントのハッシュタグ', with: nil
        fill_in '2次会グループ名', with: 'みんなで飲みましょう!!'
        fill_in '募集内容', with: '誰でも参加OK!!'
        fill_in '定員', with: 10
        fill_in '会場', with: '未定'
        fill_in '会計方法', with: '割り勘'
        click_button '登録する'

        expect(page).to have_content '2次会グループに1個のエラーが発生しました'
        expect(page).to have_content 'イベントのハッシュタグを入力してください'
        expect(page).to have_current_path(new_group_path)
      end
    end
  end
end
