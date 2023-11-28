FactoryBot.define do
  factory :notification do
    transient do
      notifiable { nil }
    end
    notifiable_id { notifiable.id }
    notifiable_type { notifiable.class.name }
    user
  end
end
