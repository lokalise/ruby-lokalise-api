# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Project < Base
      MAIN_PARAMS = :project_id

      delegate_call :empty, :empty_project

      delegate_call :branches
      delegate_call :branch
      delegate_call :create_branch
      delegate_call :update_branch
      delegate_call :destroy_branch
      delegate_call :merge_branch

      delegate_call :key_comment, :comment
      delegate_call :key_comments, :comments
      delegate_call :project_comments
      delegate_call :create_comments
      delegate_call :destroy_comment

      delegate_call :contributor
      delegate_call :contributors
      delegate_call :create_contributors
      delegate_call :update_contributor
      delegate_call :destroy_contributor

      delegate_call :custom_translation_status
      delegate_call :custom_translation_statuses
      delegate_call :create_custom_translation_status
      delegate_call :update_custom_translation_status
      delegate_call :destroy_custom_translation_status
      delegate_call :custom_translation_status_colors

      delegate_call :files
      delegate_call :upload_file
      delegate_call :download_files
      delegate_call :download_files_async
      delegate_call :destroy_file

      delegate_call :glossary_terms
      delegate_call :glossary_term
      delegate_call :create_glossary_terms
      delegate_call :update_glossary_terms
      delegate_call :destroy_glossary_terms

      delegate_call :create_jwt

      delegate_call :keys
      delegate_call :key
      delegate_call :create_keys
      delegate_call :update_key
      delegate_call :update_keys
      delegate_call :destroy_key
      delegate_call :destroy_keys

      delegate_call :languages, :project_languages
      delegate_call :language, :project_language
      delegate_call :create_languages, :create_project_languages
      delegate_call :update_language, :update_project_language
      delegate_call :destroy_language, :destroy_project_language

      delegate_call :queued_process
      delegate_call :queued_processes

      delegate_call :segments
      delegate_call :segment
      delegate_call :update_segment

      delegate_call :screenshots
      delegate_call :screenshot
      delegate_call :create_screenshots
      delegate_call :update_screenshot
      delegate_call :destroy_screenshot

      delegate_call :snapshots
      delegate_call :create_snapshot
      delegate_call :restore_snapshot
      delegate_call :destroy_snapshot

      delegate_call :tasks
      delegate_call :task
      delegate_call :create_task
      delegate_call :update_task
      delegate_call :destroy_task

      delegate_call :translations
      delegate_call :translation
      delegate_call :update_translation

      delegate_call :webhooks
      delegate_call :webhook
      delegate_call :create_webhook
      delegate_call :update_webhook
      delegate_call :regenerate_webhook_secret
      delegate_call :destroy_webhook
    end
  end
end
