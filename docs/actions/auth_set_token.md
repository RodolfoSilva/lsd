# Auth set token

With this action you could persist or delete the authenticated user credentials.
This is very useful when you want to skip the authentication when the user was
previously logged in.

The token will be sended in all request sended to the server on the header `Authorization`.

```json
{
  "action": "AuthSetToken",
  "props": {
    "token": "The access token",
    "callback": null
  }
}
```

To remove the token, just sent a empty string or a null value.

```json
{
  "action": "AuthSetToken",
  "props": {
    "token": null,
    "callback": null
  }
}
```

You could pass any other action to be executed after this action complete the main job, passing the other action in `callback`.

Note, the callback action will not block the main workflow.
