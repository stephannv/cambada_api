module Cambada
  module V1
    module Catalog
      class ProjectsAPI < Grape::API
        helpers do
          def project_params
            declared(params, include_missing: false)[:project].symbolize_keys
          end
        end

        desc 'Find a project'
        params do
          requires :id, type: String
        end

        get '/projects/:id' do
          result = ::Catalog::FindProject.call(id: params[:id])

          present :project, result.project, with: ::Catalog::ProjectEntity
        end

        desc 'Create a project draft'
        params do
          requires :project, type: Hash do
            requires :project_subcategory_id, type: String
            requires :project_type, type: String, values: ::Catalog::Project.project_types.values
            requires :title, type: String
            optional :short_description, type: String
          end
        end

        post '/projects' do
          result = ::Catalog::CreateProject.call(attributes: project_params)

          present :project, result.project, with: ::Catalog::ProjectEntity
        end

        desc 'Update a project'
        params do
          requires :id, type: String
          requires :project, type: Hash do
            optional :project_subcategory_id, type: String
            optional :title
            optional :short_description
            optional :full_description
            optional :deadline
          end
        end

        put '/projects/:id' do
          result = ::Catalog::UpdateProject.call(id: params[:id], attributes: project_params)

          present :project, result.project, with: ::Catalog::ProjectEntity
        end

        desc 'Destroy a project'
        params do
          requires :id, type: String
        end

        delete '/projects/:id' do
          result = ::Catalog::DestroyProject.call(id: params[:id])

          if result.success?
            status :no_content
          else
            error!({ error: result.message }, :bad_request)
          end
        end
      end
    end
  end
end
