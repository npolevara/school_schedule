Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  resources :students do
    resources :schedules, only: [:index, :create, :destroy] do
      collection do
        get 'download'
      end
    end
  end
  resources :sections
  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
