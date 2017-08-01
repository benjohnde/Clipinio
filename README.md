# Clipinio

Lightweight clipboard manager for OS X.

<img align="right" src="Sketch/Clipinio.png">

## TODO

- [ ] Add the possibility of customizing max entries and hotkeys.
- [ ] Add persistency (e.g. restore entries after reboot).
- [ ] Create app store icon
- [ ] Test feasibility pasteboard observer / hotkey interceptor in sandbox mode
- [ ] Submit to mac app store

## Usage

Press `CMD` + `C` to copy, and `CMD` + `SHIFT` + `V` to insert a clip via Clipinio. The hotkeys are hardcoded. If demanded, I will add a menu for customizing the keys.

## Build

```bash
sh build.sh
```

It automatically copies Clipinio to `/Applications/Clipinio.app`. Enjoy!

## Additional information

> I used to utilize ClipMenu as daily clipboard manager. As the recent version lacks of access to the source code I decided to switch. Thus, I bought two clipboard manager from the App Store. Both did not work as expected...so I wrote my own kind implementation of a lightweight clipboard manager. It has been written in Swift as an introduction. This is nothing real awesome. Just fits my daily use case. If anyone cares: I did not invoke the old carbon api as it felt unswifty implementing it. The disadvantage of this approach is that one is not able to consume hotkey events but to receive a copy of these. Meaning the hotkey event is dispatched to the current application.

### Update

> As of now I am using the old Carbon API, hence being able to consume the events. It is also much faster now and feels more like the old ClipMenu. It was also not that unswifty to implement.
