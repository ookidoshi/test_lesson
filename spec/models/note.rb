
require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do
  describe '正常系の機能' do
    context '回答する' do
      it '正しく登録できること 料理:やきそば food_id: 2, 
                            満足度:良い score: 3, 
                            希望するプレゼント:ビール飲み放題 present_id: 1)' do
        enquete = FactoryBot.build(:food_enquete_tanaka)

        expect(enquete).to be_valid
        enquete.save

        answered_enquete = FoodEnquete.find(1);
        expect(answered_enquete.name).to eq('田中 太郎')
        expect(answered_enquete.mail).to eq('taro.tanaka@example.com')
        expect(answered_enquete.age).to eq(25)
        expect(answered_enquete.food_id).to eq(2)
        expect(answered_enquete.score).to eq(3)
        expect(answered_enquete.request).to eq('おいしかったです。')
        expect(answered_enquete.present_id).to eq(1)
      end
    end
  end










  describe 'メールアドレスの形式' do
    context '不正な形式のメールアドレスの場合' do
      it 'エラーになること' do
        new_enquete = FoodEnquete.new
        # [Point.3-7-1]不正な形式のメールアドレスを入力します。
        new_enquete.mail = "taro.tanaka"
        expect(new_enquete).not_to be_valid
        # [Point.3-7-2]不正な形式のメッセージが含まれることを検証します。
        expect(new_enquete.errors[:mail]).to include(I18n.t('errors.messages.invalid'))
      end
    end
  end



  

  describe 'アンケート回答時の条件' do
    context 'メールアドレスを確認すること' do
      before do
        FactoryBot.create(:food_enquete_tanaka)
      end
  
      context 'メールアドレスを確認すること' do
        it '同じメールアドレスで再び回答できないこと' do
          # [Point.3-6-1]1つ目のテストデータを作成します。
          enquete_tanaka = FoodEnquete.new(
            name: '田中 太郎',
            mail: 'taro.tanaka@example.com',
            age: 25,
            food_id: 2,
            score: 3,
            request: 'おいしかったです。',
            present_id: 1
          )
          enquete_tanaka.save
    
          # [Point.3-6-2]2つ目のテストデータを作成します。
          re_enquete_tanaka = FoodEnquete.new(
            name: '田中 太郎',
            mail: 'taro.tanaka@example.com',
            age: 25,
            food_id: 0,
            score: 1,
            request: 'スープがぬるかった',
            present_id: 0
          )
          expect(re_enquete_tanaka).not_to be_valid
  
          # [Point.3-6-3]メールアドレスが既に存在するメッセージが含まれることを検証します。
          expect(re_enquete_tanaka.errors[:mail]).to include(I18n.t('errors.messages.taken'))
          expect(re_enquete_tanaka.save).to be_falsey
          expect(FoodEnquete.all.size).to eq 1
        end
      end

      it '異なるメールアドレスで回答できること' do
        enquete_tanaka = FoodEnquete.new(
          name: '田中 太郎',
          mail: 'taro.tanaka@example.com',
          age: 25,
          food_id: 2,
          score: 3,
          request: 'おいしかったです。',
          present_id: 1
        )
        enquete_tanaka.save
  
        enquete_yamada = FoodEnquete.new(
          name: '山田 次郎',
          mail: 'jiro.yamada@example.com',
          age: 22,
          food_id: 1,
          score: 2,
          request: '',
          present_id: 0
        )
  
        expect(enquete_yamada).to be_valid
        enquete_yamada.save
        # [Point.3-6-4]問題なく登録できます。
        expect(FoodEnquete.all.size).to eq 2
      end







    context '年齢を確認すること' do
      it '未成年はビール飲み放題を選択できないこと' do
        enquete_sato = FactoryBot.build(:food_enquete_sato)
  
        expect(enquete_sato).not_to be_valid
        expect(enquete_sato.errors[:present_id]).to include(I18n.t('activerecord.errors.models.food_enquete.attributes.present_id.cannot_present_to_minor'))
      end

      it '成人はビール飲み放題を選択できないこと' do
        enquete_sato = FactoryBot.build(:food_enquete_sato, age: 20)
  
        expect(enquete_sato).to be_valid
      end

    end
  end

  describe '#adult?' do
    it '20歳未満は成人ではないこと' do
      foodEnquete = FoodEnquete.new
      expect(foodEnquete.send(:adult?, 19)).to be_falsey
    end
    
    it '20歳以上は成人であること' do
      foodEnquete = FoodEnquete.new
      expect(foodEnquete.send(:adult?, 20)).to be_truthy
    end
  end

  describe '共通バリデーション' do
    it_behaves_like '入力項目の有無'
    it_behaves_like 'メールアドレスの形式'    
  end

  describe '共通メソッド' do
    it_behaves_like '価格の表示'
    it_behaves_like '満足度の表示'
  end
end
