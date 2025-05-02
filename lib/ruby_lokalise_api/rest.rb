# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    include Utils::Loaders

    include Rest::Branches
    include Rest::Comments
    include Rest::Contributors
    include Rest::CustomTranslationStatuses
    include Rest::Files
    include Rest::GlossaryTerms
    include Rest::Jwts
    include Rest::Keys
    include Rest::Languages
    include Rest::Orders
    include Rest::PaymentCards
    include Rest::PermissionTemplates
    include Rest::Projects
    include Rest::QueuedProcesses
    include Rest::Segments
    include Rest::Screenshots
    include Rest::Snapshots
    include Rest::Tasks
    include Rest::TeamUserBillingDetails
    include Rest::Teams
    include Rest::TeamUsers
    include Rest::TeamUserGroups
    include Rest::TranslationProviders
    include Rest::Translations
    include Rest::Webhooks
  end
end
