module Peas
  class AppMethods < Grape::API
    desc "Create an app"
    post do
      name = App.remote_to_name params[:remote]
      App.create!({
        first_sha: params[:first_sha],
        remote: params[:remote],
        name: name
      })
      respond "App '#{name}' successfully created"
    end
  end
end