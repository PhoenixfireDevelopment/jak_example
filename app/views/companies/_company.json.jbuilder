json.cache! [company] do
  json.name link_to(company.to_s, company)
  json.active boolean_indicator(company, :active)
  json.created_at pl(company.created_at, format: :long)
  json.updated_at pl(company.updated_at, format: :long)
  json.actions render(partial: 'companies/actions', locals: { company: company }, formats: [:html])
end
