# Dialog

```json
{
  "action": "ShowDialog",
  "props": {
    "title": {
      "component": "Text",
      "props": {
        "text": "Dialog title"
      }
    },
    "content": {
      "component": "Text",
      "props": {
        "text": "Dialog content"
      }
    },
    "actions": [
      {
        "component": "Button",
        "props": {
          "child": {
            "component": "Text",
            "props": {
              "text": "Close"
            }
          },
          "on_press": {
            "action": "Navigate",
            "props": {
              "callback": null,
              "destination": "../",
              "replace": false,
              "reset": false,
              "result": null
            }
          },
          "variant": "text"
        }
      }
    ]
  }
}
```
