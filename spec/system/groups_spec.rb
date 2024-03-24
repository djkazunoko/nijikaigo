# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  let(:group) { FactoryBot.create(:group) }

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

          expect(page).to have_content '2次会グループが作成されました'
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

        expect do
          fill_in 'イベントのハッシュタグ', with: ''
          fill_in '2次会グループ名', with: 'みんなで飲みましょう!!'
          fill_in '募集内容', with: '誰でも参加OK!!'
          fill_in '定員', with: 10
          fill_in '会場', with: '未定'
          fill_in '会計方法', with: '割り勘'
          click_button '登録する'

          expect(page).to have_content '2次会グループに1個のエラーが発生しました'
          expect(page).to have_content 'イベントのハッシュタグを入力してください'
          expect(page).to have_current_path(new_group_path)
        end.not_to change(Group, :count)
      end
    end
  end

  describe 'updating a group' do
    context 'with valid input' do
      it 'updates the group' do
        visit group_path(group)
        click_link 'Edit this group'
        expect(page).to have_current_path(edit_group_path(group))

        fill_in '会場', with: 'とある居酒屋'
        click_button '更新する'

        expect(page).to have_content '2次会グループが更新されました'
        expect(page).to have_content 'とある居酒屋'
        expect(page).to have_current_path(group_path(group))
      end
    end

    context 'with invalid input' do
      it 'displays an error message' do
        visit group_path(group)
        click_link 'Edit this group'
        expect(page).to have_current_path(edit_group_path(group))

        fill_in '会場', with: ''
        click_button '更新する'

        expect(page).to have_content '2次会グループに1個のエラーが発生しました'
        expect(page).to have_content '会場を入力してください'
        expect(page).to have_current_path(edit_group_path(group))
      end
    end
  end

  describe 'deleting a group' do
    it 'deletes the group' do
      visit group_path(group)

      expect do
        accept_confirm do
          click_button 'Destroy this group'
        end

        expect(page).to have_content '2次会グループが削除されました'
        expect(page).not_to have_content 'rubykaigi'
        expect(page).to have_current_path(groups_path)
      end.to change(Group, :count).by(-1)
    end
  end
end
