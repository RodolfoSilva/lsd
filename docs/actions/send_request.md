# Send request

Send a `GET` request to the server.

```json
{
  "action": "SendRequest",
  "props": {
    "request": {
      "id": "fetchCustomers",
      "method": "GET",
      "url": "https://example.com/customers",
      "headers": {
        "X-Customer-Header": "Something"
      },
      "query_parameters": {
        "organization_id": "43212"
      }
    },
    "callback": null
  }
}
```

Send a `DELETE` request to the server.

```json
{
  "action": "SendRequest",
  "props": {
    "request": {
      "id": "deleteCustomer:20",
      "method": "DELETE",
      "url": "https://example.com/customers/20",
      "headers": {
        "X-Customer-Header": "Something"
      },
      "query_parameters": {
        "organization_id": "43212"
      }
    },
    "callback": null
  }
}
```

Send a `POST` request to the server.

```json
{
  "action": "SendRequest",
  "props": {
    "request": {
      "id": "createCustomer",
      "method": "POST",
      "url": "https://example.com/customers",
      "headers": {
        "X-Customer-Header": "Something"
      },
      "query_parameters": {
        "organization_id": "43212"
      },
      "data": {
        "name": "Jone Doe",
        "age": 22
      }
    },
    "callback": null
  }
}
```

Send a `PUT` request to the server.

```json
{
  "action": "SendRequest",
  "props": {
    "request": {
      "id": "updateCustomer:22",
      "method": "PUT",
      "url": "https://example.com/customers/22",
      "headers": {
        "X-Customer-Header": "Something"
      },
      "query_parameters": {
        "organization_id": "43212"
      },
      "data": {
        "name": "Jone Doe",
        "age": 22
      }
    },
    "callback": null
  }
}
```

You could pass any other action to be executed after this action complete the main job, passing the other action in `callback`.

Note, the callback action will not block the main workflow.
