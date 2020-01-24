module Cambada
  module V1
    module Catalog
      class ProjectCategoriesAPI < Grape::API
        helpers do
          def project_category_params
            declared(params, include_missing: false)[:project_category].symbolize_keys
          end
        end

        desc 'Returns all project categories'
        get '/project_categories' do
          result = ::Catalog::ListProjectCategories.call

          present :project_categories, result.project_categories, with: ::Catalog::ProjectCategoryEntity
        end

        desc 'Returns a specific project category'
        params do
          requires :id, type: String
        end

        get '/project_categories/:id' do
          result = ::Catalog::FindProjectCategory.call(id: params[:id])

          present :project_category, result.project_category, with: ::Catalog::ProjectCategoryEntity, type: :detailed
        end

        desc 'Create a project category'
        params do
          requires :project_category, type: Hash do
            requires :title, type: String
          end
        end

        post '/project_categories' do
          result = ::Catalog::CreateProjectCategory.call(attributes: project_category_params)

          present :project_category, result.project_category, with: ::Catalog::ProjectCategoryEntity, type: :detailed
        end

        desc 'Update a project category'
        params do
          requires :id, type: String
          requires :project_category, type: Hash do
            requires :title, type: String
          end
        end

        put '/project_categories/:id' do
          result = ::Catalog::UpdateProjectCategory.call(id: params[:id], attributes: project_category_params)

          present :project_category, result.project_category, with: ::Catalog::ProjectCategoryEntity, type: :detailed
        end

        desc 'Destroy a project category'
        params do
          requires :id, type: String
        end

        delete '/project_categories/:id' do
          ::Catalog::DestroyProjectCategory.call(id: params[:id])

          status :no_content
        end
      end
    end
  end
end
