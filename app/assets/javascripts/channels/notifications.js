App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  
  connected: function() {


  },

  disconnected: function() {


  },

  received: function(data) {
  	console.log(data);
  	$("#notifications").prepend(data.html);
  }

});
