App.messages = App.cable.subscriptions.create('StoreFetchChannel', {  
  received: function(data) {
    if($("#chart-1").length !=0){
        var chart = Chartkick.charts["chart-1"];
        var chart_data = chart.dataSource;
        var store_changed = data.message;

        for(count = 0; count < chart_data.length; count++){
            if (chart_data[count][2] == store_changed){
            	chart_data[count][1] = chart_data[count][1] + 1;
            }
        }
        chart_data.sort(function(a, b){return b[1]-a[1]});
        chart.updateData(chart_data);
    }
  }
});