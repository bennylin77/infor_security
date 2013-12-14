Infor::Application.routes.draw do
  

  mount Ckeditor::Engine => '/ckeditor'

  post "main/index"
  get "main/index"
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
  
  get "adm_users/groupIndex"
  get "adm_users/groupCreate" 
  get "adm_users/groupEdit"  
  get "adm_users/groupDestroy"
  post "adm_users/groupCreate"    
  post "adm_users/groupEdit"
  
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
  get   "main/closeJobDirectly"
  get   "main/returnJob"
  get   "main/createJob"
  post  "main/createJob"      
  post  "main/assignJob"
  post  "main/returnJob" 
  post  "main/closeJobDirectly"
     
  get   "main/finishShowing"
  get   "main/unShowing"
  get   "main/deleteJob"
  get   "main/comment"
  post  "main/comment"  
  
  get  "ip_maps/search"
  get  "ip_maps/filter"
  get  "ip_maps/block"   
  get  "ip_maps/alwaysVisible" 
  get  "ip_maps/alwaysHandle"
  
  get   "event_maps/indexAll" 
  post  "event_maps/search"
  
  #comment
  get "comment_lists/index"
  get "comment_lists/commentDetailShow"
  get "comment_lists/handleEdit"
  get "comment_lists/closedEdit"
  get "comment_lists/returnEdit"
  get "comment_lists/changeHandleEdit"
  get "comment_lists/preEdit"
  post "comment_lists/commentDetailShow"
  post "comment_lists/handleEdit"
  post "comment_lists/closedEdit"
  post "comment_lists/returnEdit"
  post "comment_lists/changeHandleEdit"  
  post "comment_lists/preEdit"
  
  get  "comment_lists/search"
  post  "comment_lists/search"
  
  #statistics
  get "statistics/showRes" => 'statistics#showRes'
  get "statistics/long_stat"
  post "statistics/long_stat"
  get "statistics/top10"
  post "statistics/top10"
  
  get "announcements/edit_show" => 'announcements#editShow'
  get "announcements/adm_show" => 'announcements#admShow'
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
  resources :announcements
  resources :statistics
  
  #root :to => 'main#index'
  root :to => 'announcements#guest'
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
