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
    successMessage();
  }

});

function successMessage() {
  sweetAlert({ title: "Success", 
                html: '<h2>You Have Received a New Notification!</h2>' +
                      '<br />',   
                type: "success",
              timmer: 2000 });
};
