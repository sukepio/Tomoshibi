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

    it 'redirects "マイページ"' do
      within ".overlay" do
        find_link('マイページ').click
      end
      is_expected.to eq '/mypage'
    end

    it 'redirects "避難所通信"' do
      within ".overlay" do
        find_link('避難所通信').click
      end
      is_expected.to eq '/posts'
    end

    it 'redirects "お気に入り"' do
      within ".overlay" do
        find_link('お気に入り').click
      end
      is_expected.to eq '/bookmarks'
    end

    it 'redirects "メッセージ"' do
      within ".overlay" do
        find_link('メッセージ').click
      end
      is_expected.to eq '/messages'
    end

    it 'redirects "献立"' do
      within ".overlay" do
        find_link('献立').click
      end
      is_expected.to eq '/meals'
    end

    it 'redirects "避難所情報"' do
      within ".overlay" do
        find_link('避難所情報').click
      end
      is_expected.to eq '/information'
    end
  end

  describe 'Mypage' do
    before do
      visit mypage_path
    end

    describe 'Display' do
      subject { page }

      it 'shows correct welcome container' do
        is_expected.to have_content "こんにちは、#{resident.full_name}さん！"
        is_expected.to have_content resident.self_message
        is_expected.to have_content "ともしび避難所"

      end

      it 'shows resident\'s today\'s event' do
        within ".myevent-container" do
          is_expected.to have_content myevent.time
          is_expected.to have_content myevent.title
          is_expected.to have_content myevent.body
        end
      end

      it 'does not show other day\'s event' do
        within ".myevent-container" do
        other_event = create(:myevent, resident: resident, start: 1.day.ago)
          is_expected.to have_no_content other_event.time
          is_expected.to have_no_content other_event.title
          is_expected.to have_no_content other_event.body
        end
      end

      it 'shows the most recent post' do
        is_expected.to have_content post.time_format
        is_expected.to have_content post.title
        is_expected.to have_content post.body
      end

      it 'shows "イベント作成ボタン" and redirects new myevent page' do
        find_link('イベント作成').click
        expect(current_path).to eq '/myevents/new'
      end

      it 'shows "写真アルバムについてボタン" and redirects photo confirm page' do
        find_link('写真アルバムについて').click
        expect(current_path).to eq '/confirm'
      end

      it 'shows "一言メッセージ/写真許可編集ボタン" and redirects edit page' do
        find_link('編集する').click
        expect(current_path).to eq '/edit'
      end
    end
  end

  describe 'Myevent' do
    before do
      visit new_myevent_path
    end

    it 'shows a correct page' do
      expect(current_path).to eq '/myevents/new'
    end

    describe 'form display' do
      it 'show a title form' do
        expect(page).to have_field 'myevent[title]'
      end

      it 'show a body form' do
        expect(page).to have_field 'myevent[body]'
      end

      # it 'show a start form' do
      #   expect(page).to have_field 'myevent[start]'
      # end

      it 'does not have any value in the title form' do
        expect(find_field('myevent[title]').text).to be_blank
      end

      it 'does not have any value in the body form' do
        expect(find_field('myevent[body]').text).to be_blank
      end

    end
  end
end