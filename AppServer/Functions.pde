boolean isJSONValid(String str, String ends) {
  if (!str.startsWith("{") || !str.endsWith(ends))
    return false;
    
  return true;
}

void removePlayerByIp(String ip) {
  String clientid = getClientid(ip);
  
  removePlayer(clientid);
}

String getClientid(String ip) {
  return playerClientid.get(ip);
}

void removePlayer(String clientid) {
  players.remove(clientid);
}