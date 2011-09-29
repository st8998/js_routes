(function() {
  var __slice = Array.prototype.slice;
  $.buildPath = function() {
    var extraParams, lastParam, params, paramsHash, path;
    path = arguments[0],params = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    extraParams = {};
    paramsHash = {};
    if ($.isPlainObject(lastParam = params.pop())) {
      paramsHash = lastParam;
    } else {
      params.push(lastParam);
    }
    $.each(params, function(_, value) {
      var replacement;
      replacement = "/" + value;
      return path = path.replace(/\/:[\w_]+/, replacement);
    });
    $.each(paramsHash, function(name, value) {
      var pattern, replacement;
      if (path.match(new RegExp(":" + name))) {
        pattern = "(.*?)\\(([\\.\\/\\w]*?):" + name + "(\\(.*?\\)|[^\\)]*)?\\)(.*)";
        replacement = "$1$2" + value + "$3$4";
        path = path.replace(new RegExp(pattern), replacement);
        pattern = "(.*?):" + name + "(.*)";
        replacement = "$1" + value + "$2";
        return path = path.replace(new RegExp(pattern), replacement);
      } else {
        return extraParams[name] = value;
      }
    });
    path = path.replace(/\(.*\)/, '');
    if (!$.isEmptyObject(extraParams) && extraParams.anchor) {
      path += "#" + extraParams.anchor;
      delete extraParams['anchor'];
    }
    if (!$.isEmptyObject(extraParams)) {

      path += "?" + ($.param(extraParams));
    }
    return path;
  };
}).call(this);
