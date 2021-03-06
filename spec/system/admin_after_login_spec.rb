require 'rails_helper'

describe 'After login as an admin', type: :system do
  let(:admin) { create(:admin) }
  let!(:admin_event) { create(:admin_event, end: DateTime.now) }
  let!(:household) { create(:household)}
  let!(:resident) { create(:resident, gender: 0, household: household)}
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

  describe 'Admin event' do
    before do
      visit admin_new_events_path
    end

    it 'has a correct url' do
      expect(current_path).to eq '/admin/events/new'
    end

    describe 'Form display' do
      it 'show a title form' do
        expect(page).to have_field 'admin_event[title]'
      end

      it 'show a body form' do
        expect(page).to have_field 'admin_event[body]'
      end

      it 'does not have any value in the title form' do
        expect(find_field('admin_event[title]').text).to be_blank
      end

      it 'does not have any value in the body form' do
        expect(find_field('admin_event[body]').text).to be_blank
      end

      it 'shows "新規登録" button' do
        expect(page).to have_button '新規登録'
      end
    end

    describe 'Successfull post' do
      before do
        fill_in 'admin_event[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'admin_event[body]', with: Faker::Lorem.characters(number: 20)
      end

      it 'is saved successfully' do
        expect { click_button '新規登録' }.to change(AdminEvent, :count).by(1)
      end

      it 'redirects admin top page' do
        click_button '新規登録'
        expect(current_path).to eq '/admin/events'
      end

      it 'shows a success message' do
        click_button '新規登録'
        expect(page).to have_content "「#{AdminEvent.last.title}」を作成しました。"
      end
    end
  end

  describe 'Admin event edit page' do
    before do
      visit admin_edit_event_path(admin_event)
    end

    it 'has a correct url' do
      expect(current_path).to eq "/admin/events/#{admin_event.id}/edit"
    end

    describe 'Form display' do
      it 'has the value in the title content' do
        expect(page).to have_field 'admin_event[title]', with: admin_event.title
      end

      it 'has the value in the body form' do
        expect(page).to have_field 'admin_event[body]', with: admin_event.body
      end

      it 'shows "更新" button' do
        expect(page).to have_button '更新'
      end
    end

    describe 'Successfull update' do
      before do
        fill_in 'admin_event[title]', with: "イベント更新"
        fill_in 'admin_event[body]', with: "イベントの編集"
      end

      it 'redirects admin top page' do
        click_button '更新'
        expect(current_path).to eq '/admin/events'
      end

      it 'shows a success message' do
        click_button '更新'
        expect(page).to have_content "「#{AdminEvent.first.title}」を更新しました。"
      end
    end

    describe 'Delete an admin event' do
      it 'shows "削除" button' do
        expect(page).to have_link '削除'
      end

      it 'is deleted successfully' do
        expect { click_link '削除' }.to change(AdminEvent, :count).by(-1)
      end

      it 'shows a success message' do
        click_link '削除'
        expect(page).to have_content "「#{admin_event.title}」を削除しました。"
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

  describe 'Resident index page' do
    let!(:taro) { create(:resident, first_name: "太郎", last_name: "田中", gender: 0, household: household)}

    before do
      visit admin_residents_path
    end

    it 'has a correct page' do
      expect(current_path).to eq '/admin/residents'
    end

    describe 'Page display' do
      it 'shows multiple residents' do
        expect(page).to have_content resident.full_name
        expect(page).to have_content taro.full_name
      end

      it 'redirects taro\'s show page when clickling on his name' do
        find_link('田中 太郎').click
        expect(current_path).to eq "/admin/residents/#{taro.id}"
      end

      it 'shows resident\'s age'do
        expect(page).to have_content taro.age
      end

      it 'shows resident\'s address'do
        expect(page).to have_content taro.household.address
      end

      it 'shows resident\'s living_space'do
        expect(page).to have_content taro.household.living_space
      end

      it 'shows resident\'s photo accepeted'do
        expect(page).to have_content '許可しない'
      end

      it 'shows "新規登録" link'do
        expect(page).to have_link '新規登録へ'
      end
    end
  end

  describe 'Resident show page' do
    before do
      visit admin_resident_path(resident)
    end

    it 'has a correct url' do
      expect(current_path).to eq "/admin/residents/#{resident.id}"
    end

    it 'shows resident\'s name' do
      expect(page).to have_content resident.full_name
    end

    it 'shows resident\'s age' do
      expect(page).to have_content resident.age
    end

    it 'shows resident\'s date of birth' do
      expect(page).to have_content resident.birthday
    end

    it 'shows resident\'s gender' do
      expect(page).to have_content '男性'
    end

    it 'shows if photo is accepeted or not' do
      expect(page).to have_content '許可しない'
    end

    it 'shows resident\'s phone number' do
      expect(page).to have_content resident.phone_number
    end

    it 'shows resident\'s login id' do
      expect(page).to have_content resident.login_id
    end

    it 'shows resident\'s information' do
      expect(page).to have_content resident.information
    end

    it 'shows "編集する" button and redirects edit page' do
      within '.btn-link' do
        click_link '編集する'
        expect(current_path).to eq "/admin/residents/#{resident.id}/edit"
      end
    end

    it 'does not show "写真アルバムへ" button' do
      expect(page).to have_no_link '写真アルバムへ'
    end

    describe 'Household information' do
      it 'shows household\'s name' do
        expect(page).to have_content resident.household.full_name
      end

      it 'shows household\'s address' do
        expect(page).to have_content resident.household.address
      end

      it 'shows household\'s living space' do
        expect(page).to have_content resident.household.living_space
      end

      it 'shows household\'s house damage situation' do
        expect(page).to have_content resident.household.house_damage_situation
      end

      it 'shows "世帯情報を編集する" button for household' do
        click_link '世帯情報を編集する'
        expect(current_path).to eq "/admin/residents/#{resident.id}/households/#{resident.household_id}/edit"
      end
    end
  end

  describe 'Resident edit page' do
    before do
      visit edit_admin_resident_path(resident)
    end

    it 'has a correct url' do
      expect(current_path).to eq "/admin/residents/#{resident.id}/edit"
    end

    describe 'Form Display' do
      it 'show a first name form and has the value in it' do
        expect(page).to have_field 'resident[first_name]', with: resident.first_name
      end

      it 'show a last name form and has the value in it' do
        expect(page).to have_field 'resident[last_name]', with: resident.last_name
      end

      it 'show a first kana name form and has the value in it' do
        expect(page).to have_field 'resident[first_name_kana]', with: resident.first_name_kana
      end

      it 'show a last kana name form and has the value in it' do
        expect(page).to have_field 'resident[last_name_kana]', with: resident.last_name_kana
      end

      it 'show a phone number form and has the value in it' do
        expect(page).to have_field 'resident[phone_number]', with: resident.phone_number
      end

      it 'show a login id form and has the value in it' do
        expect(page).to have_field 'resident[login_id]', with: resident.login_id
      end

      # it 'show a date of birth form and has the value in it' do
      #   expect(find('select[name="resident[date_of_birth][1i]"]'))
      # end

      # it 'show a gender radio box and checks male' do
      #   expect(page).to have_checked_field('man')
      # end

      it 'shows "変更" button' do
        expect(page).to have_button '変更'
      end

      describe 'Successfull edit' do
        before do
          fill_in 'resident[first_name]', with: '一郎'
          fill_in 'resident[last_name]', with: '鈴木'
          fill_in 'resident[first_name_kana]', with: 'イチロウ'
          fill_in 'resident[last_name_kana]', with: 'スズキ'
          fill_in 'resident[phone_number]', with: '000-1234-5678'
          fill_in 'resident[login_id]', with: 'ichiro123'
          fill_in 'resident[information]', with: '自宅にて被災'
          click_button '変更'
        end

        it 'redirects resident show page' do
          expect(current_path).to eq "/admin/residents/#{resident.id}"
        end

        it 'shows a success message' do
          expect(page).to have_content "鈴木 一郎さんの情報を更新しました。"
        end

        it 'shows updated information' do
          expect(page).to have_content '鈴木 一郎'
          expect(page).to have_content 'スズキ イチロウ'
          expect(page).to have_content '000-1234-5678'
          expect(page).to have_content 'ichiro123'
          expect(page).to have_content '自宅にて被災'
        end
      end
    end
  end

  describe 'Household edit page' do
    before do
      visit edit_admin_resident_household_path(resident, household)
    end

    it 'has a correct url' do
      expect(current_path).to eq "/admin/residents/#{resident.id}/households/#{resident.household_id}/edit"
    end
    
    describe 'Form Display' do
      it 'show a first name form and has the value in it' do
        expect(page).to have_field 'household[head_first_name]', with: household.head_first_name
      end

      it 'show a last name form and has the value in it' do
        expect(page).to have_field 'household[head_last_name]', with: household.head_last_name
      end

      it 'show an address form and has the value in it' do
        expect(page).to have_field 'household[address]', with: household.address
      end
      
      it 'show a living space form and has the value in it' do
        expect(page).to have_field 'household[living_space]', with: household.living_space
      end
      
      it 'show a house damage situation form and has the value in it' do
        expect(page).to have_field 'household[house_damage_situation]', with: household.house_damage_situation
      end
      
      it 'shows "更新" button' do
        expect(page).to have_button '更新'
      end
      
      describe 'Successfull edit' do
        before do
          fill_in 'household[head_first_name]', with: '一郎'
          fill_in 'household[head_last_name]', with: '鈴木'
          fill_in 'household[address]', with: '東京都港区1-1'
          fill_in 'household[living_space]', with: 'D-2'
          fill_in 'household[house_damage_situation]', with: '半壊。公費解体予定'
          click_button '更新'
        end

        it 'redirects resident show page' do
          expect(current_path).to eq "/admin/residents/#{resident.id}"
        end

        it 'shows a success message' do
          expect(page).to have_content "山田 花子さんの世帯情報を更新しました。"
        end

        it 'shows updated information' do
          expect(page).to have_content '鈴木 一郎'
          expect(page).to have_content '東京都港区1-1'
          expect(page).to have_content 'D-2'
          expect(page).to have_content '半壊。公費解体予定'
        end
      end
    end
  end
  
  describe 'Admin index page' do
    let!(:shinobu) { create(:admin, first_name: "忍", last_name: "村田")}

    before do
      visit admins_path
    end

    it 'has a correct page' do
      expect(current_path).to eq '/admins'
    end

    describe 'Page display' do
      it 'shows multiple admins' do
        expect(page).to have_content admin.full_name
        expect(page).to have_content shinobu.full_name
      end

      it 'redirects taro\'s show page when clickling on his name' do
        find_link('村田 忍').click
        expect(current_path).to eq "/admins/#{shinobu.id}"
      end

      it 'shows admin\'s age'do
        expect(page).to have_content shinobu.age
      end

      it 'shows admin\'s login id' do
        expect(page).to have_content shinobu.login_id
      end

      it 'shows admin\'s phone number'do
        expect(page).to have_content shinobu.phone_number
      end

      it 'shows admin\'s email'do
        expect(page).to have_content shinobu.email
      end

      it 'shows "新規登録" link'do
        expect(page).to have_link '新規登録'
      end
    end
    
    describe 'New admin registration page' do
      before do
        visit new_admin_registration_path
      end
      
      it 'shows a first name form and no value in it' do
        expect(page).to have_field 'admin[first_name]'
        expect(find_field('admin[first_name]').text).to be_blank
      end
      
      it 'shows a last name form and no value in it' do
        expect(page).to have_field 'admin[last_name]'
        expect(find_field('admin[last_name]').text).to be_blank
      end
      
      it 'shows a first name kana form and no value in it' do
        expect(page).to have_field 'admin[first_name_kana]'
        expect(find_field('admin[first_name_kana]').text).to be_blank
      end
      
      it 'shows a last name kana form and no value in it' do
        expect(page).to have_field 'admin[last_name_kana]'
        expect(find_field('admin[last_name_kana]').text).to be_blank
      end
      
      it 'shows a phone number form and no value in it' do
        expect(page).to have_field 'admin[phone_number]'
        expect(find_field('admin[phone_number]').text).to be_blank
      end
      
      it 'shows a login id form and no value in it' do
        expect(page).to have_field 'admin[login_id]'
        expect(find_field('admin[login_id]').text).to be_blank
      end
      
      it 'shows a email form and no value in it' do
        expect(page).to have_field 'admin[email]'
        expect(find_field('admin[email]').text).to be_blank
      end
      
      it 'shows a password form and no value in it' do
        expect(page).to have_field 'admin[password]'
        expect(find_field('admin[password]').text).to be_blank
      end
      
      it 'shows a password confirmation form and no value in it' do
        expect(page).to have_field 'admin[password_confirmation]'
        expect(find_field('admin[password_confirmation]').text).to be_blank
      end
      
      it 'show a "新規登録" button' do
        expect(page).to have_button '新規登録'
      end
      
      describe 'Successfull create' do
        before do
          fill_in 'admin[first_name]', with: '卓'
          fill_in 'admin[last_name]', with: '大林'
          fill_in 'admin[first_name_kana]', with: 'すぐる'
          fill_in 'admin[last_name_kana]', with: 'おおばやし'
          fill_in 'admin[phone_number]', with: '030-1322-1232'
          fill_in 'admin[login_id]', with: 'admin123'
          fill_in 'admin[email]', with: 'admin@sample.com'
          fill_in 'admin[password]', with: 'password'
          fill_in 'admin[password_confirmation]', with: 'password'
        end
        
        it 'redirects admin\'s show page' do
          expect { click_button '新規登録' }.to change(Admin, :count).by(1)
        end
        
        it 'shows registered values' do
          click_button '新規登録'
          expect(page).to have_content '大林 卓'
          expect(page).to have_content 'admin123'
          expect(page).to have_content '030-1322-1232'
          expect(page).to have_content 'admin@sample.com'
        end
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