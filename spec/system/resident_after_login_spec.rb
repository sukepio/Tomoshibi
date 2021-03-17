require 'rails_helper'

describe 'After login as a resident', type: :system do
  let(:resident) { create(:resident) }
  let!(:myevent) { create(:myevent, resident: resident) }
  let!(:post) { create(:post) }
  let!(:other_post) { create(:post, created_at: 2.days.ago) }
  let!(:bookmark) { create(:bookmark, resident: resident, post: post) }

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

      it 'does not show other day\'s event in today\'s events'do
        within ".myevent-container" do
          other_event = create(:myevent, resident: resident, start: 2.days.ago)
          is_expected.to have_no_content other_event.time
          is_expected.to have_no_content other_event.title
          is_expected.to have_no_content other_event.body
        end
      end

      it 'shows the most recent post' do
        is_expected.to have_content other_post.time_format
        is_expected.to have_content other_post.title
        is_expected.to have_content other_post.body
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

  describe 'Photo confirmation page' do
    before do
      visit confirm_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/confirm'
    end

    it 'shows "編集画面へ" button and redirects resident\'s edit page ' do
      find_link('編集画面へ').click
      expect(current_path).to eq '/edit'
    end
  end

  describe 'Self message edit page' do
    before do
      visit edit_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/edit'
    end

    it 'show a self message form' do
      expect(page).to have_field 'resident[self_message]', with: resident.self_message
    end

    it 'shows a radio butotn' do
      expect(page).to have_field 'resident[photo_accepted]'
    end

    describe 'Successfull post' do
      before do
        fill_in 'resident[self_message]', with: Faker::Lorem.characters(number: 20)
        click_button '更新'
      end

      it 'is saved successfully' do
        expect(current_path).to eq '/mypage'
      end
    end
  end

  describe 'Myevent' do
    before do
      visit new_myevent_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/myevents/new'
    end

    describe 'Form display' do
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

      it 'shows "新規登録" button' do
        expect(page).to have_button '新規登録'
      end
    end

    describe 'Successfull post' do
      before do
        fill_in 'myevent[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'myevent[body]', with: Faker::Lorem.characters(number: 20)
      end

      it 'is saved successfully' do
        expect { click_button '新規登録' }.to change(resident.myevents, :count).by(1)
      end

      it 'redirects mypage' do
        click_button '新規登録'
        expect(current_path).to eq '/mypage'
      end

      it 'shows a success message' do
        click_button '新規登録'
        expect(page).to have_content "#{Myevent.last.title}を追加しました。"
      end
    end
  end

  describe 'Post index page' do
    before do
      visit posts_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/posts'
    end

    it 'has a correct link of a post' do
      expect(page).to have_link '', href: post_path(post)
      expect(page).to have_link '', href: post_path(other_post)
    end

    it 'shows multiple posts' do
      expect(page).to have_content post.time_format
      expect(page).to have_content post.title
      expect(page).to have_content post.body
      expect(page).to have_content other_post.time_format
      expect(page).to have_content other_post.title
      expect(page).to have_content other_post.body
    end

    it 'does not show "新規投稿" button' do
      expect(page).to have_no_link '新規投稿'
    end
  end

  describe 'Post show page' do
    before do
      visit post_path(post)
    end

    it 'has a correct url' do
      expect(current_path).to eq '/posts/' + post.id.to_s
    end

    it 'shows a specific post' do
      expect(page).to have_content post.time_format
      expect(page).to have_content post.title
      expect(page).to have_content post.body
    end
  end

  describe 'Bookmark page' do
    before do
      visit bookmarks_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/bookmarks'
    end

    it 'shows a bookmarked post' do
      expect(page).to have_content post.time_format
      expect(page).to have_content post.title
      expect(page).to have_content post.body
    end

    it 'does not show a not bookmarked post' do
      expect(page).to have_no_content other_post.time_format
      expect(page).to have_no_content other_post.title
      expect(page).to have_no_content other_post.body
    end

    it 'has a correct post\'s link' do
      expect(page).to have_link '', href: post_path(post)
    end
  end

  describe 'Message page' do
    let!(:message) { create(:message) }

    before do
      visit messages_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/messages'
    end

    it 'shows a sender name' do
      expect(page).to have_content message.sender
    end

    it 'shows a content' do
      expect(page).to have_content message.content
    end

    it 'shows an image if any' do
      expect(page).to have_css("img[src$='apple_pie.jpg']")
    end
  end

  describe 'Meal page' do
    let!(:meal) { create(:meal) }

    before do
      visit meals_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/meals'
    end

    it 'shows a meal' do
      within '.today-meal-container' do
        expect(page).to have_content meal.time
        expect(page).to have_content meal.menu
      end
    end
  end

  describe 'Information page' do
    before do
      visit information_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/information'
    end

    it 'has a map' do
      expect(page).to have_selector '#map'
    end
  end
end