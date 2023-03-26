# Navigate

Navigate to a local screen

```json
{
  "action": "Navigate",
  "props": {
    "destination": "route://logs",
    "callback": null,
    "replace": false,
    "reset": false,
    "result": null
  }
}
```

Navigate to a new page

```json
{
  "action": "Navigate",
  "props": {
    "destination": {
      "component": "Screen",
      "body": {
        "component": "Text",
        "props": {
          "text": "Hello World"
        }
      }
    },
    "callback": null,
    "replace": false,
    "reset": false,
    "result": null
  }
}
```

Navigate back

```json
{
  "action": "Navigate",
  "props": {
    "destination": "../",
    "callback": null,
    "replace": false,
    "reset": false,
    "result": null
  }
}
```

Navigate back with some data

```json
{
  "action": "Navigate",
  "props": {
    "destination": "../",
    "callback": null,
    "replace": false,
    "reset": false,
    "result": {
      "id": 1,
      "name": "Flutter"
    }
  }
}
```

Navigate back and refresh the screen

```json
{
  "action": "Navigate",
  "props": {
    "destination": "../",
    "callback": {
      "action": "RefreshPage",
      "props": {}
    },
    "replace": false,
    "reset": false,
    "result": null
  }
}
```

You could pass any other action to be executed after this action complete the main job, passing the other action in `callback`.

Note, the callback action will not block the main workflow.
