App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  
  connected: function() {


  },

  disconnected: function() {


  },

  received: function(data) {
    $("#notifications").prepend(data.html);
    $("#notification-icon").html('notifications_active');
    $("#notification-count").html(data.count);
    $("#notification-count").show();
    notificationAlert(data.color, data.message);
  }

});

