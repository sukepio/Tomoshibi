require 'rails_helper'

describe 'After login as an admin', type: :system do
  let(:admin) { create(:admin) }
  let!(:admin_event) { create(:admin_event, end: DateTime.now) }
  let!(:resident) { create(:resident, gender: 0)}
  let!(:other_resident) { create(:resident, gender: 1)}
  let!(:post) { create(:post) }

  before do
    visit new_admin_session_path
    fill_in 'ログインID', with: admin.login_id
    fill_in 'パスワード', with: admin.password
    click_button 'ログイン'
  end

  describe 'Side menu' do
    subject { current_path }

    it 'redirects 避難所カレンダー' do
      within ".overlay" do
        find_link('避難所カレンダー').click
      end
      is_expected.to eq '/admin/events'
    end

    it 'redirects 避難者一覧' do
      within ".overlay" do
        find_link('避難者一覧').click
      end
      is_expected.to eq '/admin/residents'
    end

    it 'redirects 避難所通信一覧' do
      within ".overlay" do
        find_link('避難所通信一覧').click
      end
      is_expected.to eq '/admin/posts'
    end

    it 'redirects メッセージ' do
      within ".overlay" do
        find_link('メッセージ').click
      end
      is_expected.to eq '/admin/messages'
    end

    it 'redirects 献立' do
      within ".overlay" do
        find_link('献立').click
      end
      is_expected.to eq '/meals'
    end

    it 'redirects 管理者一覧' do
      within ".overlay" do
        find_link('管理者一覧').click
      end
      is_expected.to eq '/admins'
    end

    it 'redirects 避難所情報' do
      within ".overlay" do
        find_link('避難所情報').click
      end
      is_expected.to eq '/information'
    end
  end

  describe 'Admin top page' do
    before do
      visit admin_events_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/events'
    end

    describe 'Display' do
      subject { page }

      it 'shows the number of residents' do
        is_expected.to have_content "#{Resident.count}名"
      end

      it 'shows the number of households' do
        is_expected.to have_content "#{Household.count}名"
      end

      it 'shows the number of men' do
        is_expected.to have_content "#{Resident.man.count}名"
      end

      it 'shows the number of women' do
        is_expected.to have_content "#{Resident.woman.count}名"
      end

      it 'shows correct welcome container' do
        is_expected.to have_content "こんにちは、#{admin.full_name}さん！"
        is_expected.to have_content "ともしび避難所"
      end

      it 'shows today\'s admin\'s event' do
        within ".myevent-container" do
          is_expected.to have_content admin_event.time
          is_expected.to have_content admin_event.title
          is_expected.to have_content admin_event.body
        end
      end

      it 'shows "イベント作成ボタン" and redirects new admin event page' do
        find_link('イベント作成').click
        expect(current_path).to eq '/admin/events/new'
      end
    end
  end

  describe 'Post index page' do
    let!(:other_post) { create(:post) }

    before do
      visit admin_posts_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/posts'
    end

    it 'has a correct link of a post' do
      expect(page).to have_link '', href: admin_post_path(post)
      expect(page).to have_link '', href: admin_post_path(other_post)
    end

    it 'shows multiple posts' do
      expect(page).to have_content post.time_format
      expect(page).to have_content post.title
      expect(page).to have_content post.body
      expect(page).to have_content other_post.time_format
      expect(page).to have_content other_post.title
      expect(page).to have_content other_post.body
    end
    
    it 'shows an image if any' do
      expect(page).to have_css("img")
    end

    it 'show "新規投稿" button' do
      expect(page).to have_link '新規投稿'
    end
  end

  describe 'Post show page' do
    before do
      visit admin_post_path(post)
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/posts/' + post.id.to_s
    end

    it 'shows a specific post' do
      expect(page).to have_content post.time_format
      expect(page).to have_content post.title
      expect(page).to have_content post.body
      expect(page).to have_content post.admin.full_name
    end

    it 'shows "編集する" button' do
      expect(page).to have_link '編集する'
    end
    
    describe 'Delete a post' do
      it 'shows "削除" button' do
        expect(page).to have_link '削除'
      end
    
      it 'is deleted successfully' do
        expect { click_link '削除' }.to change(Post, :count).by(-1)
      end
      
      it 'shows a success message' do
        click_link '削除'
        expect(page).to have_content "「#{post.title}」を削除しました。"
      end
    end
  end

  describe 'New post page' do
    before do
      visit new_admin_post_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/posts/new'
    end

    describe 'Form Display' do
      it 'show a title form' do
        expect(page).to have_field 'post[title]'
      end
      
      it 'shows a body form' do
        expect(page).to have_field 'post[body]'
      end
      
      it 'shows an image form' do
        expect(page).to have_field 'post[image][]'
      end
      
      it 'does not have any value in the title form' do
        expect(find('input[name="post[title]"]').text).to be_blank
      end

      it 'does not have any value in the body form' do
        expect(find('textarea[name="post[body]"]').text).to be_blank
      end
      
      it 'does not have any value in the image form' do
        expect(find('input[name="post[image][]"]').text).to be_blank
      end
      
      it 'shows "投稿" button' do
        expect(page).to have_button '投稿'
      end
    end
    
    describe 'Successfull post' do
      before do
        fill_in 'post[title]', with: '新規投稿'
        fill_in 'post[body]', with: 'この投稿は新規投稿ができているかのテストです。'
        click_button '投稿'
      end
         
      it 'is saved successfully' do
        expect(page).to have_content '新規投稿'
        expect(page).to have_content 'この投稿は新規投稿ができているかのテストです。'
      end
         
      it 'redirects show page' do
        expect(current_path).to eq '/admin/posts'
      end
      
      it 'shows a success message' do
        expect(page).to have_content "避難所通信「新規投稿」を投稿しました。"
      end
    end
  end
    
  describe 'Post edit page' do
    before do
      visit edit_admin_post_path(post)
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/posts/' + post.id.to_s + '/edit'
    end

    describe 'Form Display' do
      it 'show a title form' do
        expect(page).to have_field 'post[title]', with: post.title
      end

      it 'shows a body form' do
        expect(page).to have_field 'post[body]', with: post.body
      end
      
      it 'shows "更新" button' do
        expect(page).to have_button '更新'
      end
    end
    
    describe 'Successfull update' do
      before do
        fill_in 'post[title]', with: '投稿編集'
        fill_in 'post[body]', with: '先日投稿した投稿内容を編集しましたのでご覧ください。'
        click_button '更新'
      end

      it 'is saved successfully' do
        expect(page).to have_content '投稿編集'
        expect(page).to have_content '先日投稿した投稿内容を編集しましたのでご覧ください。'
      end

      it 'redirects show page' do
        expect(current_path).to eq '/admin/posts/' + post.id.to_s
      end

      it 'shows a success message' do
        expect(page).to have_content "避難所通信「投稿編集」を更新しました。"
      end
    end
  end
end