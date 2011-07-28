$.buildPath = (path, params...) ->
  extraParams = {}
  paramsHash = {}

  if $.isPlainObject(lastParam = params.pop()) then paramsHash = lastParam
  else params.push(lastParam)

  $.each params, (_, value) ->
    replacement = "/#{value}"
    path = path.replace /\/:[\w_]+/, replacement

  # try to insert parameters
  $.each paramsHash, (name, value) ->
    if path.match(new RegExp(":#{name}"))
      pattern = "(.*?)\\(([\\.\\/\\w]*?):#{name}(\\(.*?\\)|[^\\)]*)?\\)(.*)"
      replacement = "$1$2#{value}$3$4"
      path = path.replace new RegExp(pattern), replacement

      pattern = "(.*?):#{name}(.*)"
      replacement = "$1#{value}$2"
      path = path.replace new RegExp(pattern), replacement
    else extraParams[name] = value

  # cleanup
  path = path.replace(/\(.*\)/, '')

  # add extra params
  path += "?#{$.param(extraParams)}" unless $.isEmptyObject(extraParams)
  
  return path