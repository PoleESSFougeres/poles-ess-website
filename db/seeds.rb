# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include Rails.application.routes.url_helpers

# Admin ------------------------------------------------
Admin.where(email: "bonjour@lassembleuse.fr").first_or_create(password: "password") if %w[development test].include?(Rails.env)

# Référencement ---------------------------------------
%w[
  home
].each do |param|
  Seo.where(param: param).first_or_create
end


# Settings ----------------------------------------------

Setting.logo_instance = 1  if Setting.logo_instance.blank?
Setting.logo_instance.logo.attach(io: File.open('public/logo.png'), filename: 'logo.png', content_type: 'image/png')
Setting.logo_instance_primary = 1  if Setting.logo_instance_primary.blank?
Setting.logo_instance_primary.logo.attach(io: File.open('public/logo-primary.png'), filename: 'logo-primary.png', content_type: 'image/png')
Setting.pole_name = "Pôle ESS du Pays de Fougères Écosolidaire"                        if Setting.pole_name.blank?
Setting.pole_address = "1 rue de la Moussais"      if Setting.pole_address.blank?
Setting.pole_address_complementary = ""  if Setting.pole_address_complementary.blank?
Setting.pole_city = "35300 Fougères"         if Setting.pole_city.blank?
Setting.pole_phone = "02 99 17 05 34"                 if Setting.pole_phone.blank?
Setting.pole_mail = "pole@fougeres-ecosolidaire.fr"                    if Setting.pole_mail.blank?
Setting.baseline = "Dynamiser les projets d'utilité sociale en pays de Fougères"    if Setting.baseline.blank?
Setting.newsletter_subscription_title = "Inscrivez-vous à notre newsletter"  if Setting.newsletter_subscription_title.blank?
Setting.newsletter_subscription_description = "Une info par lettre, soignée et choyée, à échéance régulière dans votre boîte aux lettres" if Setting.newsletter_subscription_description.blank?
Setting.contact_bloc_description = "Vous avez des tonnes de question ? Vous souhaitez mieux identifier ce qui existe sur le territoire ?" if Setting.contact_bloc_description.blank?
Setting.contact_bloc_button = "Contacter le pôle" if Setting.contact_bloc_button.blank?
Setting.admin_emails = %w[bonjour@lassembleuse.fr matthieu.constant@ecosolidaires.org marie.behra@ecosolidaires.org ellie.rudolph@ecosolidaires.org marie.geraudie@ecosolidaires.org ilonka.sygiel@ecosolidaires.org]    if Setting.admin_emails.blank?
Setting.highlighted_feature = 'formations'    if Setting.highlighted_feature.blank?
Setting.enabled_features = ['formations', 'key_numbers']


EmailTemplate.where(mailer: "ParticipantMailer", mail_name: "new_subscription").first_or_create(body: "Le pôle vous recontactera rapidement pour préciser les détails pratiques et le règlement.")

# Basic Pages ==================================================
[
  { key: 'data_policy', title: 'Politique de confidentialité', enabled: true },
  { key: 'legal_mentions', title: 'Mentions légales', enabled: true },
  { key: 'cgu', title: 'Conditions d\'utilisation', enabled: true },
  { key: 'contact', title: 'Contact', enabled: true },
].each do |option|
  BasicPage.where(key: option[:key]).first_or_create(
    enabled: option[:enabled],
    title: option[:title]
  )
end

# Themes ==================================================
[
  { title: 'Découvrir', baseline: 'Mieux comprendre l’ESS, une économie au service des femmes et des hommes du territoire', position: 1 },
  { title: "Coopérer", baseline: 'S’impliquer dans une dynamique coopérative de territoire, au côté du Pôle ESS', position: 2 },
  { title: "Entreprendre", baseline: "Etre accompagné pour développer un projet d’utilité sociale", position: 3 },
].each do |option|
  Theme.where(title: option[:title]).first_or_create(
    baseline: option[:baseline],
    position: option[:position]
  )
end

# Profiles ==================================================
[
  { title: 'Porteuse ou porteur de projet ou d’idée', key: 'porteur', baseline: 'Créer une activité', position: 1 },
  { title: "Collectivité locale ou acteur public", key: 'collectivite', baseline: "Renforcer l’attractivité de votre territoire", position: 2 },
  { title: "Association, coopérative…", key: 'association', baseline: 'Poursuivre une mission d’utilité sociale', position: 3 },
  { title: "Établissement d’enseignement", key: 'ecole', baseline: 'Développer l’engagement citoyen', position: 4 },
  { title: "Dirigeant.e.s d’entreprise", key: 'entreprise', baseline: 'Identifier ce que l’ESS peut vous apporter', position: 5 },
].each do |option|
  Profile.where(key: option[:key]).first_or_create(
    title: option[:title],
    baseline: option[:baseline],
    position: option[:position]
  )
end


