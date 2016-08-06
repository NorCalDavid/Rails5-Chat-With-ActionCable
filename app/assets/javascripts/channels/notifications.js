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
    var options = { theme: 'NoticeBorder',
                    color: "blue",
                    position: { x: 'left',
                                y: 'bottom' },
                    offset: { x: 25,
                              y: -25 },
                    stack: true,
                    fade: 300,
                    closeOnESC: true,
                    zIndex: 99,
                    content: "You Received a New Notification" };

    new jBox('Notice', options);
  }

});

