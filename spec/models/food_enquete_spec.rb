require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do

  describe '正常系の機能' do
    context '回答する' do
      it '正しく登録できること　料理:焼きそば food_id: 2,
                            満足度:良い　score: 3,
                            希望するプレゼント:ビール飲み放題 present_id: 1)' do


            #[0]テストデータの作成
          enquete = FoodEnquete.new(
          name: '田中 太郎',
          mail: 'taro.tanaka@example.com',
          age: 25,
          food_id: 2,
          score: 3,
          request: 'おいしかったです。',
          present_id: 1
        )
        #バリデーションが正常に通ること（バリデーションエラーがないこと）を検証
        expect(enquete).to be_valid

        #[1]テストデータを保存
        enquete.save
        #[1]で保存したデータを取得
        answered_enquete = FoodEnquete.find(1);

        #[0]で作成したデータを同一か検証します
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
      describe '入力項目の有無' do
        context '必須入力であること' do
          #itは複数書ける
          it 'お名前が必須であること' do
            new_enquete = FoodEnquete.new
            #バリデーションエラーが発生することを検証
            expect(new_enquete).not_to be_valid
            #必須入力のメッセージが含まれることを検証
            expect(new_enquete.errors[:name]).to include(I18n.t('errors.messages.blank'))
          end

          it 'メールアドレスが必須であること' do
            new_enquete = FoodEnquete.new
            expect(new_enquete).not_to be_valid
            expect(new_enquete.errors[:mail]).to include(I18n.t('errors.messages.blank'))
          end

          #itを複数書くことができる
          it '登録できないこと' do
            new_enquete = FoodEnquete.new

            #保存の失敗することを検証
            expect(new_enquete.save).to be_falsey
          end
        end

      context '任意入力であること' do
      it 'ご意見・ご要望が任意であること' do
        new_enquete = FoodEnquete.new
        expect(new_enquete).not_to be_valid
        #必須入力のメッセージが含まれないことを検証します
        expect(new_enquete.errors[:request]).not_to include(I18n.t('errors.messages.blank'))
      end
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
end
