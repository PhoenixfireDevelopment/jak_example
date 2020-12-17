json.cache! [role] do
  json.name link_to(role.to_s, [role.company, role])
  json.key role.key
  json.company link_to(role.company.to_s, role.company)
  json.created_at pl(role.created_at, format: :long)
  json.updated_at pl(role.updated_at, format: :long)
  json.actions render(partial: 'roles/actions', locals: { role: role }, formats: [:html])
end
