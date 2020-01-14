module Cambada
  module V1
    module DraftingTable
      class ProjectCategoriesAPI < Grape::API
        helpers do
          def project_category_params
            declared(params, include_missing: false)[:project_category].symbolize_keys
          end
        end

        desc 'Returns all project categories'
        get '/project_categories' do
          project_categories = ::DraftingTable::ListProjectCategories.run!

          present :project_categories, project_categories, with: ::DraftingTable::ProjectCategoryEntity
        end

        desc 'Returns a specific project category'
        params do
          requires :id, type: String
        end

        get '/project_categories/:id' do
          project_category = ::DraftingTable::FindProjectCategory.run!(id: params[:id])

          present :project_category, project_category, with: ::DraftingTable::ProjectCategoryEntity, type: :detailed
        end

        desc 'Create a project category'
        params do
          requires :project_category, type: Hash do
            requires :title, type: String
          end
        end

        post '/project_categories' do
          project_category = ::DraftingTable::CreateProjectCategory.run!(attributes: project_category_params)

          present :project_category, project_category, with: ::DraftingTable::ProjectCategoryEntity, type: :detailed
        end

        desc 'Update a project category'
        params do
          requires :id, type: String
          requires :project_category, type: Hash do
            requires :title, type: String
          end
        end

        put '/project_categories/:id' do
          project_category = ::DraftingTable::UpdateProjectCategory.run!(
            id: params[:id],
            attributes: project_category_params
          )

          present :project_category, project_category, with: ::DraftingTable::ProjectCategoryEntity, type: :detailed
        end

        desc 'Destroy a project category'
        params do
          requires :id, type: String
        end

        delete '/project_categories/:id' do
          ::DraftingTable::DestroyProjectCategory.run!(id: params[:id])

          status :no_content
        end
      end
    end
  end
end
