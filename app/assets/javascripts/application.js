// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require bootstrap-sprockets
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require turbolinks
//= require pace/pace
//= require morris
//= require jquery.slimscroll
//= require app
//= require_tree .

jQuery(document).ready(function(){
	$('#products').DataTable( {
    columns: [
        {data: "title" },
       
    ]
	} );

	$('#metals').DataTable( {
    'bSort': true,
            'aoColumns': [
                  { sWidth: "45%", bSearchable: true, bSortable: true },                  
                  { sWidth: "10%", bSearchable: false, bSortable: true },
                  //match the number of columns here for table1
            ],
            "scrollY":        "400px",
            "scrollCollapse": false,
            "info":           true,
            "paging":         true,
         
    "fnInitComplete": function() {
    	$(":text:not([value])").css("background-color","pink");
      $('input[value="0"]').css("background-color","pink");
    }
	} );

	$('#almetals').DataTable( {
    'bSort': true,
            'aoColumns': [
                  { sWidth: "45%", bSearchable: true, bSortable: true },
                  { sWidth: "20%", bSearchable: true, bSortable: true },
                  { sWidth: "5%", bSearchable: false, bSortable: true },
                  { sWidth: "10%", bSearchable: false, bSortable: false },
                  //match the number of columns here for table1
            ],
            "scrollY":        "400px",
            "scrollCollapse": false,
            "info":           true,
            "paging":         true,
            
            "fnInitComplete": function() {
    	$(":text:not([value])").css("background-color","pink");
      $('input[value="0"]').css("background-color","pink");      
      
    },
    "drawCallback": function(settings){
              $('tr > td:even').each(function(index) {
                var scale = [['vPoor', 0], ['poor', 10000000]];
                var score = $(this).text();
                for (var i = 0; i < scale.length; i++) {
                  if (score <= scale[i][1]) {
                  $(this).addClass(scale[i][0]);
                }
              }
            });
            }
	} );

	$('#diamonds').DataTable( {
    
	} );
  $('input[value="0"]').each(function(){
    var $row = $(this).parents('tr'); 
    i = $row.find('td:eq(1) input').val();
    if(i==0){
      $row.addClass( "empty" );
      };
    

  });

  $('input[value!="0"]').each(function(){
    var $row = $(this).parents('tr'); 
    i = $row.find('td:eq(1) input').val();
    if(i>0) {
      $row.addClass( "filled" );
    };
   
  });

   

});

