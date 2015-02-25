$(document).ready(function() {
    // Load current tab
    tabsLoad("createBattery");

	//var timestamp = "1392822000000";
	//new Date(unixTime*1000);
	
	///alert("timestamp" + timestamp);
	//alert("D" + jsDate.toDateString());
	//alert("M" + jsDate.getMonth());
	//alert("Y" + jsDate.getYear());
		
    // Date Picker Start - Call picker and focus for 508         
    var fromAssessmentDateGroup  = "#fromAssessmentDateGroup";
    var toAssessmentDateGroup    = "#toAssessmentDateGroup";
    $(fromAssessmentDateGroup).datepicker({
			showOn : 'button',
      format: 'mm/dd/yyyy',
			autoclose: true,
			startDate: 'd'
		});

		$(toAssessmentDateGroup).datepicker({
			showOn : 'button',
      format: 'mm/dd/yyyy',
			autoclose: true,
			startDate: 'd'
		});

		$('.id_header_tooltip').tooltip({
			'placement': 'top'
		});

		$('#selectedClinic').on('change', function() {
			$("#clinicId").val(this.value);
		});
	
		// Select/Deselect all vetIensCheckbox
		var selectAll = "#selectAll";
		var vetIensCheckbox = ".vetIensCheckbox";
		
		$(selectAll).click (function () {
			 var checkedStatus = this.checked;
			$(vetIensCheckbox).each(function () {
				$(this).prop('checked', checkedStatus);
			 });
		});


	$("#startDate").on("change focusout input", function() {
			var date = $('#startDate').val();
			var endDate 	= $('#endDate').val();
			date = vDate(date);
	
			if (date < new Date()  || date > vDate(endDate)) {
				$(".startDateError").removeClass("hide");
			}else{
				$(".startDateError").addClass("hide");
			}
	});

	$("#endDate").on("change focusout input", function() {
			var date 		= $('#endDate').val();
			var startDate 	= $('#startDate').val();
			date = vDate(date);
			console.log("startDate" );
			console.log(startDate);
			
			if (date < new Date() || date < vDate(startDate)) {
				$(".endDateError").removeClass("hide");
			}else{
				$(".endDateError").addClass("hide");
			}
	});


	function vDate(date){
		var parts = date.split('/');
		var date = new Date(parseInt(parts[2], 10),     // year
							parseInt(parts[1], 10) - 1, // month, starts with 0
							parseInt(parts[0], 10));    // day
		return date;
	}

								
});