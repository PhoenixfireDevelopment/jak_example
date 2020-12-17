json.sEcho params[:sEcho].to_i
json.iTotalRecords Company.count
json.iTotalDisplayRecords @companies.total_count
json.set! :aaData do
  json.array! @companies, partial: 'company', as: :company
end
