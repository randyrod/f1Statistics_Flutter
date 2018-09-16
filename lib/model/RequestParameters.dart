class RequestParameters
{
  RequestTypeEnum requestType;
  String url;

  RequestParameters(this.requestType, this.url);
}

enum RequestTypeEnum
{
  Get, Post, Put, Delete
}