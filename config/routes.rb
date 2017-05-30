Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  
  match '/api/save_pdf' => 'api#save_pdf', via:[:post]
  match '/api/pdf_generation' => 'api#pdf_generation', via:[:get]
  match '/api/download_full_pdf_report' => 'api#download_full_pdf_report', via:[:get]
  match '/api/summary_report' => 'api#summary_report', via:[:get]
  match '/api/save_firedoor_deficiency' => 'api#save_firedoor_deficiency', via:[:post]
  #match '/api/update_pdf' => 'api#update_pdf', via:[:put]
  match  '/api/spreadsheets' => 'api#spreadsheets', via:[:get]


  resources :pdfjobs do
    collection do
      get 'generate_full_pdf_report'
      get 'download_full_pdf_report'
      get 'clear_index_list_view'
      get 'damper_repair'
      get 'firedoor_inspection'
      get 'firestop_survey'
      get 'firestop_installation'
      get 'firedoor_deficiency'
    end
  end

  #root 'pdfjobs#index'
end
