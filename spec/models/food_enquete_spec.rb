require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do
  describe '正常系の機能' do
    context '回答する' do
      it '正しく登録できること　料理:焼きそば food_id: 2,
                            満足度:良い　score: 3,
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

 
  describe 'アンケート回答時の条件' do
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


    describe '#adult?' do
      it '20歳未満は成人でないこと' do
        foodEnquete = FoodEnquete.new
        #未成年になることを検証します
        expect(foodEnquete.send(:adult?, 19)).to be_falsey
      end

      it '20歳以上は成人であること' do
        foodEnquete = FoodEnquete.new
        #成人になることを検証します。
        expect(foodEnquete.send(:adult?,20)).to be_truthy
      end
    end




    describe '共通バリデーション' do
      it_behaves_like '入力項目の有無'
      it_behaves_like 'メールアドレスの形式'    
    end

    describe '共通メソッド' do
      # [Point.3-12-3]共通化するテストケースを定義します。
      it_behaves_like '価格の表示'
      it_behaves_like '満足度の表示'
    end
  end
  end
