# notion

`noppefoxwolf/notion` is a notion.so API library written in `swift`.

# Usage

```swift
let session = Session.shared
session.setAuthorization(token: "<<AUTHORIZE TOKEN>>")
session.send(V1.Users.List()).sink { result in
    // DO SOMETHING
}.store(in: &cancellables)
```

# Features

## integration

- [x] internal integration
- [ ] public integration

## 


# API Documents

[Start building with the Notion API](https://developers.notion.com)

# Author

[noppe](https://noppe.dev)