module API
  class Session < Grape::API
    version 'all', using: :path, vendor: 'yeastlab'

    desc "Retrieve user session"
    post "/session" do
      user = User.find_by_email(params[:email] || params[:login])
      return unauthorized! unless user && user.valid_password?(params[:password])
      present user, with: Entities::UserLogin
    end
  end
end