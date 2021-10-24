class NewslettersController < ApplicationController
  def create
    begin
      Api::SubscribeNewsletter.new(Api::SendinblueSubscriber.new).call(params[:email])
      flash[:notice] = "Votre inscription à la newsletter a bien été prise en compte"
    rescue SibApiV3Sdk::ApiError => e
      flash[:warning] = "Une erreur s’est produite, merci de réessayer ultérieurement"
    end

    redirect_back fallback_location: root_path
  end
end