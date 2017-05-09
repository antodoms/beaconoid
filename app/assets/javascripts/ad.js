var cateogry = document.getElementById('category');
document.getElementById('adCategory').innerHTML = category.options[category.selectedIndex].text;

var description = $('#description').val();
document.getElementById('adDescription').innerHTML = description;

var price = $('#price').val();
document.getElementById('adPrice').innerHTML = price;


function update()
{
    var name = $('#category').val();
	document.getElementById('adCategory').innerHTML = name;

	var description = $('#description').val();
	document.getElementById('adDescription').innerHTML = description;

	var price = $('#price').val();
	document.getElementById('adPrice').innerHTML = price;

}

$(document).ready(function(){
    $('#category').change(function(){ update(); });
    $('#description').change(function(){ update(); });
    $('#price').change(function() { update(); })

});
