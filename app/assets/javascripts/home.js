var twitter_max_id = 1;
var facebook_since = 0;

// Reverse sort (newest on top)
function compare(a, b) {
  if (a['timestamp'] < b['timestamp'])
    return -1
  if (a['timestamp'] > b['timestamp'])
    return 1;
  return 0;
}

// Callback that is run when all feeds have loaded.
function feedsLoaded(twitterArgs, facebookArgs) {
  var twitter = twitterArgs[0];
  var facebook = facebookArgs[0];

  var items = [];

  if (twitter.length > 0) {
    twitter_max_id = twitter[0]['id_str'];
  }

  if (facebook.length > 0) {
    // Fb api takes unix style timestamps.
    facebook_since = Date.parse(facebook[0]['created_time'])/1000;
  }

  $.each(twitter, function(key, value) {
    var item = {};
    item['timestamp'] = Date.parse(value['created_at']);
  
    item['content'] = $('<li/>', {class : 'tweet'})
                        .append($('<img/>', {class : 'avatar', src : value['user']['profile_image_url']}))
                        .append($('<span/>')
                          .append($('<div/>', {class : 'username', text : value['user']['screen_name']}))
                          .append($('<div/>', {class : 'text', text : value['text']})));

    items.push(item);
  });

  $.each(facebook, function(key, value) {
    if (value['type'] == 'status') {
      var item = {};
      item['timestamp'] = Date.parse(value['created_time']);

      item['content'] = $('<li/>', {class : 'fb'})
                          .append($('<img/>', {class : 'avatar', src : 'http://graph.facebook.com/' + value['from']['id'] + '/picture'}))
                          .append($('<div/>', {class : 'username', text : value['from']['name']}))
                          .append($('<div/>', {class : 'text', text : value['message']}));

      items.push(item);
    }
  });
  
  // Sort all feed items by timestamp. Eventually merge sort the lists to be more efficient.
  items.sort(compare);

  // Prepend any new items to the front of the list.
  $.each(items, function(index, item) {
    $('#feed').prepend(item.content);
  });
}

// Asynchronously get json feeds.
function refreshFeed() {
  $.when(
    $.getJSON('/api/twitter_user_timeline.json?since_id=' + twitter_max_id, function(data) {
      return data;
    }),
    $.getJSON('/api/facebook_feed.json?since=' + facebook_since, function(data) {
      return data;
    }
  )).done(feedsLoaded);
}

$(document).ready(function() {
  // Refresh feed when document is loaded.
  refreshFeed();

  $("#refresh_button").click(refreshFeed);

  // The 'r' key refreshes the feed.
  $(document).bind('keydown', 'r', refreshFeed);
});

