Infor::Application.routes.draw do
  

  #account
  get   "main/login"
  get   "main/createUser"
  get   "adm_users/verifyCode"
  get   "main/logout"
  get   "main/mailConfig"
  get   "main/permissionConfig"  
  get   "main/traceConfig"  
  get   "main/pwReset"    

  post  "main/createUser"
  post  "main/login"
  post  "main/mailConfig"
  post  "main/permissionConfig"  
  post  "main/traceConfig"  
  #stage
  get   "main/jobDetailShowing"
  get   "main/assignJob"
  get   "main/informUser"  
  get   "main/informUserMail"  
  get   "main/handleJob"
  get   "main/handleJobMail"
  get   "main/checkJob"
  get   "main/checkJobMail"
  get   "main/closeJob"
  get   "main/closeJobMail"
  get   "main/returnJob"
  get   "main/createJob"
  post  "main/createJob"      
  post  "main/assignJob"
  post  "main/returnJob" 
   
  get   "main/finishShowing"
  get   "main/unShowing"
  get   "main/deleteJob"
  get   "main/comment"
  post  "main/comment"  
  
  get  "ip_maps/search"
  get  "ip_maps/filter"
  get  "ip_maps/block"   
  get  "ip_maps/alwaysVisible" 
  
  get   "event_maps/indexAll" 
  post  "event_maps/search"
  
  #comment
  get "comment_list/index"
  get "comment_list/CommentDetailShow"
  get "comment_list/handle_edit"
  get "comment_list/closed_edit"
  get "comment_list/return_edit"
  post "comment_list/CommentDetailShow"
  post "comment_list/handle_edit"
  post "comment_list/closed_edit"
  post "comment_list/return_edit"
  
  resources :jobs
  resources :adm_users
  resources :campus_buildings_lists
  resources :event_maps
  resources :s_closeds
  resources :s_checks
  resources :s_reports
  resources :s_handles
  resources :s_informs
  resources :job_details
  resources :job_logs
  resources :ip_maps
  
  
  root :to => 'main#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
