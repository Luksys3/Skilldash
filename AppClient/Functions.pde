boolean isJSONValid(String str, String ends) {
  if (!str.startsWith("{") || !str.endsWith(ends))
    return false;
    
  return true;
}