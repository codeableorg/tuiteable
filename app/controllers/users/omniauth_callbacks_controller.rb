# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    p request.env['omniauth.auth']
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook')
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      flash[:alert] = 'Error creating user with Facebook'
      redirect_to new_user_registration_url
    end
  end

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Github')
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      flash[:alert] = 'Error creating user with Github'
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
  end
# You should configure your model like this:
# devise :omniauthable, omniauth_providers: [:twitter]

# You should also create an action method in this controller like this:
# def twitter
# end

# More info at:
# https://github.com/plataformatec/devise#omniauth

# GET|POST /resource/auth/twitter
# def passthru
#   super
# end

# GET|POST /users/auth/twitter/callback
# def failure
#   super
# end

# protected

# The path used when OmniAuth fails
# def after_omniauth_failure_path_for(scope)
#   super(scope)
# end
