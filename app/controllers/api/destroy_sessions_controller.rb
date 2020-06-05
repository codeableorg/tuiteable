class Api::DestroySessionsController < ApiController
  def destroy
    @user = current_user
    @user.authentication_token = nil if !@user.authentication_token.blank?
    p @user
    @user.save
    if !@user.authentication_token.blank?
      sign_out @user
      render json: {
          messages: "Sigout In Successfully",
          is_success: true,
          data: {user: @user}
      }, status: :ok
    else
      render json: {
          messages: "Sigout In Failed - Unauthorized",
          is_success: false,
          data: {}
      }, status: :unauthorized
    end
  end
end