# Main Pages ==================================================
[
  { title: 'Pôle ESS du pays de Fougères, EcoSolidaireS', baseline: ' Ensemble agissons pour une économie qui a du sens', position: 1, child_pages: [
    { key: nil, title: 'Missions', enabled: true, position: 1 },
    { key: 'staff_member', title: 'Equipe', enabled: true, position: 2 },
    { key: 'adherent', title: 'Adhérents', enabled: true, position: 3 },
    { key: 'partner', title: 'Partenaires', enabled: true, position: 4 },
    { key: 'membership', title: 'Adhérer au pôle', enabled: true, position: 5 },
    { key: nil, title: 'Se former', enabled: true, position: 6 },
  ] },
  { title: "L'ESS", baseline: "Un modèle économique et social où l’humain est au cœur des relations induites", position: 2, child_pages: [
    { key: 'ess_map', title: 'Carte des adhérents', enabled: true, position: 1 },
    { key: nil, title: "Les chiffres de l’ESS en pays de Fougères", enabled: true, position: 2 },
    { key: nil, title: "Les chiffres de l’ESS en Bretagne", enabled: true, position: 3 },
    { key: nil, title: "Les chiffres de l’ESS en France", enabled: true, position: 4 },
  ] },
].each do |option|
  main_page = MainPage.where(title: option[:title]).first_or_create(
    baseline: option[:baseline],
    position: option[:position],
    key: option[:key]
  )
  if option[:child_pages].present?
    option[:child_pages].each do |child_page_h|
      main_page.child_pages.where(title: child_page_h[:title]).first_or_create(
        key: child_page_h[:key],
        enabled: child_page_h[:enabled],
        position: child_page_h[:position]
      )
    end
  end
end

# Menu Items ==================================================

[
  { theme: 'Découvrir', menu_blocks: [
    { title: "", position: 2, menu_items: [
      { title: "Chiffre-clés", url: key_numbers_path, position: 1},
      { title: "Ressources", url: resources_path, position: 2},
      { title: "Actualités", url: posts_path, position: 3}
      ]
    }
    ]
  },
  { theme: 'Entreprendre', menu_blocks: [
    { title: "", position: 2, menu_items: [
      { title: "Chiffre-clés", url: key_numbers_path, position: 1},
      { title: "Ressources", url: resources_path, position: 2},
      { title: "Actualités", url: posts_path, position: 3}
    ] }
    ]
  }
].each do |option|
  theme = Theme.where(title: option[:theme]).first
  next unless theme.present?

  option[:menu_blocks].each do |menu_block_h|
    menu_block = theme.menu_blocks.where(title: menu_block_h[:title]).first_or_create(position: menu_block_h[:position])
    menu_block_h[:menu_items].each do |menu_item_h|
      menu_block.menu_items.where(title: menu_item_h[:title]).first_or_create(
        url: menu_item_h[:url],
        position: menu_item_h[:position]
      )
    end
  end
end

[
  { main_page: 'Pôle ESS du pays de Fougères, EcoSolidaireS', menu_blocks: [
    { title: "Connaître le Pôle", position: 1, menu_items: [
      { title: "Missions", url: main_page_path(MainPage.find_by(title: 'Missions')), position: 1 },
      { title: "Equipe", url: staff_members_path, position: 2 },
      { title: "Adhérents", url: adherents_path, position: 3 },
      { title: "Partenaires", url: partners_path, position: 4 }
    ] },
    { title: "Agir avec le pôle", position: 2, menu_items: [
      { title: "Adhérer au pôle", url: main_page_path(MainPage.find_by(key: 'membership')), position: 1},
      { title: "Se former", url: formations_path, position: 2},
      { title: "Contacter le pôle", url: basic_page_path(BasicPage.find_by(key: 'contact')), position: 3}
      ]
    }
    ]
  },
  { main_page: "L'ESS", menu_blocks: [
    { title: "L’ESS en pays de Fougères", position: 1, menu_items: [
      { title: "Carte des adhérents", url: main_page_path(MainPage.find_by(key: 'ess_map')), position: 1 },
      { title: "Les chiffres de l’ESS en pays de Fougères", url: main_page_path(MainPage.find_by(title: 'Les chiffres de l’ESS en pays de Fougères')), position: 2 }
    ] },
    { title: "L'ESS en général", position: 2, menu_items: [
      { title: "Les chiffres de l’ESS en Bretagne", url: main_page_path(MainPage.find_by(title: 'Les chiffres de l’ESS en Bretagne')), position: 1},
      { title: "Les chiffres de l’ESS en France", url: main_page_path(MainPage.find_by(title: 'Les chiffres de l’ESS en France')), position: 2 }
      ] }
    ]
  }
].each do |option|
  main_page = MainPage.where(title: option[:main_page]).first
  next unless main_page.present?

  option[:menu_blocks].each do |menu_block_h|
    menu_block = main_page.menu_blocks.where(title: menu_block_h[:title]).first_or_create(position: menu_block_h[:position])
    menu_block_h[:menu_items].each do |menu_item_h|
      menu_block.menu_items.where(title: menu_item_h[:title]).first_or_create(
        url: menu_item_h[:url],
        position: menu_item_h[:position]
      )
    end
  end
end

  ## Formations
[
  { title: "Communication"},
  { title: "Mobilisation"},
  { title: "Emploi"},
  { title: "Ressources"},
].each do |option|
  FormationCategory.where(title: option[:title]).first_or_create
end
