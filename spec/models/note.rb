describe '正常系の機能' do
  context '回答する' do
    it '正しく登録できること 料理:やきそば food_id: 2, 
                          満足度:良い score: 3, 
                          希望するプレゼント:ビール飲み放題 present_id: 1)' do





  # [Point.3-3-1]テストデータを作成します。
        enquete = FoodEnquete.new(
          name: '田中 太郎',
          mail: 'taro.tanaka@example.com',
          age: 25,
          food_id: 2,
          score: 3,
          request: 'おいしかったです。',
          present_id: 1
        )

        # [Point.3-3-2]「バリデーションが正常に通ること(バリデーションエラーが無いこと)」を検証します。
        expect(enquete).to be_valid

        # [Point.3-3-3]テストデータを保存します。
        enquete.save
    end
  end
end
