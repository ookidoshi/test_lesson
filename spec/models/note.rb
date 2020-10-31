describe '入力項目の有無' do
  # ==========ここから追加する==========
  # [Point.3-11-2]インスタンスを共通化してテストデータを作成します。
  let(:new_enquete) { FoodEnquete.new }
  # ==========ここまで追加する==========

  context '必須入力であること' do
    it 'お名前が必須であること' do
      # ==========ここから削除する==========
      # new_enquete = FoodEnquete.new
      # ==========ここまで削除する==========
      expect(new_enquete).not_to be_valid
      expect(new_enquete.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'メールアドレスが必須であること' do
      # ==========ここから削除する==========
      # new_enquete = FoodEnquete.new
      # ==========ここまで削除する==========
      expect(new_enquete).not_to be_valid
      expect(new_enquete.errors[:mail]).to include(I18n.t('errors.messages.blank'))
    end

    it '登録できないこと' do
      # ==========ここから削除する==========
      # new_enquete = FoodEnquete.new
      # ==========ここまで削除する==========

      expect(new_enquete.save).to be_falsey
    end
  end

  context '任意入力であること' do
    it 'ご意見・ご要望が任意であること' do
      # ==========ここから削除する==========
      # new_enquete = FoodEnquete.new
      # ==========ここまで削除する==========
      expect(new_enquete).not_to be_valid
      expect(new_enquete.errors[:request]).not_to include(I18n.t('errors.messages.blank'))
    end
  end
end
