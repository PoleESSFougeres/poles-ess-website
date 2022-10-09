class AdherentsController < ApplicationController
  include SlugsAndRedirections

  before_action :set_breadcrumbs

  def index
    @adherent_categories = AdherentCategory.having_adherents.includes(:adherents).order(:position)
  end

  private # =====================================================

  def set_breadcrumbs
    parent_page = MainPage.find_by(key: "staff_member").parent_page
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",    root_path ]
    @breadcrumbs << [ parent_page.title,    main_page_path(parent_page) ] if parent_page.present?
    @breadcrumbs << [ "Adhérent·e·s",      adherents_path ]
  end
end
