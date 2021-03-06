jQuery ->
  $('#application_layout #companies_index_table').dataTable
    iDisplayLength: $("#application_layout #companies_index_table").data("displayLength")
    aLengthMenu: [[10, 25, 50, 100], ["10", "25", "50", "100"]]
    sPaginationType: "full_numbers"
    paging: true,
    autoWidth: false
    bJQueryUI: true
    bPaginate: true
    sAjaxSource: $('#application_layout #companies_index_table').data('source')
    responsive: true
    aoColumns: [
      { mData: 'name' },
      { mData: 'active' },
      { mData: 'created_at' },
      { mData: 'updated_at' },
      { mData: 'actions' },
    ]
    aoColumnDefs: [{
        bSortable: false,
        aTargets: ['nosort']
    }]
