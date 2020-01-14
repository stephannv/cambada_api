module Cambada
  module V1
    module DraftingTable
      class ProjectSubcategoriesAPI < Grape::API
        helpers do
          def project_subcategory_params
            declared(params, include_missing: false)[:project_subcategory].symbolize_keys
          end
        end

        desc 'Returns a specific project subcategory'
        params do
          requires :id, type: String
        end

        get '/project_subcategories/:id' do
          project_subcategory = ::DraftingTable::FindProjectSubcategory.run!(id: params[:id])

          present :project_subcategory, project_subcategory, with: ::DraftingTable::ProjectSubcategoryEntity
        end

        desc 'Create a project subcategory'
        params do
          requires :project_subcategory, type: Hash do
            requires :project_category_id, type: String
            requires :title, type: String
          end
        end

        post '/project_subcategories' do
          project_subcategory = ::DraftingTable::CreateProjectSubcategory.run!(attributes: project_subcategory_params)

          present :project_subcategory, project_subcategory, with: ::DraftingTable::ProjectSubcategoryEntity
        end

        desc 'Update a project subcategory'
        params do
          requires :id, type: String
          requires :project_subcategory, type: Hash do
            requires :title, type: String
          end
        end

        put '/project_subcategories/:id' do
          project_subcategory = ::DraftingTable::UpdateProjectSubcategory.run!(
            id: params[:id],
            attributes: project_subcategory_params
          )

          present :project_subcategory, project_subcategory, with: ::DraftingTable::ProjectSubcategoryEntity
        end

        desc 'Destroy a project subcategory'
        params do
          requires :id, type: String
        end

        delete '/project_subcategories/:id' do
          ::DraftingTable::DestroyProjectSubcategory.run!(id: params[:id])

          status :no_content
        end
      end
    end
  end
end
