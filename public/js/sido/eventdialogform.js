// alert form, create form in a dialog. for event

$(document).ready(function () {
	
	// if user resize the window, call the same function again
	// to make sure the overlay fills the screen and dialogbox aligned to center	
	$(window).resize(function () {
		
		//only do it if the dialog box is not hidden
		if (!$('#dialog-box').is(':hidden')) popup();		
	});
	
});

//show a popup
function popup(message) {
		
	// get the screen height and width  
	var maskHeight = $(window).height();  
	var maskWidth = $(window).width();
	
	// calculate the values for center alignment
	var dialogTop =  (maskHeight/3) - ($('#dialog-box').height()/2);  
	var dialogLeft = (maskWidth/2) - ($('#dialog-box').width()/2); 
	
	// assign values to the overlay and dialog box
	$('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
	$('#dialog-box').css({top:dialogTop, left:dialogLeft}).show();
	
	//add the date picker
	$('.date-pick').datePicker(
       	{
			startDate: '01/01/1970',
			endDate: (new Date()).asString()
		});
}

//Valid form
function validform(form) {
  //valid name :> != ""
  var name = form.name.value;
  if(name == "") {
    form.name.style.backgroundColor = "#e33100";
    return false;
  }
  form.name.style.backgroundColor = 'white';
  
  //valid date :> NN/NN/NNNN
  var dateRegex = "^[0-9]{2}[/]{1}[0-9]{2}[/]{1}[0-9]{4}$";
  var date = form.date.value;
  if(!date.match(dateRegex)) {
    form.date.style.backgroundColor = '#e33100';
    return false;
  }
  form.date.style.backgroundColor = 'white';
  //if OK valid
  return true;
}

