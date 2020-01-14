SimpleCov.start do
  add_group 'Models', 'app/models'
  add_group 'API', 'app/api'
  add_group 'Mutations', 'app/mutations'
  add_group 'Entities', 'app/entities'

  add_filter 'config'
  add_filter 'spec'
  add_filter 'app/jobs'
  add_filter 'app/channels'
  add_filter 'app/mailers'
end
