require 'rails_helper'

describe 'After login as a resident', type: :system do
  let(:resident) { create(:resident) }
  let!(:myevent) { create(:myevent, resident: resident) }
  let!(:post) { create(:post) }

  before do
    visit new_resident_session_path
    fill_in 'ログインID', with: resident.login_id
    fill_in 'パスワード', with: resident.password
    click_button 'ログイン'
  end

  describe 'Side menu' do
    subject { current_path }

    it 'redirects マイページ' do
      within ".overlay" do
        find_link('マイページ').click
      end
      is_expected.to eq '/mypage'
    end

    it 'redirects 避難所通信' do
      within ".overlay" do
        find_link('避難所通信').click
      end
      is_expected.to eq '/posts'
    end

    it 'redirects お気に入り' do
      within ".overlay" do
        find_link('お気に入り').click
      end
      is_expected.to eq '/bookmarks'
    end

    it 'redirects メッセージ' do
      within ".overlay" do
        find_link('メッセージ').click
      end
      is_expected.to eq '/messages'
    end

    it 'redirects 献立' do
      within ".overlay" do
        find_link('献立').click
      end
      is_expected.to eq '/meals'
    end

    it 'redirects 避難所情報' do
      within ".overlay" do
        find_link('避難所情報').click
      end
      is_expected.to eq '/information'
    end
  end
end