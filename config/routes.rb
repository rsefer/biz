Biz::Application.routes.draw do

  if Rails.env.production?
    constraints(:host => /^(?!biz\.seferdesign\.com)/i) do
      match "/(*path)" => redirect {
        |params, req| "https://biz.seferdesign.com/#{params[:path]}"
      }, via: [:get, :post]
    end
	end

	root 'welcome#index'

	match 'best', to: 'welcome#best', via: [:get]
	match 'payment', to: 'welcome#payment', via: [:get]
	match 'stripe', to: 'welcome#stripe', via: [:get]

	match 'expenses/bulk/new', to: 'expenses#bulk_new', as: 'new_bulk_expenses', via: [:get, :post]

	match 'invoices/time', to: 'time#index', as: 'time', via: [:get]
	match 'invoices/time/redirect', to: 'time#redirect', as: 'time_redirect', via: [:get]
	match 'invoices/time/callback', to: 'time#callback', as: 'time_callback', via: [:get]

  devise_for :users, :skip => [:registrations]
  resources :years do
    member do
      get :income
      get :expenses
    end
  end
  resources :invoices do
  	resources :lines
    member do
      get :email
			get :stripe
    end
  end
  resources :clients
  resources :expenses
  resources :vendors

  get 'invoices_controller/populate', to: 'invoices#populate'
  get 'invoices_controller/generate_crypto_link', to: 'invoices#generate_crypto_link'
  get 'invoices_controller/mark_paid/:id', to: 'invoices#mark_paid', as: 'mark_paid_invoice'
  get 'charts_controller/trailing_x_months/:number_of_months', to: 'charts#trailing_x_months', as: 'chart_trailing_x_months'
  get 'charts_controller/year_invoice_month/:id', to: 'charts#year_invoice_month', as: 'chart_year_by_invoice_month'
	get 'charts_controller/year_invoice_month_with_goal/:id', to: 'charts#year_invoice_month_with_goal', as: 'chart_year_by_invoice_month_with_goals'
	get 'charts_controller/year_all_data/:id', to: 'charts#year_all_data', as: 'chart_year_all_data'
  get 'charts_controller/year_expense_category/:id', to: 'charts#year_expense_category', as: 'chart_year_by_expense_category'
  get 'charts_controller/year_expense_month/:id', to: 'charts#year_expense_month', as: 'chart_year_by_expense_month'

  namespace :api, defaults: { format: 'json' } do

    namespace :v1 do
      resources :invoices, only: [:index, :show, :create] do
        resources :lines, only: [:index, :show, :create]
        member do
          get :email
        end
      end
      resources :clients, only: [:index, :show]
    end
  end

end
