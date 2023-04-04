desc "Load users from dummyjson.com using LoadPageIntoUsersJob"
task load_dummy_json_data: [:environment] do
  LoadPageIntoUsersJob.perform_later(page: 1)
end