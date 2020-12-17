json.sEcho params[:sEcho].to_i
json.iTotalRecords @company.roles.count
json.iTotalDisplayRecords @roles.total_count
json.set! :aaData do
  json.array! @roles, partial: 'role', as: :role
end
