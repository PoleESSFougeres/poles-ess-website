class ChangeDefaultSettings < ActiveRecord::Migration[6.1]
  def up
    if Setting.enabled_features.include?('key_numbers')
      MainPage.find_by(key: "key_number").update(enabled: true) if MainPage.find_by(key: "key_number").present?
    else
      MainPage.find_by(key: "key_number").update(enabled: false) if MainPage.find_by(key: "key_number").present?
    end
  end

  def down
    if MainPage.find_by(key: "key_number").enabled?
      Setting.enabled_features = (Setting.enabled_features + ['key_numbers']).uniq
    else
      Setting.enabled_features = (Setting.enabled_features - ['key_numbers']).uniq
    end
  end
end
