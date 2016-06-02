class VotesController < ApplicationController
  before_action :get_config_nerd

  def vote_up
    if cookies.has_key?(:voting_id)
      voting_id = cookies.signed[:voting_id]
    else
      voting_id = SecureRandom.urlsafe_base64(nil, false)
      cookies.permanent.signed[:voting_id] = voting_id
    end
    voter = Voter.find_or_create_by(voting_id: voting_id)
    voter.likes @config_nerd
    redirect_to :back
  end

  private

  def get_config_nerd
    @config_nerd = ConfigNerd.first_or_create
  end
end
