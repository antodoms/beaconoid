App.messages = App.cable.subscriptions.create('GeneralReportChannel', {  
  received: function(data) {
    //console.log(data.message);
    if ($(".general-outer").length !=0){
        $(".general-outer").each(function (index,element) {
            var value = $(".general-outer:nth-child(" + (index+1) + ") .outer-layer .inner-layer-number").html();
            //console.log(index);
            $(".general-outer:nth-child(" + (index+1) + ") .outer-layer .inner-layer-number").html(parseInt(value)+data.message[index]);
        });
    }
  }
});
