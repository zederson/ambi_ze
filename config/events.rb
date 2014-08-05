WebsocketRails::EventMap.describe do

  namespace :radio do
    subscribe :current_track, to: RadioController, with_method: :index
  end
end
