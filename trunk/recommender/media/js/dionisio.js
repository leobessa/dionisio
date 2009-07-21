var dionisio = {};

dionisio.init = function(conf) {
    dionisio.conf = conf;
}

dionisio.show_user_recommendations = function(selector, url) {
    selector.children('.ajax_loader').addClass('ajax_loading');
    selector.children('.ajax_content').load(url, {}, function() {
        selector.children('.ajax_loader').removeClass('ajax_loading');

    });
};
dionisio.show_similar_users = function(selector, url) {
    selector.children('.ajax_loader').addClass('ajax_loading');
    selector.children('.ajax_content').load(url, {}, function() {
        selector.children('.ajax_loader').removeClass('ajax_loading');

    });
};
dionisio.show_best_rated = function(selector, url_service, url_rabidratings) {
    selector.children('.ajax_loader').addClass('ajax_loading');
    selector.children('.ajax_content').load(url_service, {}, function() {
        selector.children('.ajax_loader').removeClass('ajax_loading');
        // load rabid ratings code after the load of ratings
        var rating = new RabidRatings({url:url_rabidratings});
    });
};
