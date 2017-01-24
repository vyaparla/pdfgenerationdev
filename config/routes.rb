Rails.application.routes.draw do

  match '/api/save_pdf' => 'api#save_pdf', via:[:post]
  match '/api/pdf_generation' => 'api#pdf_generation', via:[:get]
  match '/api/download_full_pdf_report' => 'api#download_full_pdf_report', via:[:get]
  #match '/api/update_pdf' => 'api#update_pdf', via:[:put]

  resources :pdfjobs do
    collection do
      get 'generate_full_pdf_report'
      get 'download_full_pdf_report'
      get 'clear_index_list_view'
    end
  end

  root 'pdfjobs#index'
end
