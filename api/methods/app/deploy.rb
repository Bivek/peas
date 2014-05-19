module Peas
  class AppMethods < Grape::API
    desc "Deploy an app"
    get :deploy do
      app = get_app
      { job: app.worker(:deploy) }
    end
  end
end
