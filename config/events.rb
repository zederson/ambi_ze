WebsocketRails::EventMap.describe do

  namespace :radio do
    subscribe :current_track, to: RadioController, with_method: :index
    subscribe :stop         , to: RadioController, with_method: :stop
  end
end
