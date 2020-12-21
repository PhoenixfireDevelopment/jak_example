json.cache! [lead] do
  json.name link_to(lead.to_s, [lead.company, lead])
  json.assignable lead.assignable.to_s
  json.company link_to(lead.company.to_s, lead.company)
  json.created_at pl(lead.created_at, format: :long)
  json.updated_at pl(lead.updated_at, format: :long)
  json.actions render(partial: 'leads/actions', locals: { lead: lead }, formats: [:html])
end
