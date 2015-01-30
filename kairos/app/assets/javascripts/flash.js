// Flash module

var Flash = (function (module) {
    module.load = function() {
        if ((flash = $(".flash-container")).length > 0) {
            flash.click(function() {
                return $(this).fadeOut();
            });
            flash.show();
            setTimeout((function() {
                return flash.fadeOut();
            }), 5000);
        }
    };

    return module;
}(Flash || {}));