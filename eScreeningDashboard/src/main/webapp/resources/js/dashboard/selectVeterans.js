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
      autoclose: true
		});

		$(toAssessmentDateGroup).datepicker({
			showOn : 'button',
      format: 'mm/dd/yyyy',
			autoclose: true
		});
	
		$('.id_header_tooltip').tooltip({
			'placement': 'top'
		});
		

	$('#selectedClinic').on('change', function() {
		$("#clinicId").val(this.value);
	});
	


	// Select/Deselect all vetIensCheckbox
	var selectAll = "#selectAll"
	$(selectAll).click (function () {
		 var checkedStatus = this.checked;
		$('.vetIensCheckbox').each(function () {
			$(this).prop('checked', checkedStatus);
		 });
	});
});