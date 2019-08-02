Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  # Ransack用
  get '/index', to: 'posts#index'

  resources :posts
  resources :comments

  # 女装アイテム検索機能


  # お気に入り追加・削除
  get '/likes/:id', to: 'likes#touch'

  # フォロー・アンフォロー
  get '/follow/action', to: 'follows#touch'

  resources :users

end
