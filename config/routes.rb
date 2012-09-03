Inno::Application.routes.draw do

  post '/api/create_room' => 'api#create_room', :as => :create_room
  post 'api/join_room' => 'api#join_room', :as => :join_room
  get '/api/get_sessions' => 'api#get_sessions', :as => :get_sessions
  post '/api/past_sessions' => 'api#past_sessions', :as => :past_sessions
  post 'api/schedule_meeting' => 'api#schedule_meeting', :as => :schedule_meeting
  post 'api/get_scheduled_list' => 'api#get_scheduled_list', :as => :get_scheduled_list
  post 'api/cancel_meeting' => 'api#cancel_meeting', :as => :cancel_meeting
  post 'api/get_recordings' => 'api#get_recordings', :as => :get_recordings
  post 'api/update_schedule' => 'api#update_schedule', :as => :update_schedule

  root :to => "dashboard#index"
end
