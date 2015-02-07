$(".onboarding.setup_connections").ready(function() {
  var pusher = new Pusher('6d5321c29d3df32c50f4');
  var entryChannel = pusher.subscribe("private-user-" + currentUserId);
  entryChannel.bind('new-entry', function(entry) {
    switch(entry.type) {
      case "EvernoteEntry":
        appendEvernoteEntry(entry);
        break;
      case "FacebookPhotoEntry":
        appendFacebookPhotoEntry(entry);
        break;
      case "FitbitActivityEntry":
        appendFitbitActivityEntry(entry);
        break;
      case "FitbitSleepEntry":
        appendFitbitSleepEntry(entry);
        break;
      case "FitbitWeightEntry":
        appendFitbitWeightEntry(entry);
        break;
      case "GithubEntry":
        appendGithubEntry(entry);
        break;
      case "HealthGraphEntry":
        appendHealthGraphEntry(entry);
        break;
      case "InstagramEntry":
        appendInstagramEntry(entry);
        break;
      case "InstapaperEntry":
        appendInstapaperEntry(entry);
        break;
      case "LastfmEntry":
        appendLastfmEntry(entry);
        break;
      case "MovesEntry":
        appendMovesEntry(entry);
        break;
      case "PocketEntry":
        appendPocketEntry(entry);
        break;
      case "TwitterEntry":
        appendTwitterEntry(entry);
        break;
      case "WunderlistEntry":
        appendWunderlistEntry(entry);
        break;
      default:
        console.log(entry);
    }
  });

  function appendEvernoteEntry(entry) {
    $('.evernote-output').append("<div><b>" + entry.kind.charAt(0).toUpperCase() + entry.kind.slice(1) + ": </b>" + entry.title + "</div>");
  }

  function appendFacebookPhotoEntry(entry) {
    $('.facebook-output').append("<div><a target='_blank' href='" + entry.link_url + "'><img src='" + entry.medium_url + "'></a></div>");
  }

  function appendFitbitActivityEntry(entry) {
    $('.fitbit-output').append("<div> <b>Steps: </b>" + entry.steps + "<br><b>Distance: </b>" + entry.distance + "<br><b>Calories: </b>" + entry.calories + "<br><b>Active Minutes: </b>" + entry.active_minutes + "</div>");
  }

  function appendFitbitSleepEntry(entry) {
    $('.fitbit-output').append("<div> <b>Minutes Asleep: </b>" + entry.minutes_asleep + "<br><b>Minutes Awake: </b>" + entry.minutes_awake + "<br><b>Minutes to fall asleep: </b>" + entry.minutes_to_fall_asleep + "<br><b>Sleep Efficiency: </b>" + entry.efficiency + "<br><b>Times Awake: </b>" + entry.times_awake + "<br><b>Sleep Start Time: </b>" + entry.start_time + "</div>");
  }

  function appendFitbitWeightEntry(entry) {
    $('.fitbit-output').append("<div> <b>Weight: </b>" + entry.weight + entry.weight_unit + "</div>");
  }

  function appendGithubEntry(entry) {
    $('.github-output').append("<div><a target='_blank' href='" + entry.commit_url + "'>" + entry.commit_message + "</a></div>");
  }

  function appendHealthGraphEntry(entry) {
    $('.sleepcycle-output').append("<div> <b>Time Asleep: </b>" + (entry.time_asleep / 60) + "hours " + (entry.time_asleep % 60) + "minutes </div>");
  }

  function appendInstagramEntry(entry) {
    $('.instagram-output').append("<div><a target='_blank' href='" + entry.link_url + "'><img src='" + entry.thumbnail_url + "'></a></div>");
  }

  function appendInstapaperEntry(entry) {
    $('.instapaper-output').append("<div><a target='_blank' href='" + entry.url + "'>" + entry.title + "</a></div>");
  }

  function appendLastfmEntry(entry) {
    $('.lastfm-output').append("<div><a target='_blank' href='" + entry.url + "'>" + entry.artist + " - " + entry.track + "</a></div>");
  }

  function appendMovesEntry(entry) {
    var content = "";
    if (entry.activity == 'total') {
      content = "<div><b>Total Calories Burned:</b> " + entry.calories + "</div>"
    } else {
      content = "<div><b>" + entry.activity.charAt(0).toUpperCase() + entry.activity.slice(1) + "</b><br><ul><li>Distance: " + entry.distance + "m</li><li>Duration: " + (parseInt(entry.duration) / 60) + "minutes</li>"
      if (entry.calories) {
        content = content + "<li>Calories Burned: " + entry.calories + "</li>"
      }
      if (entry.steps) {
        content = content + "<li>Steps: " + entry.steps + "</li>"
      }
      content = content + "</ul></div>"
    }
    $('.moves-output').append(content);
  }

  function appendPocketEntry(entry) {
    $('.pocket-output').append("<div><a target='_blank' href='" + entry.url + "'>" + entry.title + "</a></div>");
  }

  function appendTwitterEntry(entry) {
    $('.twitter-output').append("<div><b>" + entry.kind.charAt(0).toUpperCase() + entry.kind.slice(1) + "ed: </b> <a target='_blank' href='" + entry.tweet_url + "'>" + entry.text + "</a></div>");
  }

  function appendWunderlistEntry(entry) {
    $('.wunderlist-output').append("<div><b>" + entry.kind.charAt(0).toUpperCase() + entry.kind.slice(1) + ": </b>" + entry.title + " from " + entry.list + "</div>");
  }


  $('.auth-link').on('click', function(e) {
    console.log("auth linked has been clicked");
    e.preventDefault();
    var btn = $(this);
    var service_connect = new ServiceConnect(btn.data('provider'), btn.attr('href'));
    service_connect.exec();
  })
})

var ServiceConnect = (function() {

  function ServiceConnect(provider, url) {
    this.url = url;
    this.provider = provider;
  }

  ServiceConnect.prototype.exec = function() {
    var self = this,
      params = 'location=0,status=0,width=800,height=600';

    this.service_window = window.open(this.url, this.provider + 'Window', params);

    this.interval = window.setInterval((function() {
      if (self.service_window.closed) {
        window.clearInterval(self.interval);
        self.finish();
      }
    }), 1000);

    document.cookie = this.provider + '_oauth_popup=1; path=/';
  }

  ServiceConnect.prototype.finish = function() {
    $.ajax({
      type: 'get',
      url: '/users/auth/check/' + this.provider,
      dataType: 'json',
      success: function(response) {
        if (response.authed) {
          console.log("Auth successful");
        } else {
          console.log("Auth failed");
        }
      }
    });
  };

  return ServiceConnect;
})();