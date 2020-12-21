json.sEcho params[:sEcho].to_i
json.iTotalRecords @company.leads.count
json.iTotalDisplayRecords @leads.total_count
json.set! :aaData do
  json.array! @leads, partial: 'lead', as: :lead
end
