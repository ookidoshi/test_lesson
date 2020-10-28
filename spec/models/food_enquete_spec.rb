require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do

  describe '正常系の機能' do
    context '回答する'　do
      it '正しく登録できること　料理:焼きそば food_id: 2,
                            満足度:良い　score: 3,
                            希望するプレゼント:ビール飲み放題 present_id: 1)' do


            #テストデータの作成
        enquete = FoodEnquate.new(
          name: '田中太郎',
          mail: 'taro.tanaka@example.com',
          age: 25,
          food_id: 2,
          score: 3,
          request: 'おいしかったです。',
          present_id: 1
        )
        #バリデーションが正常に通ること（バリデーションがないこと）を検証
        expect(enquete).to be_valid

        #テストデータを保存
        enquete.save
      end
    end
end
