# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Tie our new resource into Datatables
jQuery ->
  $('#application_layout #leads_index_table').dataTable
    iDisplayLength: $("#application_layout #leads_index_table").data("displayLength")
    aLengthMenu: [[10, 25, 50, 100], ["10", "25", "50", "100"]]
    sPaginationType: "full_numbers"
    paging: true,
    autoWidth: false
    bJQueryUI: true
    bPaginate: true
    sAjaxSource: $('#application_layout #leads_index_table').data('source')
    responsive: true
    aoColumns: [
      { mData: 'name'},
      { mData: 'assignable'},
      { mData: 'company'},
      { mData: 'created_at' },
      { mData: 'updated_at' },
      { mData: 'actions' }
    ]
    aoColumnDefs: [{
        bSortable: false,
        aTargets: ['nosort']
    }]

    initComplete: ->
      # Assignable
      assignable_column = @api().columns('.assignable')
      $ele = $("form#leads_search_filter select#search_filter_assignable").on 'change', ->
        val = $.fn.dataTable.util.escapeRegex($(this).val())
        assignable_column.search( val ? '^'+val+'$' : '', true, false ).draw()
        return
